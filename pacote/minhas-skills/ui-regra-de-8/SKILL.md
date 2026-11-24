---
name: ui-regra-de-8
description: O padrão de UI/UX do Davi para app e painel (mobile e web): grade de 8, escala fixa de raio e de fonte, 90% neutro com um acento só, cartões brancos sobre cinza, listas agrupadas, dinheiro com centavos em cinza, folha inferior flutuante e feedback em cada toque. Use SEMPRE que for construir, refazer ou revisar a interface de um app, dashboard, painel, tela de produto ou componente (app próprio, protótipos, telas de demo), mesmo quando o pedido for só "faz uma tela bonita e clean". Não vale para landing page de venda, carrossel ou motion.
---

# UI regra de 8

Referência: as telas "Reports / Analytics / Overview" de Divan Raj (@desdivj, 02/nov/2026), trazidas pelo
Magdiel Silva (@magdiel_rb) em 11/nov/2026 com a tese: o Claude faz tela genérica porque ninguém deu as regras
de espaçamento, raio, tamanho de fonte e proporção de cor. Aqui estão as regras. Siga os números; não chute
valor por tela.

Exemplo vivo, interativo: `exemplo.html` nesta pasta (abra e copie dele antes de inventar).
Números medidos nos quadros do vídeo
(390 pt de largura) com o UX Architect em 11/nov/2026; o que ficou incerto está marcado [CONFIRMAR].

## 1. Espaço: tudo múltiplo de 8

Escala: **4 · 8 · 12 · 16 · 24 · 32 · 40 · 48 · 64**. O 4, o 12 e o 20 só onde a tabela manda (ícone com texto, padding da folha e do cartão-herói, linha
de rótulo com valor). Nada de 10, 14, 18, 20, 22.

| Onde | Valor |
|---|---|
| Margem lateral da tela | 16 (mobile) · 24 a 32 (web) |
| Padding interno do cartão | 16 (cartão-herói: 16 dos lados, 20 em cima e embaixo) |
| Entre cartões / seções | 16; entre blocos com título, 24 a 32 |
| Linha de lista | altura 64, 12 entre avatar e texto |
| Folha inferior | padding lateral 20 |
| Título → subtítulo | 4 |
| Rótulo → número | 4 a 8 |

Alturas de toque: botão primário **52** (largura total, medido na referência), secundário **40**, pílula compacta **32**, botão de ícone
**40** redondo, atalho rápido **56** quadrado, linha de lista **64**, busca **48**, controle segmentado **40**.

## 2. Raio: escala fixa, aninhado

**8** (selo, ícone pequeno) · **12** (tile de ícone 40) · **16** (atalho 56, input dentro de cartão) ·
**20** (cartão; medido ≈20, cantos contínuos estilo iOS) · **32** (folha inferior) · **999** (botão, pílula, busca, segmento, badge).

Regra do aninhamento: raio de dentro = raio de fora − padding. Cartão 20 com padding 16 → filho com 4 a 8; tile solto 12.
Nunca o mesmo raio dentro e fora.

## 3. Tipo: uma família, poucos tamanhos

Família: **Inter** (ou Geist; SF Pro no iOS nativo), `font-feature-settings: "tnum"` em todo número.
Pesos: **400** texto, **500** rótulo, botão e número-herói, **600** títulos e números de lista. Nunca 700+ (o peso vem do tamanho).

| Papel | Tamanho / altura de linha | Peso | Tracking |
|---|---|---|---|
| Título da tela | 30 / 36 | 600 | −0,02em |
| Número-herói | 36 / 40 | 500 | −0,03em |
| Título de folha | 20 / 28 | 600 | −0,01em |
| Título de seção ("Atividade do time") | 18 / 24 | 600 | −0,01em |
| Número de lista, métrica | 16 / 24 | 600 | 0 |
| Corpo, nome na lista, título do alerta | 16 / 24 | 500 (alerta 600) | 0 |
| Rótulo do botão primário | 16 / 24 | 500 | 0 |
| Subtítulo, rótulo | 15 / 20 | 400 | 0 |
| Meta (data, id, "2 min"), em `--ink-3` | 13 / 16 | 400 | 0 |
| Linha de ajuda sob o botão | 12 / 16 | 400 | 0 |
| Badge, legenda de gráfico | 12 / 16 | 500 | 0 |

Hierarquia por **cor e tamanho**, não por negrito: o título é preto, o resto é cinza.

## 4. Cor: 90% neutro, preto age, um acento chama

```
--bg:        #F7F7F7   fundo da tela (cinza neutro bem claro)
--surface:   #FFFFFF   cartão, folha, botão de ícone
--track:     #EBEBEA   trilho do segmento, input, tile sem fundo branco
--line:      #F1F1F1   divisória de 1px entre linhas (nunca borda grossa)
--ink:       #111111   título, número, botão primário
--ink-2:     #4F4F4F   subtítulo, rótulo ("Segunda, 2 de nov", "Receita líquida · Novembro")
--ink-3:     #737373   meta ("#1042", "3 clientes", "2 min"), linha de ajuda
--ink-4:     #8E8E93   só centavos (e a vírgula) do número grande e placeholder; nunca texto pequeno
--accent:    #F44400   o acento (laranja-avermelhado; [CONFIRMAR] hex exato): atraso, valor a cobrar, link "Limpar", cursor, ponto de notificação
--success:   #1FA855   só confirmação e "Pago" (fundo #F3FDF5, borda #DDF0E5)
--warning:   #C98A00   só "Pendente" (fundo #FFF8E6, borda #F3D78C)
--info:      #7C5CDB   só "Enviado" (lilás; fundo #F4F0FF, borda #E2D9FB) [CONFIRMAR hex]
--tile-line: #E5E5E5   borda de tile de ícone (mais escura que a divisória)
--overlay:   rgba(0,0,0,.19)  véu atrás da folha
```

Proporção: ~60% `--bg`, ~30% `--surface`, ~8% `--ink`, **≤ 2% acento**. O acento é **um** por produto (troque o
laranja pela cor da marca, mas mantenha um só). Ação principal é **preta**, não colorida. Verde, âmbar e lilás só como
estado, sempre em badge com fundo claro + borda + texto da mesma cor.

Sombra quase nenhuma: cartão branco sobre cinza já separa. No máximo `0 1px 2px rgba(0,0,0,.04)`. A folha
inferior tem `0 -8px 32px rgba(0,0,0,.08)`.

## 5. Componentes (a receita de cada um)

- **Cabeçalho:** título 30 + subtítulo 15 cinza com o contexto em número ("248 relatórios · 12 clientes",
  "Segunda, 2 de nov"). À direita, botões de ícone 40 redondos e brancos; notificação = ponto 8 no acento.
- **Busca:** pílula 48 branca, ícone 20 cinza, **tokens de filtro dentro dela** (`valor: >1000` numa pílula
  `--track`) seguidos do texto livre. Ao lado, botão de filtro 48 com badge de contagem no acento.
- **Controle segmentado:** trilho `--track` 40, pílula branca que **desliza** até a opção (não troca seca).
- **Filtro aplicado:** chip branco "Status **é um de** Pago, Pendente ×" (o valor em 500 preto, o operador
  cinza) + botão "+" de contorno tracejado.
- **Contagem do resultado:** "**52** de 248 relatórios" à esquerda; "Limpar tudo" no acento à direita.
- **Lista agrupada:** UM cartão branco com as linhas dentro, divisória de 1px na largura do conteúdo (recuo igual ao
  padding dos dois lados; não começa depois do ícone). Nunca um cartão por linha. Linha de 64: tile 40 (raio 12,
  borda `--tile-line`, ícone 20) ou avatar 36 · nome 16/500 · meta 13 `--ink-3` ("Mono Labs · 26 out") · à direita
  **uma coisa só**, centrada na vertical: o valor 16/600 **ou** o badge de estado.
- **Linha de atividade:** frase em 2 linhas com o sujeito em 600 e a ação em 400 ("**Aylin** aprovou a cobrança do
  rebranding"), "2 min" embaixo em `--ink-3`, badge à direita.
- **Meta com acento:** na linha de meta e nos resumos, o dado que pede ação vai no acento e o resto fica cinza
  ("#1042 · **12 dias de atraso**", "**R$ 4.812** em aberto · a mais antiga há 12 dias").
- **Dinheiro:** inteiro em `--ink`, **vírgula e centavos** em `--ink-4`, mesmo tamanho (`86.420`**`,18`**). Abreviar em métrica secundária
  (`R$ 112,4 mil`). Sempre `tnum`.
- **Cartão de KPI:** rótulo "Receita líquida · Novembro" → número-herói → à direita sparkline no acento com
  ponto no fim e área em degradê de 12% → badge de variação verde ("+12,4% vs out"). Divisória, depois 3
  submétricas em colunas com ponto colorido de 8 antes do rótulo e divisória vertical entre elas.
- **Atalhos:** 4 tiles 56 brancos (raio 16), ícone 24 preto, rótulo 13 embaixo, distribuídos na largura.
- **Cartão de alerta:** tile 40 com ícone (bandeira, borda `--tile-line`), título 16/600, linha com o valor no acento + resto cinza,
  embaixo pilha de avatares 28 com anel branco de 2, sobrepostos (−8) + "3 clientes" + botão pílula preto 32 "Revisar" à direita.
- **Seção:** título 18 + botão pílula branco "Ver tudo ▸" à direita.
- **Folha inferior:** **flutuante**, 8 das laterais e da base, raio 32, puxador 36×4 cinza no topo, título 20,
  resumo com o valor no acento, botão fechar 32 redondo (fundo #F5F5F5). Padding lateral 20. Lista, depois botão
  primário 52 preto de largura total e uma linha de ajuda 12 `--ink-3` embaixo ("Cada cliente recebe um e-mail com o link de pagamento").
- **Gráfico:** barras diárias em `--track`, média móvel em linha do acento, meta tracejada verde; seletor de
  período 7D/30D/90D em segmento; legenda embaixo com amostras de 8. Grade horizontal de 1px, sem eixo Y pesado.

## 6. UX: cada toque responde ("you might want to tap everything")

1. **Pressionar:** tudo que é tocável faz `scale(.97)` em 100ms e volta com mola. Botão de ícone escurece o fundo.
2. **Cursor de digitação** e foco no acento.
3. **Ação em lote vira estado no próprio botão:** "Enviar 3 lembretes" (preto) → spinner curto → **verde com ✓
   "Lembretes enviados"**; ao mesmo tempo um ✓ verde (círculo 20, anel branco 2, no canto inferior direito do
   avatar, saindo um pouco para fora) aparece em cada avatar, em cascata de 60ms.
4. **Depois do sucesso, a tela se arruma sozinha:** a folha desce (~900ms depois), o cartão do alerta resolvido
   **colapsa** (altura e opacidade) e o conteúdo de baixo **sobe** no lugar. Nada pula.
5. **Folha:** sobe com mola (≈ 380ms, `cubic-bezier(.32,.72,0,1)`), o fundo escurece (véu .19) e **não** encolhe; fecha
   no ×, no véu ou arrastando o puxador.
6. **Número muda contando**, não troca seco. Segmento desliza.
7. `prefers-reduced-motion`: troca mola e escala por fade de 150ms.

## 7. Antes de entregar, confira

- [ ] Algum espaço, raio ou tamanho fora das escalas acima? Corrija para o mais próximo.
- [ ] Mais de um acento? Ação principal colorida? Verde/âmbar/lilás fora de estado?
- [ ] Algum negrito 700? Número sem `tnum`? Vírgula e centavos sem cinza?
- [ ] Lista virou pilha de cartões? Borda grossa ou sombra pesada?
- [ ] Todo toque tem resposta; toda ação tem estado de sucesso; a tela se reorganiza depois?
- [ ] Alvos de toque ≥ 40 (44 no iOS nativo); texto pequeno em `--ink-3` ou mais escuro (≥ 4.5:1).

Dentro de um projeto com design system próprio (tokens já definidos), **o projeto manda**: use estas regras
para o que ele não define (espaçamento, proporção de cor, feedback de toque).
