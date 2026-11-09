# Seu segundo cérebro no Obsidian + Claude Code

O tutorial que eu mostrei na live: como montar, em uns 10 minutos, uma pasta de notas que o Claude lê antes de te responder.
É o mesmo método que eu uso todo dia. Davi Aieta · [@daviaietaa](https://www.instagram.com/daviaietaa/)

> **A ideia inteira numa frase:** a ferramenta é a mesma para todo mundo. O contexto não.
> Todo mundo tem o mesmo Claude. O que muda a resposta é o que ele sabe sobre você.

---

## 1. O que é, de verdade

Segundo cérebro não é app mágico nem tela bonita. É **uma pasta de notas em Markdown** no seu computador.

- O **Obsidian** é a janela: mostra as notas e as ligações entre elas.
- O **Claude Code** abre a mesma pasta, lê as notas e escreve nelas.
- Um arquivo chamado **`CLAUDE.md`**, na raiz da pasta, diz ao Claude quem você é, onde fica cada coisa e como você quer as respostas. Ele lê esse arquivo em toda conversa.

Resultado: você não explica a sua vida de novo em cada conversa. A memória é a pasta.

## 2. O que você precisa

- Um computador (Mac é o caminho testado; no Windows, use WSL ou Git Bash).
- O [Obsidian](https://obsidian.md), de graça.
- O **Claude Code**, que pede uma conta no Claude (confira no site da Anthropic qual plano). Ele roda no terminal ou no app do Claude, na aba *Code*.

## 3. O jeito rápido: deixar o Jarvis montar

1. No Obsidian, crie um **cofre**: uma pasta nova, com o nome que quiser.
2. Abra o Claude Code **nessa pasta**.
3. Cole isto e envie:

```
Instala o Jarvis: https://github.com/daviaieta/jarvis
```

Ele lê a pasta, pergunta o seu nome e as quatro grandes áreas da sua vida, para e espera o seu ok, monta o cofre, instala os
especialistas e as skills e depois te entrevista, uma pergunta por vez. Detalhes no [README](../README.md).

Quer entender o que ele faz, ou montar na mão? Siga o resto.

## 4. O jeito na mão, em 5 passos

### Passo 1 · As pastas

Uma pasta por grande área da sua vida (os **pilares**), mais quatro de sistema. Exemplo:

```
Cofre/
├── CLAUDE.md          as regras (passo 2)
├── 00-Inbox/          captura rápida, sem formato; o Claude organiza depois
├── 01-Eu/             quem você é, metas, rotina
├── 02-Trabalho/       um pilar
├── 03-Estudos/        outro pilar
├── 04-Saude/          outro pilar
├── 05-Diario/         uma nota por dia: AAAA-MM-DD.md
├── Pessoas/           uma nota por pessoa
└── Sistema/           modelos e regras do próprio cofre
```

Quatro pilares é o ideal. Pasta sem acento e sem espaço: evita dor de cabeça no terminal.

### Passo 2 · O `CLAUDE.md`

Crie o arquivo `CLAUDE.md` na raiz do cofre. Este modelo é um bom começo; troque o que está entre colchetes:

```markdown
# Meu cofre

Pasta única de [seu nome]. Também é o cofre do Obsidian. Leia `01-Eu/Eu.md` antes de qualquer pedido pessoal.

## Quem sou
[Duas ou três linhas: o que você faz, o que está construindo, o que quer daqui a um ano.]

## As pastas
- 00-Inbox: captura rápida; organize depois.
- 01-Eu: perfil, metas, rotina.
- 02-[Pilar 1] · 03-[Pilar 2] · 04-[Pilar 3]: uma pasta por área da minha vida.
- 05-Diario: uma nota por dia (AAAA-MM-DD.md).
- Pessoas: uma nota por pessoa.

## Antes de responder
1. Contexto primeiro: leia a nota da área antes de responder. Não me pergunte o que já está escrito aqui.
2. Não invente: o que não está nas notas é [FALTA]; o que está e ninguém confirmou é [CONFIRMAR].
3. Responda em português, direto, sem enrolação.

## Como escrever notas
- Nome em português natural, com acento. Datas absolutas (09/nov/2026), nunca "ontem".
- Toda nota começa com: tipo, area, atualizado (AAAA-MM-DD) e fonte (de onde veio a informação).
- Uma informação mora em um lugar só; as outras notas apontam para ela com [[Nome da Nota]].

## Fechar a conversa
Antes de encerrar uma conversa em que algo foi decidido ou feito:
1. Atualize a nota dona do assunto e o campo atualizado.
2. Registre uma linha no diário do dia, com o que mudou e os links das notas.

## Nunca
- Guardar senha, chave de API, número de cartão ou dado de cliente.
- Publicar, enviar mensagem ou apagar nota sem o meu ok. Nota que sai de uso vai para Arquivo/.
```

### Passo 3 · Deixe o Claude te entrevistar

Abra o Claude Code na pasta e peça:

```
Me entrevista com 5 perguntas, uma por vez, sobre quem eu sou e o que eu faço.
Depois cria a nota 01-Eu/Eu.md e uma nota-índice em cada pilar.
```

Em vez de escrever tudo do zero, você só responde. Ele escreve as notas no formato do `CLAUDE.md`.

### Passo 4 · Teste se ele leu

Pergunte algo que só o cofre sabe:

```
Com base no que você sabe de mim, o que eu deveria fazer primeiro esta semana?
```

Se ele responder com o que você contou, sem pedir de novo, o segundo cérebro está funcionando.

### Passo 5 · O hábito que faz funcionar

Termine toda conversa importante com:

```
Salva o que a gente decidiu na nota certa e no diário de hoje.
```

É isso que separa um cofre vivo de uma pasta esquecida. O Claude de amanhã sabe o que o de hoje aprendeu.

## 5. Pedidos para o dia a dia

| Quero | Peça assim |
|---|---|
| Organizar a semana | "Olha o meu cofre e monta a minha semana, com o que vence primeiro." |
| Guardar uma ideia rápida | "Anota no Inbox: [ideia]." Depois: "Organiza o Inbox." |
| Lembrar de uma conversa | "Cria a nota da reunião com [pessoa] de hoje: decisões, tarefas, prazos." |
| Estudar | "Explica [conceito] e salva em 03-Estudos/Conceitos, com as minhas palavras." |
| Escrever um post | "Escreve um post sobre [tema] com a minha voz (lê Conteudo/Minha Voz.md antes)." |
| Revisar o mês | "Lê os diários de novembro e me diz o que avançou e o que travou." |

## 6. Erros comuns

- **Tela bonita não é sistema.** Painel 3D, "central de comando", fábrica animada: impressiona, mas o que funciona é a organização por trás. Comece pelas pastas e pelo `CLAUDE.md`.
- **Abrir o Claude fora da pasta.** Ele só lê o cofre se for aberto dentro dele.
- **Não salvar no fim.** Sem o passo 5, na semana seguinte o Claude não lembra de nada.
- **Pôr segredo no cofre.** Senha, chave e dado de cliente ficam fora, sempre.
- **Acreditar em tudo.** A IA erra com a mesma confiança com que acerta. Confira número, nome e data.

## 7. Próximo nível

- **Especialistas:** agentes que o Claude chama quando a tarefa pede (revisor de código, estrategista, editor). O Jarvis instala 282.
- **Skills:** manuais que o Claude segue para um tipo de tarefa (editar vídeo, montar carrossel, auditar segurança). O [pacote completo](../pacote/README.md) instala as que eu uso.
- **Automação:** quando uma tarefa se repete toda semana do mesmo jeito, ela pode virar tarefa agendada.

Montou o seu? Me marca no Instagram: [@daviaietaa](https://www.instagram.com/daviaietaa/).
