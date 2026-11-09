---
name: edicao-video
description: Método de edição de vídeo curto do Davi Aieta, em que o próprio Claude edita no Mac (ffmpeg, whisper e HyperFrames); veio do guia do Luka (@lukachoi_). Use quando a pessoa quiser que o Claude edite, corte, legende, dê motion, ponha efeito ou música, renderize ou revise um vídeo curto (Reels, Shorts, TikTok, corte de vídeo longo) no computador. Se ela edita no celular ou no CapCut e só quer o plano, use a edicao-video-curto. Lê o contexto escrito no cofre (voz, estilo, regras aprendidas), conduz a edição em etapas com o ok da pessoa, transforma cada correção em regra e só então chama as skills de execução (hyperframes, corte-viral, watch).
---

# Edição de vídeo · o método do Davi, no seu cofre

A ferramenta é a mesma para todo mundo. O que faz o vídeo parecer **da pessoa** é o **contexto escrito**: a IA não fica
mais esperta, ela **lembra** do que a pessoa já ensinou. Sem contexto, ela edita na média da internet (a legenda amarela de
todo mundo). O método completo está em `referencias/metodo.md`; **ele manda**, esta página só faz cumprir.

Quem aprova é sempre a pessoa. Onde este texto diz "o ok", é a pessoa escrevendo no chat; sem ok, não segue.

## 0. Contexto (antes de tocar no vídeo, sem exceção)

Leia, nesta ordem, e não pergunte nada que já esteja escrito. **Se um arquivo não existir, crie-o com o ok da pessoa** (só o
cabeçalho e uma linha explicando para que serve): `Sistema/Regras de Edição.md`, `Sistema/Estilo de Edição.md` (com
`preenchido: não`), `Sistema/Glossário de Legenda.md` e a pasta `Sistema/Fichas de Vídeo/`.

1. **Regras de Edição** (`Sistema/Regras de Edição.md`) e **Estilo de Edição** (`Sistema/Estilo de Edição.md`) do cofre:
   as escolhas da pessoa. **Ganham de tudo.**
2. `referencias/regras-do-davi.md`, parte **Técnica**: vale sempre, até a pessoa dizer o contrário.
3. `referencias/regras-do-davi.md`, parte **Gosto do Davi**: só sugestão. Use quando a pessoa ainda não decidiu aquele
   ponto, dizendo no plano que é o gosto do Davi.
4. `Sistema/Glossário de Legenda.md` (nomes, marcas e jargão que o Whisper erra), a **voz** da pessoa
   (`Conteudo/Minha Voz.md`, se existir) e a nota da peça, se existir.

Ordem de força: as Regras e o Estilo da pessoa > técnica do Davi > gosto do Davi. Quando a pessoa decidir um ponto, a escolha
dela entra no Regras ou no Estilo e a do Davi deixa de valer ali.

As ferramentas moram em `~/.claude/skills/edicao-video/ferramentas/`; chame sempre pelo caminho completo, e o
`silencios.py` com `python3`. Só Mac (precisa de ffmpeg; a transcrição usa o whisper-cpp: `brew install ffmpeg whisper-cpp`).

**Se o Estilo estiver `preenchido: não`, pare** e faça a ficha de referência antes de editar (seção abaixo). Enquanto ela não
decidir, pode usar `referencias/estilo-do-davi.md` como rascunho, **mostrando no plano** que é o estilo do Davi, e levar
cada escolha a ela por seleção.

## Esteira (cada → é um ok da pessoa)

1. **Preparar e decupar.** `ferramentas/preparar.sh` no vídeo: guarda o original, HDR→SDR, 1080×1920, 30 qps constante,
   keyframe a cada 1 s, áudio 48 kHz, transcrição palavra por palavra (Whisper `large-v3`, português). Vídeo que não é
   9:16 (tela gravada, horizontal) mantém o formato: o plano decide como ele entra. Depois `ferramentas/silencios.py` mede
   pausas **na energia do áudio**, não só na transcrição. Entregue a **tabela do que vai cortar**: silêncio, erro,
   repetição, vício de fala, cada um com o tempo e o porquê, e numa coluna à parte **o que fica de propósito** (respiro de
   tensão antes da frase de impacto, risada e reação: regras C4 e C6). → *ok da tabela.*
2. **Plano.** Gancho falado dos 3 primeiros segundos **e** texto da primeira tela (curto, legível sem som, no quadro 1);
   tabela segundo a segundo com fala · o que muda na tela · som; **mapa de mudança** (a cada ideia algo muda); capa; final
   que conversa com o primeiro quadro, chamada antes da última palavra. Liste os assets que faltam (logos, prints, fotos)
   e peça à pessoa. → *ok do plano.*
3. **Montar.** Primeiro o **A-roll**: os cortes aprovados emendados no ponto de menor energia (`silencios.py --emendas`),
   com a voz já tratada (passa-alta 80 Hz, compressão leve, duas vozes niveladas por trecho: regra A2). Esse A-roll é o
   vídeo de entrada da composição. Depois a composição com a skill dona: `hyperframes` (legenda, elementos, efeitos,
   preview e render), `corte-viral` (vídeo longo → cortes verticais), `watch` (assistir referência). Abra o **preview**
   para ela ver, não só o arquivo. Legenda revisada palavra por palavra contra o glossário antes de queimar; palavra nova
   que o Whisper errou entra no glossário.
4. **Revisar.** Ela corrige com o **segundo exato**. Cada correção aprovada vira linha em `Sistema/Regras de Edição.md`
   (número, escopo `global` ou `só este vídeo`, regra, porquê com a frase dela, vídeo e segundo, data); se for escolha de
   visual (cor, fonte, posição), vai também para o Estilo de Edição. Avise em uma linha o que salvou. Regra desfeita não
   se apaga: `substituída por R<n>`. Quando ela hesitar entre jeitos, faça um **laboratório**: um vídeo curto com
   "Hoje → 1 → 2 → 3" de cada opção, e ela escolhe vendo.
5. **Render `vNN`.** Novo a cada vez, nunca sobrescreve. Rode no Terminal com o log em arquivo, um render por vez, com
   espaço em disco conferido antes. Exportação: H.264, yuv420p, bt709, 30 qps constante, AAC 48 kHz, `+faststart`.
6. **Conferir o arquivo renderizado.** `ferramentas/conferir.sh` (formato, cor, taxa, loudness, pico, quadro preto) e,
   se o loudness ou o pico falharem, `ferramentas/loudnorm.sh` (com `SO=1` quando a voz já foi tratada ou há música) e
   confere de novo. `ferramentas/guias.sh` nos momentos com texto ou logo (área segura). Chame o agente
   **Short-Video Editing Coach** com quadros, transcrição e o caminho das notas; para motion pesado, o **Visual
   Storyteller**. O que voltar é insumo: você decide. Música: regras A3 e A4.
7. **Ok final.** Ela assiste no celular, uma vez sem som e outra com som. Passe a checklist "Pronto para postar"
   (`referencias/metodo.md`). → *ok do final.*
8. **Fechar.** Nota da peça com status e caminho do arquivo; regras novas salvas; linha no diário, se o cofre tiver.
9. **Aprender.** Se depois de postar ela colar retenção, salvamentos e envios, anote na nota da peça e, se ensinar algo,
   vire regra.

## Ficha de referência (o jeito de ensinar o estilo)

A pessoa escolhe **um Reels que queria ter feito**, grava a tela do celular enquanto toca (é o caminho principal: link
do Instagram costuma pedir login) e manda o arquivo. Diz o que o pegou ("a legenda", "o ritmo", "os números"). Use a
skill `watch` no arquivo para ter quadros e transcrição. Meça **quadro a quadro, sem chutar** (fonte, tamanho e posição
da legenda em px de 1080×1920, cores em hex, palavras por vez, ritmo de corte, elementos e quanto ficam, som em LUFS) e
crie a ficha como **nota nova** em `Sistema/Fichas de Vídeo/` com essas medidas, o link ou o arquivo de origem
e o que pegou a pessoa. Depois leve as decisões à pessoa **uma pergunta
por vez, com opções numeradas**; ela só escolhe. A resposta vai para o Estilo de Edição nas palavras dela. Três referências
já dão um padrão.

## Travas (valem em qualquer vídeo)

- Fala e tempos preservados; a legenda bate com a voz. **Nenhum número inventado** na tela; o que ninguém confirmou é
  `[CONFIRMAR]`, o que falta é `[FALTA]`.
- **Vídeo de outra pessoa é só referência de estilo**: nunca publicar nem reaproveitar quadro ou asset. Exceção só se a
  pessoa pedir, com o risco dito uma vez (o Instagram pode silenciar, bloquear ou entregar menos).
- **Pessoa real e nomeada = foto real**; nunca rosto gerado por IA para pessoa real.
- **Higgsfield ou qualquer crédito pago:** mostre o custo e a lista do que vai gerar, e espere o sim.
- **Nada publica sozinho:** a pessoa posta no app.
- **Não apagar:** versão velha fica; lixo vai para a Lixeira, quem esvazia é ela.
- Senha, conta e pagamento: o Claude não digita. Passe o comando para ela colar no Terminal.

## Se travar

- Saiu sem legenda, lavado ou com cor estranha: HDR do iPhone; refaça o passo 1.
- O render congela quadro ou avisa "sparse keyframes": keyframe a cada 1 s (`preparar.sh` já faz).
- Render lento: está rodando dentro da conversa; mova para o Terminal com log.
- O Whisper inventou frase no fim ("Legenda por…"): a legenda acaba na última palavra falada.
- Transcrições discordam numa frase: transcreva **o trecho isolado, sem dica de vocabulário**, e legende o que ele ouvir.
- Erro que a pessoa não entendeu: explique em uma frase e conserte.
