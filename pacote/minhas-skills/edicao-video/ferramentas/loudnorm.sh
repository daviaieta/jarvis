#!/bin/zsh
# Áudio final (etapa 5, regra A1): passa-alta 80 Hz, compressão leve e loudnorm em DUAS passadas para -14 LUFS,
# pico -1,5 dBTP (o AAC sobe o pico uns décimos; -1,5 garante o -1 do checklist). O vídeo é copiado sem recompressão.
# SO=1: só o loudnorm, sem passa-alta e compressor (use quando a voz já foi tratada antes ou há música no arquivo).
# Duas vozes desniveladas? Nivele antes, por trecho (regra A2).
#
# uso: loudnorm.sh <entrada.mp4> <saida.mp4> [alvo_LUFS]
set -e
IN="$1"; OUT="$2"; ALVO="${3:--14}"
[[ -f "$IN" && -n "$OUT" ]] || { echo "uso: loudnorm.sh <entrada> <saida> [alvo]"; exit 1; }
if [[ -n "$SO" ]]; then PRE="anull"; else PRE="highpass=f=80,acompressor=threshold=-20dB:ratio=2.5:attack=10:release=200:makeup=2"; fi
J=$(ffmpeg -hide_banner -nostats -i "$IN" -af "$PRE,loudnorm=I=$ALVO:TP=-1.5:LRA=11:print_format=json" -f null - 2>&1 | sed -n '/^{/,/^}/p')
v() { echo "$J" | python3 -c "import json,sys;print(json.load(sys.stdin)['$1'])"; }
ffmpeg -y -loglevel error -i "$IN" -c:v copy \
  -af "$PRE,loudnorm=I=$ALVO:TP=-1.5:LRA=11:measured_I=$(v input_i):measured_TP=$(v input_tp):measured_LRA=$(v input_lra):measured_thresh=$(v input_thresh):offset=$(v target_offset):linear=true" \
  -c:a aac -ar 48000 -b:a 256k -movflags +faststart "$OUT"
echo "== depois:"; ffmpeg -hide_banner -nostats -i "$OUT" -af ebur128=peak=true -f null - 2>&1 | grep -E "^\s+(I|Peak):" | tail -2
