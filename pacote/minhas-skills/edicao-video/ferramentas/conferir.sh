#!/bin/zsh
# Conferência técnica do render (etapa 6 e checklist "Pronto para postar", item 4 e 6).
# Diz OK ou FALHA em cada item da exportação do método.
#
# uso: conferir.sh <render.mp4>
IN="$1"; [[ -f "$IN" ]] || { echo "uso: conferir.sh <video>"; exit 1; }
p() { ffprobe -v error -select_streams "$1" -show_entries "$2" -of default=nw=1:nk=1 "$IN" | head -1; }
ok() { [[ "$2" == "$3" ]] && echo "OK     $1: $2" || echo "FALHA  $1: $2 (esperado $3)"; }
ok "codec"        "$(p v:0 stream=codec_name)" "h264"
ok "largura"      "$(p v:0 stream=width)" "1080"
ok "altura"       "$(p v:0 stream=height)" "1920"
ok "pix_fmt"      "$(p v:0 stream=pix_fmt)" "yuv420p"
CP=$(p v:0 stream=color_primaries); CT=$(p v:0 stream=color_transfer); CS=$(p v:0 stream=color_space)
if [[ "$CP$CT$CS" == "bt709bt709bt709" ]]; then echo "OK     cor: bt709 (primaries, transfer, matrix)"
else echo "FALHA  cor: primaries=$CP transfer=$CT matrix=$CS (esperado bt709 nos três)"
     echo "       corrigir sem recomprimir: ffmpeg -i entrada.mp4 -c copy -bsf:v h264_metadata=colour_primaries=1:transfer_characteristics=1:matrix_coefficients=1 -movflags +faststart saida.mp4"; fi
R=$(p v:0 stream=r_frame_rate); A=$(p v:0 stream=avg_frame_rate)
[[ "$R" == "$A" ]] && echo "OK     taxa constante: $R" || echo "FALHA  taxa variável: r=$R avg=$A"
ok "áudio"        "$(p a:0 stream=codec_name)" "aac"
ok "amostragem"   "$(p a:0 stream=sample_rate)" "48000"
head -c 200000 "$IN" | grep -q moov && echo "OK     faststart" || echo "FALHA  faststart (moov no fim)"
DV=$(ffprobe -v error -select_streams v:0 -show_entries stream=duration -of csv=p=0 "$IN"); DA=$(ffprobe -v error -select_streams a:0 -show_entries stream=duration -of csv=p=0 "$IN")
python3 -c "import sys; d=abs($DV-$DA); print(('OK    ' if d<=0.1 else 'FALHA ')+f' áudio x vídeo: diferença de {d:.2f} s')"
echo "--     duração: $(p v:0 format=duration 2>/dev/null || ffprobe -v error -show_entries format=duration -of csv=p=0 "$IN") s"
L=$(ffmpeg -hide_banner -nostats -i "$IN" -af ebur128=peak=true -f null - 2>&1)
I=$(echo "$L" | grep -E "^\s+I:" | tail -1 | awk '{print $2}')
PK=$(echo "$L" | grep -E "^\s+Peak:" | tail -1 | awk '{print $2}')
python3 - "$I" "$PK" <<'EOF'
import sys
i, pk = float(sys.argv[1]), float(sys.argv[2])
print(("OK    " if abs(i + 14) <= 1 else "FALHA ") + f" loudness: {i} LUFS (alvo -14 ±1)")
print(("OK    " if pk <= -1 else "FALHA ") + f" pico: {pk} dBFS (até -1)")
if abs(i + 14) > 1 or pk > -1:
    print("       corrigir: loudnorm.sh entrada.mp4 saida.mp4   (SO=1 se a voz já foi tratada ou há música)")
EOF
B=$(ffmpeg -hide_banner -nostats -i "$IN" -vf blackdetect=d=0.1:pix_th=0.05 -an -f null - 2>&1 | grep -c black_start)
[[ "$B" == "0" ]] && echo "OK     sem quadro preto" || echo "FALHA  $B trecho(s) preto(s): rode blackdetect para ver onde"
F=$(ffmpeg -hide_banner -nostats -i "$IN" -vf freezedetect=n=0.001:d=1 -an -f null - 2>&1 | grep -c freeze_start)
[[ "$F" == "0" ]] && echo "OK     sem quadro congelado (>1 s)" || echo "AVISO  $F trecho(s) parado(s) >1 s: confira se é de propósito"
