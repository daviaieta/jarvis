#!/bin/zsh
# Prepara um vídeo do iPhone (ou do CapCut) para editar. Etapa 1 do método; regras T1, T2 e o item 10 do método.
#   - guarda o original (não toca nele)
#   - HDR -> SDR bt709 com o conversor da Apple (avconvert), só no Mac
#   - vertical (9:16): 1080x1920; outro formato (tela gravada, horizontal, 3:4): mantém o formato e avisa
#     (quem decide onde ele entra é o plano; regra T6)
#   - 30 qps constante, keyframe a cada 1 s, CRF 15, áudio AAC 48 kHz
#   - áudio 16 kHz mono para medir energia e transcrever
#   - transcrição palavra por palavra com o Whisper large-v3, em português
#
# Só Mac (zsh, avconvert). Rode com o caminho completo: ~/.claude/skills/edicao-video/ferramentas/preparar.sh
# uso: preparar.sh <video-original> <pasta-de-trabalho>
#      a pasta de trabalho fica FORA do iCloud (ex.: ~/Edicao/videos/2026-11-10-tema)
# saída: <pasta>/fonte/<nome>_30.mp4, <nome>_16k.wav, <nome>_words.json
set -e
ORIG="$1"; PASTA="$2"
[[ -f "$ORIG" && -n "$PASTA" ]] || { echo "uso: preparar.sh <video> <pasta-de-trabalho>"; exit 1; }
case "$PASTA" in *Mobile\ Documents*|*/Documents/*|*/Desktop/*) echo "AVISO: a pasta parece estar no iCloud (Documents/Mesa). Use ~/Edicao/videos/…"; exit 1;; esac
mkdir -p "$PASTA/fonte"
NOME=$(basename "${ORIG%.*}")
OUT="$PASTA/fonte/${NOME}_30.mp4"
MODELO=${WHISPER_MODELO:-$HOME/.cache/hyperframes/whisper/models/ggml-large-v3.bin}

echo "== disco"; df -h /System/Volumes/Data 2>/dev/null | tail -1 || df -h ~ | tail -1

W=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$ORIG")
H=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$ORIG")
ROT=$(ffprobe -v error -select_streams v:0 -show_entries stream_side_data=rotation -of csv=p=0 "$ORIG" | head -1)
[[ "$ROT" == "90" || "$ROT" == "-90" || "$ROT" == "270" || "$ROT" == "-270" ]] && { T=$W; W=$H; H=$T; }
if python3 -c "import sys; w,h=$W,$H; sys.exit(0 if abs(w/h-9/16)<0.02 else 1)"; then
  GEOM="scale=1080:1920"
  echo "== formato: ${W}x${H} (vertical 9:16)"
else
  GEOM="scale=trunc(iw/2)*2:trunc(ih/2)*2"
  echo "== AVISO formato: ${W}x${H} não é 9:16. Mantive o formato (nada cortado); o plano decide como ele entra no vertical."
fi

TRC=$(ffprobe -v error -select_streams v:0 -show_entries stream=color_transfer -of csv=p=0 "$ORIG")
echo "== transferência de cor: ${TRC:-desconhecida}"
FONTE="$ORIG"; TMP=""
if [[ "$TRC" == "arib-std-b67" || "$TRC" == "smpte2084" ]]; then
  echo "== HDR detectado"
  if command -v avconvert >/dev/null; then
    TMP="$PASTA/fonte/${NOME}_sdr_tmp.mov"
    avconvert -s "$ORIG" -o "$TMP" -p PresetHighestQuality --replace
    FONTE="$TMP"
    VF="$GEOM,fps=30,setparams=color_primaries=bt709:color_trc=bt709:colorspace=bt709"
  else
    echo "   sem avconvert (não é Mac): tonemap no ffmpeg (precisa de zscale)"
    VF="zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p,$GEOM,fps=30"
  fi
else
  VF="$GEOM,fps=30,setparams=color_primaries=bt709:color_trc=bt709:colorspace=bt709"
fi

echo "== convertendo para $OUT"
ffmpeg -y -loglevel error -i "$FONTE" -vf "$VF" \
  -c:v libx264 -preset medium -crf 15 -g 30 -keyint_min 30 -sc_threshold 0 -pix_fmt yuv420p \
  -color_primaries bt709 -color_trc bt709 -colorspace bt709 \
  -c:a aac -ar 48000 -b:a 256k -movflags +faststart "$OUT"
[[ -n "$TMP" ]] && mv "$TMP" ~/.Trash/ 2>/dev/null || true

ffmpeg -y -loglevel error -i "$OUT" -ac 1 -ar 16000 -c:a pcm_s16le "$PASTA/fonte/${NOME}_16k.wav"

echo "== loudness do original (alvo final: -14 LUFS)"
ffmpeg -hide_banner -nostats -i "$OUT" -af ebur128 -f null - 2>&1 | grep -E "^\s+I:" | tail -1

TAM=$( [[ -f "$MODELO" ]] && stat -f %z "$MODELO" 2>/dev/null || echo 0 )
if command -v whisper-cli >/dev/null && (( TAM > 3000000000 )); then
  echo "== transcrevendo (large-v3, pt) — pode levar alguns minutos"
  if whisper-cli -m "$MODELO" -l pt -f "$PASTA/fonte/${NOME}_16k.wav" --max-len 1 --split-on-word -ojf \
       -of "$PASTA/fonte/${NOME}_words" > "$PASTA/fonte/whisper.log" 2>&1; then
    echo "   ok: fonte/${NOME}_words.json"
  else
    echo "== ERRO no Whisper. Últimas linhas de fonte/whisper.log:"; tail -5 "$PASTA/fonte/whisper.log"; exit 1
  fi
elif (( TAM > 0 && TAM <= 3000000000 )); then
  echo "== PULEI a transcrição: o modelo está incompleto ($TAM bytes; o large-v3 tem uns 3,1 GB). Termine o download com curl -C - (o README do pacote explica o download do modelo)."
else
  echo "== PULEI a transcrição: falta whisper-cli (brew install whisper-cpp) ou o modelo em $MODELO"
fi
echo "== pronto: $OUT"
