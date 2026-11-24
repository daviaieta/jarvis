---
name: sfx-kit
description: Banco local de 320 efeitos sonoros originais CC0 (wyzowl/sfx-kit) para vídeos, motion e interfaces - whoosh, pop, clique, digitação, impacto, riser, notificação, contagem de número, logo sting. Use quando um vídeo, reel, corte, motion (HyperFrames, Remotion) ou UI precisar de efeito sonoro e bastar um som pronto, sem baixar nada nem pagar licença. Para julgar ou comparar sons use também a skill earshot; para trilha com gravações licenciadas de fora, real-sound.
---

# sfx-kit: 320 efeitos sonoros CC0, no seu disco

O banco é o repositório [`wyzowl/sfx-kit`](https://github.com/wyzowl/sfx-kit), licença CC0: uso comercial livre, sem crédito.
Todo arquivo é WAV 48 kHz / 24 bit, com volume já igualado entre os sons e pico em -3 dBTP.

**Onde fica:** `~/sfx-kit`. O `instalar.sh` do Jarvis baixa sozinho. Se a pasta não existir:

```bash
git clone --depth 1 https://github.com/wyzowl/sfx-kit.git ~/sfx-kit
```

Se a pessoa usa a skill `edicao-video`, ela vai na frente: esta skill só escolhe e posiciona o som.

## Onde está cada coisa (leia nesta ordem)

1. `GUIDE.md`: a tabela "o que acontece na tela → qual som", como posicionar e como encaixar.
2. `catalogue.md`: uma linha por som, por categoria. Curto o bastante para ler inteiro.
3. `sounds.json`: os dados de cada som (para código). Esquema em `sounds.schema.json`.
4. `sounds/<categoria>/<id>.wav`: os arquivos.

## As três regras do banco

1. **Achar:** parta do que acontece na tela. `use_for`, `avoid_for` e `tags` dizem onde o som serve;
   `fits_seconds`, o tamanho de momento que ele cobre.
2. **Posicionar:** o som começa no instante do evento menos o `sync.at` dele. Vale para todo som
   (o ponto de sync de um riser é o fim; o de um whoosh, o pico).
3. **Volume:** já estão igualados. Debaixo de fala, baixe o quanto o `under_voiceover_db` do som diz.

## O que o Davi aprendeu com efeito sonoro (vale até a pessoa dizer o contrário)

1. **Pouco e só onde precisa.** Uma lista curta, escrita à mão, com um som por momento que pede som: no máximo ~40 eventos
   por minuto. Não copie a densidade de uma referência.
2. **Nunca por cima da voz.** O efeito fica claramente abaixo da fala: comece uns 6 dB abaixo do que soa "certo" sozinho e
   meça a voz contra música + efeitos (a voz 6 dB ou mais acima). Nada de estalo a cada palavra.
3. **Digitação só em momento-chave**, quando um texto importante está sendo digitado na tela.
4. **Variar a família.** O mesmo gesto alterna entre famílias (tecla, clique, pop, swish, swipe, papel, notificação), em rodízio;
   nunca um som só no vídeo inteiro.
5. **Gancho de cinema:** no começo, um som grave e comprido (cama, subida que termina na palavra-chave), não um estalo.

## Achar por código

```bash
python3 -I -c "import json,sys,os; d=json.load(open(os.path.expanduser('~/sfx-kit/sounds.json'))); \
q=sys.argv[1]; [print(s['id'], '-', s.get('description','')[:90]) for s in d['sounds'] if q in json.dumps(s).lower()]" whoosh
```

(Se a chave da lista não for `sounds`, abra o começo do `sounds.json`: ele explica o próprio formato.)

## Limites

- Você não ouve. Antes de dizer que um som "combina", meça com a skill `earshot` (`describe`, `match`, `ab`).
- São sons de design, feitos para motion; não são gravações de foley real. Se o pedido é som gravado, use `real-sound`.
- Não copie os WAV para dentro do cofre do Obsidian; copie só para a pasta de trabalho do vídeo.
