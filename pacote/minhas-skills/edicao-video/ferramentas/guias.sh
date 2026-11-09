#!/bin/zsh
# Área segura desenhada por cima (regra L4): extrai quadros nos tempos pedidos com as guias do Reels
# (x 80–940, y 240–1480 em vermelho) e uma folha com todos lado a lado para olhar de uma vez.
# Nos stories, use STORY=1: 250 px livres em cima e 340 embaixo.
#
# uso: guias.sh <video.mp4> <pasta-saida> <t1> <t2> ...        (tempos em segundos, onde há texto ou logo)
set -e
IN="$1"; OUT="$2"; shift 2
[[ -f "$IN" && $# -gt 0 ]] || { echo "uso: guias.sh <video> <pasta> <t1> [t2 ...]"; exit 1; }
mkdir -p "$OUT"; rm -f "$OUT"/guia_*.png(N) "$OUT"/folha_guias.png
if [[ -n "$STORY" ]]; then Y0=250; Y1=1580; else Y0=240; Y1=1480; fi
BOX="drawbox=x=80:y=${Y0}:w=860:h=$((Y1-Y0)):color=red@0.9:t=4,drawbox=x=0:y=0:w=1080:h=${Y0}:color=red@0.18:t=fill,drawbox=x=0:y=${Y1}:w=1080:h=$((1920-Y1)):color=red@0.18:t=fill,drawbox=x=940:y=0:w=140:h=1920:color=red@0.18:t=fill,drawbox=x=0:y=0:w=80:h=1920:color=red@0.18:t=fill"
i=0
for t in "$@"; do
  i=$((i+1))
  ffmpeg -y -loglevel error -ss "$t" -i "$IN" -frames:v 1 -vf "$BOX,drawtext=text='$t s':x=90:y=$((Y0+10)):fontsize=48:fontcolor=red:box=1:boxcolor=white@0.8" "$OUT/guia_$(printf %02d $i).png" 2>/dev/null \
  || ffmpeg -y -loglevel error -ss "$t" -i "$IN" -frames:v 1 -vf "$BOX" "$OUT/guia_$(printf %02d $i).png"
done
COLS=$(( i < 4 ? i : 4 ))
ffmpeg -y -loglevel error -pattern_type glob -i "$OUT/guia_*.png" -vf "scale=360:-1,tile=${COLS}x$(( (i+COLS-1)/COLS ))" -frames:v 1 "$OUT/folha_guias.png"
echo "== $i quadros em $OUT (folha: folha_guias.png). Tudo que é texto ou logo tem de ficar dentro do retângulo vermelho."
