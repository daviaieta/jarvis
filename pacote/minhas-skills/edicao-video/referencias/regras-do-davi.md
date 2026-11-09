# Regras do Davi

O que o Davi aprendeu editando com o Claude entre 14/out e 03/nov/2026: as correções que ele aprovou, com o porquê. Valem
para a pessoa **até ela dizer o contrário**. Quando ela disser, a regra nova entra em `Sistema/Regras de Edição.md` do cofre
(e ganha desta). O código entre parênteses (R15, R44…) é o número da regra no caderno do Davi, para quem quiser comparar.

Ficaram de fora as regras que valiam só para um vídeo, as que foram substituídas e as que são da identidade da
É A Comunidade ou da foto e das músicas do próprio Davi.

## Técnica × gosto do Davi

- **Técnica (vale sempre, até a pessoa dizer o contrário):** todas as T, C1 a C3, L, P, A1 e A2, V1. São sobre o vídeo
  funcionar: cor, sincronia, legenda certa, fala inteira, área segura, número verdadeiro, voz audível.
- **Gosto do Davi (só sugestão; perde para o Estilo de Edição da pessoa):** marcadas com ✦ nas tabelas. São o jeito que o
  Davi gosta que o vídeo fique: fontes, abertura, chamada, formas dos elementos. Use quando a pessoa ainda não decidiu
  aquele ponto, dizendo no plano "gosto do Davi (G4)", e leve a escolha a ela.
- As C4 a C7 e as E sem ✦ ficam no meio: são o que fez os vídeos do Davi prenderem. Siga, mas a pessoa pode mudar.

## T · Técnica

| # | Regra | Porquê |
|---|---|---|
| T1 | HDR do iPhone: `avconvert -p PresetHighestQuality` (Mac) para H.264 bt709; depois `fps=30` no ffmpeg. O ffmpeg do Mac não tem `zscale`. Sem correção de cor por gosto. (R1, R15) | HDR sem conversão sai lavado, com cor estranha ou sem legenda. |
| T2 | Todo vídeo que entra no HyperFrames tem keyframe a cada 1 s (`-g 30 -keyint_min 30`); clipe curto se recodifica com CRF 14. (R55) | Com keyframe esparso o render avisa "sparse keyframes" e congela quadro. |
| T3 | Conferir cada emenda retranscrevendo o trecho cortado e **medindo a energia** nas fronteiras; decidir pela energia, não pelo Whisper. (R19) | O Whisper erra fonema solto ("Com" vira "O"); duas emendas pareciam comer palavra e não comiam. |
| T4 | Vídeo que chega já cortado (CapCut) ainda passa pela medição de silêncio na energia do áudio. (R22) | O Whisper estica a última palavra e esconde a pausa: passou 1,1 s de ar morto que só a energia mostrou. |
| T5 | Antes de misturar bruto com o corte do CapCut, medir enquadramento quadro a quadro (espelho, escala, deslocamento) e levar o bruto ao enquadramento do corte. (R40) | Os brutos vieram espelhados e um ampliado 113 %; sem medir, o rosto pula a cada emenda. |
| T6 | Nenhuma faixa preta no vertical: clipe 3:4, horizontal ou com letterbox é ampliado até cobrir 1080×1920 (medir com `cropdetect` antes). (R83) | "Não queria que tivesse" o espaço preto em cima do clipe. |
| T7 | Antes de congelar o último quadro, olhar os 0,5 s finais. (R16) | O take acaba com a mão indo parar a gravação. |
| T8 | Versão nova a cada render (`vNN`); render no Terminal com log; pasta de trabalho fora do iCloud. (R7, R8, R9) | Voltar atrás; render rápido; iCloud trava. |
| T9 | Motion que recua (zoom-out) tem de aguentar o celular: no quadro mais aberto, traço ≥ 3 px, ponto ≥ 8 px, fundo chapado (degradê escuro vira faixa na compressão) e texto de leitura ≥ 30 px. (R53) | Uma pílula de 35 px virava 11 px no recuo: "vira pó". |

## C · Corte e fala

| # | Regra | Porquê |
|---|---|---|
| C1 | Mostrar a tabela do que sai (silêncio, erro, repetição, vício) com tempo e esperar o ok. Os vícios são os do dono do vídeo, medidos nele. (R5, R6) | Ele decide o que é ritmo dele e o que é erro. |
| C2 | **A base é o corte de quem gravou.** Se ele já cortou no CapCut, não refazer as emendas pelo bruto por conta própria; do bruto, só a palavra que ele apontar. (R76) | Os remendos automáticos deixaram ar morto e "quebra-molas". |
| C3 | Frase cortada no meio da fala não termina: o corte vai até onde a voz **cai**, pegando do bruto o pedaço seguinte se preciso. (R47) | "Tem um quebra-mola… parece que eu não terminei uma coisa antes de falar outra." |
| C4 | **Reação não é gaguejo:** a risada ou a cara dos dois depois de um momento-chave fica. (R28) | "Isso é importante ter no vídeo. Não corte." |
| C5 | O contexto de quem fala passa rápido: um item por frase, cada um com a sua imagem; sai a frase que resume o que a tela já mostrou; pausa entre itens ≤ 0,15 s. (R49) | "Dá pra cortar e enxugar bastante tempo." |
| C6 | Antes da frase de impacto, um **respiro de tensão** (1,5 a 2 s) com o gesto real, zoom lento, vinheta leve e uma subida baixa; sem legenda nesse respiro. (R37) | "Esse corte ficou muito rápido… queria gerar uma tensãozinha." |
| C7 | A palavra da chamada não aparece na fala logo antes dela: a frase acaba antes, respiro de 0,2 s, corte seco para a chamada. (R52) | "Eu falei tanto Obsidian que ficou chato." |

## L · Legenda

| # | Regra | Porquê |
|---|---|---|
| L1 | Legenda revisada palavra por palavra contra o glossário (nomes, marcas, jargão) antes de queimar. (R13) | O Whisper erra "Claude" (sai "Claudio"), "AC/DC" (sai "CDC"), nomes. |
| L2 | Frase em que as transcrições discordam: transcrever **o trecho isolado, sem dica de vocabulário**, e legendar o que ele ouvir. (R24) | Com "Claude" na dica saiu "teu Claude"; sem dica, três vezes "teu cofre". |
| L3 | A legenda acaba na última palavra falada; conferir os 2 s finais. (R51) | O Whisper inventou um "Legenda por …" depois do fim. |
| L4 | Nada de texto acima de y 240 nem abaixo de y 1480; medir a área segura **quadro a quadro** nos momentos com texto ou logo, com as guias desenhadas, antes do render final. (R3, R18, R54) | Capa a 5 px da borda, rótulo a 170 px (embaixo do cabeçalho), nome de 54 a 967 px: só a medida achou. |

## G · Gancho e abertura

| # | Regra | Porquê |
|---|---|---|
| G1 | O plano separa o **gancho falado** do **texto da primeira tela** (curto, legível sem som, no quadro 1). (R4, R12) | Muita gente assiste sem som. |
| G2 ✦ | **Abertura com flash-forward** (quando o vídeo tem um momento forte no meio; senão, abre com a pergunta que já existe no take): os 2 s mais fortes do meio (a frase e a imagem do resultado) entram antes do gancho, com o texto do gancho já no quadro 1; o trecho volta no lugar dele depois. (R44) | "Começar com um trecho para prender a atenção de quem estiver scrollando." |
| G3 ✦ | Depois do flash-forward, um efeito marca o começo de verdade: whoosh, impacto no primeiro quadro do gancho e clarão de 0,2 s. (R48) | "O ideal seria colocar outro efeito sonoro para começar o vídeo de verdade." |
| G4 ✦ | Título do gancho em placa branca, com a palavra-assunto trocando de fonte (em preto, ~0,15 s por fonte, sem caixa própria) e parando numa fonte de jornal com serifa (a do New York Times é proprietária: use uma livre, como Playfair Display ou Old Standard TT). O rosto continua na tela. (R77) | Foram 5 versões até chegar aqui; nada de tela cheia, caixa dentro de caixa ou pulo no fim. |
| G5 ✦ | Título com palavra que troca de fonte fica centrado pelo estado final (calibrar todas as fontes na largura da palavra final). (R75) | "Não ficou centralizado. Fiquei bem desconfortável." |
| G6 | O texto do alto troca no ritmo da fala: mudou o assunto, muda a frase. Nada de título parado por 4 s. (R79) | "Demora muito para trocar lá a frase." |

## E · Elementos na tela

| # | Regra | Porquê |
|---|---|---|
| E1 | **A imagem bate com o que é dito**, no instante em que é dito: a chamada do Obsidian mostra o logo do Obsidian; a capa é a do disco certo. (R46) | Logo trocado e capa de outro disco passaram despercebidos até o Davi ver. |
| E2 | Marca citada no gancho entra como **adesivo grande**, na palavra, na altura do peito, acima da legenda, sem cobrir rosto. (R29) | "Essas três imagens têm que ser bem dinâmicas." |
| E3 | Quando a fala lista coisas da vida de alguém, cada item entra com **a imagem do próprio assunto** (logo, objeto, ícone), grande e animada; nada de placa só com texto. (R26) | Placa só com texto não mostra nada: a imagem do assunto é o que prende. |
| E4 | Rótulo com logo: logo **grande, fora da placa, embaixo do texto**, se mexendo (entra girando, flutua). (R25) | "Não ficou nem um pouco dinâmico, nem engajativo." |
| E5 | Ícones de uma mesma lista seguem **um padrão só** (mesmo cartão, mesmo tamanho). (R33) | O halter solto quebrava o padrão dos logos. |
| E6 ✦ | Objeto falado vira o objeto de verdade: "pasta" é ícone de pasta clássico, amarelo, com o logo caindo dentro. Nada de retângulo. (R34) | "Não quero retângulos… ícones de pasta de verdade." |
| E7 | Prompt falado aparece **sendo digitado e enviado** (cursor, botão, a IA trabalhando). (R35) | "Como se estivesse digitando e enviando." |
| E8 | Tela de chat não cobre a tela inteira: janela flutuante no alto (sempre abaixo de y 240, L4), curta; a resposta desce conforme aparece; rosto e legenda à vista. (R27) | Pedido do Davi ao ver as telas em tela cheia. |
| E9 | Quando a fala aponta o resultado, ele fica **≥ 2 s** na tela, com zoom lento. (R36) | "Ficou meio segundo ali, e eu quero que fique mais tempo." |
| E10 | O resultado que prova a tese ganha destaque: tempo, o que importa marcado, um carimbo de conclusão e o "antes × depois" lado a lado, só com trechos reais. (R39) | "É algo importante e impactante para mostrar." |
| E11 | Foto, capa ou adesivo **nunca cobre rosto**: canto de cima (dentro da área segura, L4), entrando em diagonal. Gráfico não vai no rosto de quem fala. (R38, R43) | A capa cobria o rosto; o HUD na cara da pessoa não ficou. |
| E12 | Quando ele aponta ("essa aqui"), o elemento aparece onde o dedo aponta. (R63) | "Deveria estar indo para onde estou apontando." |
| E13 ✦ | Título de momento-chave ("TESTE FINAL") sem placa branca: fonte condensada grande (o Davi usa DIN Condensed, do macOS; livre: Bebas Neue ou Oswald), tela escurecendo atrás; disputa vira **versus** (logo × logo). (R42) | "Frase final é algo muito importante… outra fonte, sem retângulo." |
| E14 ✦ | Cada personagem tem a sua imagem; nunca o mesmo logo nos dois lados. O Jarvis é **mascote do Claude + logo do Obsidian**. (R45) | "Ficaria meio redundante usar Claude versus Claude." |
| E15 | Funcionalidade não vira checklist (✓ em lista): aparece acontecendo no próprio app, com caixa marcando o botão e o gesto deixando rastro. (R60) | "Ficou meio que num checklist. Não gostei." |
| E16 | Nota pequena nunca encosta em selo ou outra peça. (R61) | "Ficou com aspecto de bug." |
| E17 ✦ | Comparação de tempo ou quantidade é **objeto em movimento** (pilha alta de folhas × uma folha), não gráfico de linha nem ícone parado. (R72) | "Boring"; o gráfico de linha também não convenceu. |
| E18 | Ideia grande ganha imagem grande: "mundo inteiro" é um globo girando, não print de texto. (R74) | "Eu quero que você represente de outra forma." |
| E19 | Quando o vídeo mostra uma função, mostre o tamanho do sistema: o teste vira um ponto e a câmera recua até o sistema inteiro. Rótulo só do que existe; nenhum número que ninguém confirmou. (R50) | "É só uma das funcionalidades… demonstrar que ele é muito maior." |
| E20 | App de terceiro aparece **real e logado**, na versão do celular, uma tela por vez, fazendo a ação de verdade. (R70, R78) | A página de quem não tem conta ficou "bem feia"; duas janelas empilhadas, "estranhas". |
| E21 | Tela com o cofre de outra pessoa (nomes de nota legíveis) entra com desfoque leve (gblur ≈ 3,5). (R31) | O grafo mostrava títulos de notas e uma reunião na barra do Mac. |
| E22 | Gravação de app é fluida: **captura** a 60 qps (o vídeo final continua a 30 constante: a captura é convertida), rolagem com curva (sai devagar, corre, chega devagar), um toque a cada 0,6 a 1 s; gravar um print por quadro, nunca lista de imagens com duração. (R56) | "Tá muito travado, tá muito lento." |
| E23 ✦ | No vertical, fundo limpo: holograma e partículas de fundo só no horizontal. (R20, R21) | No celular o fundo compete com os cartões. |

## P · Prova e fonte

| # | Regra | Porquê |
|---|---|---|
| P1 | Citação de autor vai fiel no cartão, mesmo que a fala tenha parafraseado; a legenda some enquanto o cartão está na tela. (R17) | Vídeo que promete fonte não pode errar a fonte. |
| P2 | Número falado arredondado ("5 %") pode ficar na fala; na tela, o número exato. (R58) | Manter a fala natural sem mentir na tela. |
| P3 | Fonte de notícia vai na legenda do post, não na tela (nem escrita, nem logo); o cartão do dado fica sozinho. (R71) | "Não ficaram tão legais." |
| P4 | Resultado que ainda não existe não se diz como feito: demo provisória só até o real ser gravado. (R80) | Nunca inventar resultado. |

## A · Áudio e música

| # | Regra | Porquê |
|---|---|---|
| A1 | Áudio tem etapa própria: voz limpa, música abaixo da voz (ou nenhuma), sem clipping, -14 LUFS, pico -1 dBTP. (R11) | Voz ilegível derruba retenção. As três referências medidas estavam em -14 LUFS. |
| A2 | Duas pessoas falando: medir cada voz por trecho e nivelar (ganho só no trecho do convidado, rampa curta) **antes** do loudnorm. (R23) | O convidado estava 6 a 8 LU abaixo do Davi justo na resposta ao gancho. |
| A3 | Música famosa: o caminho seguro é pelo app do Instagram (biblioteca), escolhendo o trecho. Se o dono quiser **dentro do arquivo**, ele escolhe a faixa, o drop sincroniza com a entrada do título, -14 LUFS, fade de 0,6 s, e o risco (silenciar, bloquear) é dito uma vez, sem insistir. (R85) | Decisão do Davi em 03/nov/2026, depois de testar os dois. |
| A4 | Música que aparece na tela (mini player, "tocando agora") passa pelo dono: nada de faixa com repercussão ruim no momento. (R81) | Proteger a imagem de quem posta. |
| A5 ✦ | Efeitos sonoros baixos, uns 8 a 13 num Reel de 90 s, nunca por cima de palavra-chave; sintetizados no projeto ou de biblioteca livre. | Som bom é o que ninguém percebe; muito efeito cansa. |

## F · Final e chamada

| # | Regra | Porquê |
|---|---|---|
| F1 ✦ | A chamada **final** (seguir) não repete a forma que o vídeo inteiro já usou (ex.: o chip marca-texto): use outra forma, como o botão de seguir sendo tocado. A cor de destaque pode continuar; o que muda é a forma. A palavra-chave do meio (F2) pode ser chip. (R65) | "Ficou muito repetitivo." |
| F2 ✦ | Palavra-chave nos comentários ("comenta OBSIDIAN") entrega algo grátis que **já existe** antes de postar. Uma palavra por vídeo, em maiúscula, na cor de destaque. Intercalar: palavra-chave no meio, salvar + seguir no fim. | Do Estilo de Edição do Davi. |

## V · Versões e escolhas

| # | Regra | Porquê |
|---|---|---|
| V1 | Toda correção é registrada com escopo `global` ou `só este vídeo`. (R14) | Regras globais e pontuais misturadas se contradizem. |
| V2 | Escolha visual difícil vira **laboratório**: um vídeo curto com "Hoje → 1 → 2 → 3" de cada opção, e o dono escolhe vendo, por seleção. | Foi assim que saíram o versus, o holograma e o título do gancho. |
| V3 | Versão para Trial Reels é outro formato inteiro (outra organização visual da mesma fala), não só outro gancho. (R82) | "Outra edição, com um formato diferente." |
