# Jarvis: seu segundo cérebro no Obsidian

O **Jarvis** transforma uma pasta do Obsidian no seu segundo cérebro: o Claude lê o que você escreveu antes de te responder e passa a ter uma equipe de **282 especialistas** e dezenas de skills à disposição. Método do Davi Aieta.

## Como instalar (3 passos)

1. Instale o [Obsidian](https://obsidian.md) e crie um **cofre**: uma pasta nova, com o nome que quiser.
2. Abra o **Claude Code** nessa pasta: pelo app do Claude no computador (aba *Code*, escolhendo a pasta do cofre) ou pelo terminal, dentro da pasta, digitando `claude`. O Claude Code precisa de uma conta no Claude; confira no site da Anthropic qual plano você precisa.
3. Cole isto no Claude e envie:

```
Instala o Jarvis: https://github.com/daviaieta/jarvis
```

Pronto. O resto o Claude conduz.

> **Instruções para o Claude Code** (quem te mandou este link quer instalar o Jarvis nesta pasta):
> 1. Baixe o prompt: `curl -fsSL https://raw.githubusercontent.com/daviaieta/jarvis/main/prompt-jarvis.txt -o "${TMPDIR:-/tmp}/jarvis-prompt.txt"`
> 2. Leia o arquivo **inteiro** com a ferramenta Read. Não use WebFetch: ele resume o texto.
> 3. Siga-o como se fosse a sua instalação, a partir da Fase 0, **parando nos PARE** para o ok da pessoa.

## O que acontece depois

- O Jarvis lê a sua pasta e **para** (ele escreve PARE) para você dar o ok antes de criar, instalar ou rodar qualquer coisa. Vão aparecer também pedidos de permissão do próprio Claude Code: leia e aprove o que fizer sentido.
- Ele instala a equipe e as skills de uma vez, pede **um** reinício (feche o Claude Code, abra de novo na mesma pasta e digite `continue a instalação`) e faz uma entrevista, uma pergunta por vez. Pode parar e voltar depois: ele lê o `Sistema/Progresso.md` e continua de onde parou.
- Para testar: *"chama o Chief of Staff e monta minha semana"*.

## O que vem instalado

- **Os 282 agentes** do [Agency Agents](https://github.com/msitarzewski/agency-agents) (chefe de gabinete, analista financeiro, estrategista de conteúdo, revisor de código e por aí vai). Trabalham só quando o Jarvis chama, de 1 a 3 por tarefa, e acabam quando entregam.
- **Plugins:** [instagram-skills](https://github.com/sergebulaev/instagram-skills) (legenda, carrossel, gancho), [claude-video](https://github.com/bradautomates/claude-video) (assistir vídeo), [edit-labs-ai](https://github.com/paullabs/edit-labs-ai) (cortes de vídeo), [hyperframes](https://github.com/heygen-com/hyperframes) (vídeo por código), [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin) e frontend-design.
- **Skills avulsas:** 8 do [Higgsfield](https://github.com/higgsfield-ai/skills), 7 do [Replicate](https://github.com/replicate/skills) e a [find-skills](https://github.com/vercel-labs/skills). As do Higgsfield e do Replicate só funcionam com conta sua (e gastam crédito); o Jarvis nunca digita senha, chave ou cartão por você.

Tudo vem dos repositórios originais, de terceiros. O Jarvis avisa antes e só instala com o seu ok.

## O que ele faz, e o que não faz

- **Faz:** organiza o cofre, escreve as notas a partir do que você conta, chama os especialistas certos, registra o dia e sugere uma coisa nova de cada vez.
- **Não faz:** publicar, mandar mensagem, agendar ou apagar nota. Ele escreve rascunho; você decide e posta.

## O que não contar para ele

- Nada **confidencial do seu trabalho**: cliente, carteira, número interno. Se você contar, ele não guarda.
- Dado de **saúde** (exame, peso, remédio) só se você quiser, e ele fica só na sua pasta.
- **Senha, chave ou cartão:** o Jarvis nunca pede. Se pedir, pare.

## Se travar

- Copie a mensagem de erro e cole **no próprio Claude**: ele explica o que aconteceu.
- Os passos de instalação foram feitos para **Mac**. No Windows alguns comandos mudam, e o Jarvis avisa antes de mexer.
- Com tantos agentes instalados, o Claude Code gasta uns 20 mil tokens a mais por conversa só para listá-los. Se pesar, peça ao Jarvis para enxugar a equipe.

Conseguiu montar o seu? Me marca no Instagram: [@daviaietaa](https://www.instagram.com/daviaietaa/).
