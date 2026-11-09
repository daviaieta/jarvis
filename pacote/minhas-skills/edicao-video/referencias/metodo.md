# Método de Edição de Vídeo

Como o Davi Aieta edita vídeo curto com o Claude desde 14/out/2026, escrito para o Jarvis. Vem do guia grátis
"Edite Reels com IA", do Luka (@lukachoi_), encaixado no que o Davi já fazia e afinado em dezenas de versões reais.

## A ideia central

> A ferramenta é a mesma para todo mundo. O contexto não.

Três arquivos que a IA lê antes de tocar em qualquer vídeo, e um que cresce a cada correção:

| Arquivo | O que guarda |
|---|---|
| a voz da pessoa (nota de voz do cofre) | quem ela é, para quem fala, como fala |
| `Sistema/Estilo de Edição.md` | como o vídeo parece: legenda, cor, ritmo, elementos |
| `Sistema/Regras de Edição.md` | cada correção aprovada, com o porquê (o que cresce) |

O ganho é cumulativo: cada ajuste que fica escrito encurta a edição seguinte.

## A esteira

| # | Etapa | O que sai | Ok da pessoa |
|---|---|---|---|
| 0 | Contexto | lê voz, estilo e regras; estilo vazio = ficha de referência antes | — |
| 1 | Preparar e decupar | vídeo convertido (HDR→SDR, H.264, 30 qps constante), transcrição palavra por palavra, **tabela de cortes** com tempo | a tabela |
| 2 | Plano | gancho falado + texto da primeira tela; tabela fala × tela × som; mapa de mudança; capa; final e chamada | o plano |
| 3 | Montar | A-roll cortado com a voz já tratada (passa-alta, compressão, vozes niveladas) → composição no preview (HyperFrames); legenda revisada contra o glossário | — |
| 4 | Revisar | correção com o segundo exato; cada uma vira regra (`global` ou `só este vídeo`) | cada ajuste |
| 5 | Render `vNN` | no Terminal com log; exportação abaixo | — |
| 6 | Conferir | no arquivo renderizado: `conferir.sh` (e `loudnorm.sh` se o loudness falhar), `guias.sh`, revisão do Short-Video Editing Coach | — |
| 7 | Ok final | ela assiste no celular sem som e com som; checklist "Pronto para postar" | o final |
| 8 | Fechar | nota da peça, regras novas, diário | — |
| 9 | Aprender | métricas do Insights depois de postar viram anotação e, se ensinarem, regra | — |

## Regras técnicas (valem sempre)

1. **Preservar a aparência; nunca corrigir cor por gosto.** iPhone grava HDR: no Mac, `avconvert -p PresetHighestQuality`
   (conversor da Apple) entrega H.264 bt709 com a cor certa; depois `fps=30` no ffmpeg. Prevenção: desligar o vídeo HDR na
   câmera do iPhone (Ajustes › Câmera › Gravar Vídeo).
2. **Guardar o original.** Converter uma vez, em qualidade alta (CRF 14 a 15).
3. **1080×1920, 30 qps constante.** O iPhone e o CapCut entregam taxa variável: normalizar antes de editar (causa clássica
   de dessincronia). Não misturar 24 e 30 na mesma peça.
4. **Keyframe a cada 1 s** (`-g 30 -keyint_min 30`) em todo vídeo que entra no HyperFrames; senão o render congela quadro.
5. **Área segura em 1080×1920:** texto e logo dentro de x 80–940 e y 240–1480. O Instagram cobre o topo (cabeçalho), a base
   (legenda e botões) e a direita (curtir, comentar). Stories: 250 px livres em cima e 340 embaixo. São medidas do Davi
   nos vídeos dele, não especificação publicada pela Meta: na dúvida, confira com um print do app.
6. **Gancho nos 3 primeiros segundos.** Teste: sem som, o que o olho pega no segundo 1?
7. **Mostrar o que vai cortar antes de cortar.** Os vícios de fala da pessoa se medem nas transcrições dela (a primeira
   edição já gera a lista) e vão para o Estilo de Edição. Palavra que ela usa de propósito não é vício.
8. **Render no Terminal, com log em arquivo, um por vez.** Dentro da conversa ele roda em área protegida e lenta. Disco
   antes: `df -h /System/Volumes/Data`.
9. **Pasta de trabalho fora do iCloud** (Documents e Mesa sincronizam e travam o render). Sugestão: `~/Edicao/videos/AAAA-MM-DD-tema/`.
10. **Transcrição:** Whisper `large-v3` em português (o `small` erra português com inglês técnico). Conferir sempre os 2 s
    finais (o Whisper inventa frase no fim).
11. **Nenhum número inventado** na tela.
12. **Música e fontes com direito de uso** (ver regras A1 a A4 em `regras-do-davi.md`). Fonte livre de preferência
    (Google Fonts); fonte do sistema ou proprietária, só sabendo a licença.

## Exportação

H.264 · 1080×1920 · yuv420p · bt709 · 30 qps constante · AAC 48 kHz · `+faststart` · qualidade alta (não subcomprimir: o
Instagram recomprime; no HyperFrames, use a qualidade de entrega do render, ver a skill `hyperframes-cli`). Se o upload falhar no Meta Business Suite: nível 4.0 e uns 6 Mbps, ou AirDrop e postar pelo app.

## Pronto para postar (8 itens)

1. Sem som, o quadro 1 e o texto da primeira tela já seguram o olho.
2. O gancho entrega a promessa nos 3 primeiros segundos.
3. A legenda bate com a fala, jargão revisado, tudo dentro da área segura.
4. Voz inteligível, música abaixo da voz, sem clipping, loudness no alvo.
5. Sem ar morto: algo muda a cada ideia; o final corta rápido e fecha com a chamada ou em loop.
6. Cor sem lavado, 1080×1920, taxa constante, sem quadro preto nem dessincronia, assistido inteiro no celular.
7. Capa escolhida e legível pequena (recorte 3:4 do perfil); música e fontes com direito de uso.
8. Nenhum número inventado, voz dela respeitada, `vNN` novo salvo e regras novas anotadas.

## Quem faz o quê

| Papel | Quem |
|---|---|
| Roteirista (gancho, roteiro, legenda do post) | skills `ig-*` com a voz da pessoa |
| Ficha da referência | template Ficha de Referência + Estilo de Edição; skill `watch` para assistir |
| Editor | `hyperframes` (motor padrão: vídeo em HTML), `corte-viral` (vídeo longo → vertical) |
| Revisor | agentes Short-Video Editing Coach, Visual Storyteller, Reality Checker |
| Exportação e conferência | etapas 5 e 6: `conferir.sh`, `loudnorm.sh`, `guias.sh` |

**Um motor por peça.** O padrão é o HyperFrames.
