# Jarvis: seu segundo cérebro em 7 passos

O **Jarvis** é um prompt que transforma uma pasta do Obsidian no seu segundo cérebro. O Claude lê o que você escreveu antes de te responder e passa a ter até 63 especialistas à disposição. Você escolhe os grupos que servem, e eles trabalham um de cada vez, só quando o trabalho pede. Método do Davi Aieta.

**O que você precisa:** um computador, o Obsidian, o Claude Code e uns minutos por etapa. Os passos de instalação foram feitos para **Mac**. No Windows alguns comandos mudam, e o Jarvis avisa antes de mexer.

## O prompt

[**prompt-jarvis.txt**](prompt-jarvis.txt): abra o arquivo e clique no ícone de copiar, no canto de cima à direita da caixa. Ele é grande, e isso é normal.

## Os 7 passos

1. **Instale o Obsidian** em [obsidian.md](https://obsidian.md) e crie um **cofre**: uma pasta nova, com o nome que quiser, num lugar fácil de achar.
2. **Abra o Claude Code nessa pasta.** Pelo app do Claude no computador (aba *Code*, escolhendo a pasta do cofre) ou pelo terminal, dentro da pasta, digitando `claude`. O Claude Code precisa de uma conta no Claude; confira no site da Anthropic qual plano você precisa.
3. **Abra uma conversa nova, cole o prompt inteiro** e envie.
4. **Responda e aprove.** O Jarvis começa lendo sua pasta e **para** (ele escreve PARE) para você dar o ok antes de criar, instalar ou rodar qualquer coisa. Vão aparecer também pedidos de permissão do próprio Claude Code: leia e aprove o que fizer sentido.
5. **Reinicie uma vez.** Quando ele pedir, feche o Claude Code, abra de novo **na mesma pasta** e digite: `continue a instalação`.
6. **Faça a entrevista.** Ele pergunta uma coisa por vez sobre você e sobre as quatro áreas da sua vida. Pode parar e voltar depois: ele lê o `Sistema/Progresso.md` e continua de onde parou.
7. **Teste.** Peça: *"chama o Chief of Staff e monta minha semana"*.

## O que o Jarvis faz, e o que não faz

- **Faz:** organiza o cofre, escreve as notas a partir do que você conta, chama os especialistas certos, registra o dia e sugere uma coisa nova de cada vez.
- **Não faz:** publicar, mandar mensagem, agendar ou apagar nota. Ele escreve rascunho; você decide e posta.
- **Os especialistas** não trabalham sozinhos nem de madrugada: só quando o Jarvis chama, de 1 a 3 por tarefa, e acabam quando entregam.

## O que não contar para ele

- Nada **confidencial do seu trabalho**: cliente, carteira, número interno. Se você contar, ele não guarda.
- Dado de **saúde** (exame, peso, remédio) só se você quiser, e ele fica só na sua pasta.
- **Senha, chave ou cartão:** o Jarvis nunca pede. Se pedir, pare.

## Se travar

- Copie a mensagem de erro e cole **no próprio Claude**: ele explica o que aconteceu.
- Se algum passo falhar, não troque nada às cegas: o Jarvis só segue com o seu ok.

## Avisos

- O prompt instala dois plugins e uma equipe de agentes feitos por terceiros, de repositórios abertos ([Agency Agents](https://github.com/msitarzewski/agency-agents), [instagram-skills](https://github.com/sergebulaev/instagram-skills) e [claude-video](https://github.com/bradautomates/claude-video)). O Jarvis avisa antes e só instala com o seu ok.
- Cada especialista chamado gasta tempo e uso da sua conta do Claude. Por isso o Jarvis só chama quando o trabalho é de verdade.

Conseguiu montar o seu? Me marca no Instagram: [@daviaietaa](https://www.instagram.com/daviaietaa/).
