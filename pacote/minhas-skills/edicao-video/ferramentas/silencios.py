"""Silêncios, pausas e o ponto de menor energia de cada emenda, medidos na ENERGIA do áudio (regras T3 e T4).

O Whisper estica a última palavra e esconde a pausa; a energia não mente. Só precisa de python3 e ffmpeg (sem numpy).

uso (de qualquer pasta):
  python3 silencios.py <audio_16k.wav>                       lista as pausas >= 0,35 s
  python3 silencios.py <audio_16k.wav> --min 0.2 --acima 8   pausa = até 8 dB acima do piso de ruído (padrão 10)
  python3 silencios.py <audio_16k.wav> --db -42              limiar fixo em dBFS, no lugar do relativo
  python3 silencios.py <audio_16k.wav> --emendas 12.4 30.1   para cada tempo, o quadro (30 qps) de menor energia em ±0,15 s
                                                             (t:janela muda a janela, ex.: 30.1:0.3)
Atenção: pausa medida não é corte decidido. Respiro de tensão (C6) e reação (C4) ficam; a tabela de cortes diz quais.
"""
import argparse, math, subprocess, sys
from array import array

ap = argparse.ArgumentParser()
ap.add_argument("audio")
ap.add_argument("--min", type=float, default=0.35, help="pausa mínima em segundos")
ap.add_argument("--acima", type=float, default=10.0, help="dB acima do piso de ruído que ainda contam como silêncio")
ap.add_argument("--db", type=float, default=None, help="limiar fixo em dBFS (substitui o relativo)")
ap.add_argument("--fps", type=float, default=30.0)
ap.add_argument("--emendas", nargs="*")
a = ap.parse_args()

raw = subprocess.run(["ffmpeg", "-loglevel", "error", "-i", a.audio, "-f", "s16le", "-ac", "1", "-ar", "16000", "-"],
                     capture_output=True, check=True).stdout
x = array("h"); x.frombytes(raw[: len(raw) // 2 * 2])
if sys.byteorder == "big":
    x.byteswap()
WIN = 160  # 10 ms
n = len(x) // WIN
if n == 0:
    sys.exit("áudio vazio")
db = []
for k in range(n):
    s = 0
    for v in x[k * WIN:(k + 1) * WIN]:
        s += v * v
    db.append(10 * math.log10(s / WIN / 32768 ** 2 + 1e-12))
dur = n / 100
q = lambda t: round(round(t * a.fps) / a.fps, 3)

if a.emendas:
    print("tempo   -> quadro   energia   (min/max na janela)")
    for arg in a.emendas:
        t, r = (arg.split(":") + ["0.15"])[:2]
        t, r = float(t), float(r)
        if not 0 <= t <= dur:
            print(f"{t:7.2f}    fora do áudio (0 a {dur:.2f} s)"); continue
        i0, i1 = max(0, int((t - r) * 100)), min(n, max(int((t + r) * 100), int((t - r) * 100) + 1))
        seg = db[i0:i1]; mn = min(seg)
        perto = [i0 + j for j, v in enumerate(seg) if v <= mn + 3]          # quase tão baixo quanto o mínimo…
        i = min(perto, key=lambda k: abs(k - t * 100))                      # …e o mais perto do tempo pedido
        print(f"{t:7.2f} -> {q(i / 100):7.3f}  {db[i]:6.1f} dB  ({mn:.1f}/{max(seg):.1f})")
    sys.exit()

if a.db is None:
    piso = sorted(db)[int(len(db) * 0.05)]          # 5 % mais baixos = piso de ruído do lugar
    limiar = max(piso + a.acima, -60.0)              # piso digital (-120) não pode baixar o limiar demais
    origem = f"piso {piso:.1f} dB + {a.acima:g}, mínimo -60"
else:
    limiar, origem = a.db, "fixo"
pausas, ini = [], None
for i, v in enumerate(db + [0.0]):
    if v < limiar and ini is None:
        ini = i
    elif v >= limiar and ini is not None:
        if (i - ini) / 100 >= a.min:
            pausas.append((ini / 100, i / 100, max(db[ini:i])))
        ini = None

print(f"duração {dur:.2f} s · limiar {limiar:.1f} dB ({origem}) · pausa mínima {a.min} s · {len(pausas)} pausas")
print("#   início    fim   duração   pico na pausa")
for k, (s, e, pk) in enumerate(pausas, 1):
    print(f"{k:<3} {s:7.2f} {e:7.2f}  {e - s:6.2f} s   {pk:6.1f} dB")
