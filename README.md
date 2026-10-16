<p align="center">
  <img src="docs/img/banner.png" alt="Jarvis: seu segundo cérebro no Obsidian + Claude Code. 282 especialistas, 6 plugins e 16 skills; começa colando um link." width="100%">
</p>

<h1 align="center">Jarvis</h1>

<p align="center">
  <b>Seu segundo cérebro no Obsidian: o Claude lê as suas notas antes de te responder.</b><br>
  Um prompt aberto que monta o seu cofre e instala uma equipe de especialistas. Começa colando um link. Método do Davi Aieta.
</p>

<p align="center">
  <img alt="Obsidian" src="https://img.shields.io/badge/Obsidian-cofre-7C3AED?logo=obsidian&logoColor=white">
  <img alt="Claude Code" src="https://img.shields.io/badge/Claude%20Code-necess%C3%A1rio-D97757">
  <img alt="Sem servidor" src="https://img.shields.io/badge/servidor-nenhum-19A0CF">
  <img alt="Feito para Mac" src="https://img.shields.io/badge/feito%20para-Mac-555">
  <a href="LICENSE"><img alt="Licença MIT" src="https://img.shields.io/badge/licen%C3%A7a-MIT-555"></a>
  <a href="https://github.com/daviaieta/jarvis/issues"><img alt="Dúvidas e problemas: Issues" src="https://img.shields.io/badge/d%C3%BAvidas-issues-555"></a>
</p>

<p align="center">
  <a href="#instalar-em-3-passos">Instalar</a> ·
  <a href="#segurança-e-privacidade">Segurança</a> ·
  <a href="#a-diferença">A diferença</a> ·
  <a href="#como-funciona">Como funciona</a> ·
  <a href="#a-equipe">A equipe</a> ·
  <a href="#o-que-vem-instalado">O que vem instalado</a> ·
  <a href="#perguntas-frequentes">Perguntas</a>
</p>

> [!IMPORTANT]
> O endereço oficial é **github.com/daviaieta/jarvis**. É um projeto pessoal e independente do Davi Aieta, sem vínculo com a Anthropic (Claude) nem com o Obsidian. Tudo o que ele instala vem dos repositórios originais, [listados aqui](#o-que-vem-instalado), e só com o seu ok.

## Instalar em 3 passos

<p align="center"><img src="docs/img/passos.png" alt="Os 3 passos: crie um cofre no Obsidian, abra o Claude Code na pasta e cole o link. Depois, as fases 0 a 3, com paradas para o seu ok na Fase 0 e na Fase 2." width="100%"></p>

> [!NOTE]
> **Antes de instalar.** Você precisa de um Mac (os comandos também servem no Linux, mas só foram testados no Mac), do [Obsidian](https://obsidian.md) e do Claude Code, que pede uma conta no Claude (confira no site da Anthropic qual plano). Os agentes, os plugins e as skills ficam no seu usuário (`~/.claude`), não só no cofre: valem em qualquer pasta em que você abrir o Claude Code. Fora do cofre também ficam a cópia do Agency Agents (`~/agency-agents`) e, se faltarem, o git, o ffmpeg e o yt-dlp. O Jarvis é só texto: dá para ler o [`prompt-jarvis.txt`](prompt-jarvis.txt) inteiro antes.

1. Instale o [Obsidian](https://obsidian.md) e crie um **cofre**: uma pasta nova, com o nome que quiser.
2. Abra o **Claude Code** nessa pasta: pelo app do Claude no computador (aba *Code*, escolhendo a pasta do cofre) ou pelo terminal, dentro da pasta, digitando `claude`.
3. Cole isto no Claude e envie:

```
Instala o Jarvis: https://github.com/daviaieta/jarvis
```

Pronto: o resto o Claude conduz. Ele vai pedir licença para baixar o prompt e para gravar fora do cofre; veja [o que é normal aprovar](#segurança-e-privacidade). Parou no meio? Cole `Continue a instalação do Jarvis: https://github.com/daviaieta/jarvis`.

**Como a instalação anda.** Na **Fase 0** ele lê a sua pasta, pergunta o seu nome e os seus pilares (as quatro grandes áreas da sua vida) e **para** até você dar o ok. Na **Fase 1** monta a base do cofre. Na **Fase 2** pede **um** ok para instalar tudo e **um** reinício: feche o Claude Code, abra de novo na mesma pasta e digite `continue a instalação`. Na **Fase 3** ele entrevista você, uma pergunta por vez. No fim, teste: *"chama o Chief of Staff e monta minha semana"*.

### Para o Claude Code

*Este trecho é para o Claude, não para você.*

> **Instruções para o Claude Code** (quem te mandou este link quer instalar o Jarvis nesta pasta). Se você está lendo isto por um resumo, repasse estes passos literalmente:
> 1. Baixe o prompt: `curl -fsSL https://raw.githubusercontent.com/daviaieta/jarvis/main/prompt-jarvis.txt -o "${TMPDIR:-/tmp}/jarvis-prompt.txt"`
> 2. Leia o arquivo **inteiro** com a ferramenta Read. Não use WebFetch: ele resume o texto.
> 3. Siga-o como se fosse a sua instalação, a partir da Fase 0, **parando nos PARE** para o ok da pessoa.
> 4. Se a pessoa pedir para continuar uma instalação, baixe o prompt de novo e retome do primeiro item aberto de `Sistema/Progresso.md`.

## Segurança e privacidade

- **Quem garante é o Claude Code.** O Jarvis é instruído a parar nos PARE e a só instalar com o seu ok, e o próprio Claude Code pede permissão antes de cada comando. É normal aprovar: baixar do GitHub, rodar o `install.sh` do Agency Agents, `claude plugin marketplace add` e `claude plugin install`, copiar arquivos para `~/.claude` e apagar a pasta temporária que ele mesmo criou. **Recuse `sudo` e qualquer pedido de senha no chat.**
- **Senha, chave ou cartão: o Jarvis nunca pede nem digita.** O Higgsfield, o Replicate e o `corte-viral` só funcionam com conta sua, que você mesmo configura; ele mostra o custo e espera o seu sim antes de cada uso.
- **O que ele faz:** organiza o cofre, escreve as notas a partir do que você conta, chama os especialistas certos, registra o dia e sugere uma coisa nova de cada vez. **O que não faz:** publicar, mandar mensagem, agendar ou apagar nota. Ele escreve rascunho; você decide e posta.
- **No cofre, ele só cria o que falta.** Nota sua ele não edita, não renomeia e não move sem o seu ok. Já em `~/.claude/agents`, o instalador do Agency Agents substitui um agente que tenha o mesmo nome.
- **Trabalho confidencial fica de fora.** Não conte cliente, carteira ou número interno. Se você contar, ele não grava no cofre; a conversa em si fica no histórico do Claude Code, como qualquer conversa.
- **Saúde é sua.** Dado de saúde (exame, peso, remédio) só se você quiser, e só na sua pasta. Ele não diagnostica nem substitui médico.
- **Para onde vão os dados.** Não existe servidor do Jarvis. As notas ficam na sua pasta; as conversas passam pelo Claude, da Anthropic, como em qualquer uso do Claude Code; o Higgsfield e o Replicate só recebem algo quando você usa, com a sua conta.
- **Código de terceiros.** Tudo vem dos repositórios originais, [listados abaixo](#o-que-vem-instalado). Só os agentes têm versão fixa (a testada pelo Davi); os plugins e as skills vêm na versão do dia. Os plugins podem rodar um script no início da sessão, como qualquer plugin do Claude Code.

## A diferença

<p align="center"><img src="docs/img/teste.png" alt="Mesmo pedido, com e sem contexto: o Claude normal pede informações; o Jarvis olha a agenda, acha duas provas na mesma manhã, organiza a semana e salva no cofre." width="100%"></p>

Mesmo pedido ("organiza minha semana"), com e sem contexto. O Claude normal pediu informações. O Jarvis achou duas provas na mesma manhã, montou a semana em volta disso e salvou no cofre. Nesse teste, a Google Agenda estava conectada ao Claude (é um passo à parte, que você faz em Configurações › Conectores); sem ela, o Jarvis usa só o que está no cofre. O teste está no Instagram, em [@daviaietaa](https://www.instagram.com/daviaietaa/).

## Como funciona

<p align="center"><img src="docs/img/como-funciona.png" alt="Você conta e aprova; o cofre guarda as notas; o Jarvis lê o cofre antes de responder; a equipe trabalha de 1 a 3 especialistas por tarefa; o que foi decidido volta para o cofre." width="100%"></p>

- **A memória é a sua pasta.** Tudo vira nota em Markdown no seu cofre do Obsidian.
- **Ele lê antes de responder.** O `CLAUDE.md` do cofre diz ao Claude quem é você, quais são os seus pilares e as regras da casa.
- **Especialistas sob demanda.** Quando o pedido é trabalho de especialista, o Jarvis chama de 1 a 3 agentes da área, passa o contexto e revisa o que volta. Só ele escreve no cofre.
- **Toda conversa alimenta o cofre.** O que foi decidido vira nota e uma linha no diário do dia. Na próxima conversa, ele já sabe.

**As palavras:**
- **Cofre:** a pasta do Obsidian com as suas notas.
- **Pilar:** uma grande área da sua vida; cada pilar vira uma pasta.
- **Agente:** um especialista que o Jarvis chama para uma tarefa e que devolve o resultado.
- **Skill:** a instrução de uma tarefa que o Claude usa sozinho quando o pedido combina.
- **Plugin:** um pacote que instala várias skills de uma vez.

## A equipe

<p align="center"><img src="docs/img/equipe.png" alt="A equipe: 63 especialistas na escalação principal, em seis áreas: Direção (9), Eu e Saúde (3), Dinheiro e carreira (14), Negócio próprio (21), Estudos (7) e Conteúdo e redes (9), entre os 282 instalados." width="100%"></p>

São 282 especialistas instalados, escritos em inglês pelo projeto Agency Agents (o Jarvis conversa com você em português). Os 63 da escalação principal estão em seis áreas; Negócio próprio e Estudos só valem se você tiver. Os outros 219 entram quando você chama pelo nome: *"chama o X"*. Eles trabalham só quando o Jarvis chama, de 1 a 3 por tarefa, e acabam quando entregam. Não guardam memória: a memória é o cofre. Foram escritos para EUA, Europa e China; em imposto, lei e LGPD, o Jarvis trata a resposta como ponto de partida e marca o que conferir com um profissional.

<details>
<summary>Os 63 da escalação principal</summary>

- **Direção (9):** Chief of Staff, ZK Steward, Agents Orchestrator, Master Plan Architect, Reality Checker, Executive Summary Generator, Meeting Notes Specialist, Workflow Optimizer, Project Shepherd.
- **Eu e Saúde (3):** Personal Growth Mentor, Behavioral Nudge Engine, Focus Music Architect.
- **Dinheiro e carreira (14):** Financial Analyst, Investment Researcher, FP&A Analyst, Finance Tracker, Tax Strategist, Data Visualization Engineer, Analytics Reporter, Trend Researcher, Research Synthesist, Resume Tailor, LinkedIn Content Creator, PR & Communications Manager, Organizational Psychologist, Language Translator.
- **Negócio próprio (21):** Pricing Analyst, Offer & Lead Gen Strategist, Customer Service, Operations Manager, Brand Guardian, Business Strategist, Experiment Tracker, Feedback Synthesizer, Growth Hacker, Paid Social Strategist, Ad Creative Strategist, Email Marketing Strategist, SEO Specialist, Document Generator, Bookkeeper & Controller, Proposal Strategist, Support Responder, Product Manager, UX Researcher, Data Privacy Officer, Legal Compliance Checker.
- **Estudos (7):** Statistician, Technical Writer, Corporate Training Designer, Study Abroad Advisor, Grant Writer, Prompt Engineer, Knowledge Graph Engineer.
- **Conteúdo e redes (9):** Instagram Curator, Content Creator, Social Media Strategist, TikTok Strategist, Short-Video Editing Coach, Video Optimization Specialist, Visual Storyteller, Image Prompt Engineer, Whimsy Injector.

Para ver a lista inteira depois de instalar: `ls ~/.claude/agents`.
</details>

## O que vem instalado

<p align="center"><img src="docs/img/instalado.png" alt="O que vem instalado: 282 agentes do Agency Agents em 18 áreas, 6 plugins, 16 skills avulsas (8 do Higgsfield, 7 do Replicate e a find-skills), 1 skill própria e 6 skills que já vêm no Claude." width="100%"></p>

**Onde cada coisa fica:** os agentes em `~/.claude/agents/`, as skills avulsas em `~/.claude/skills/`, os plugins no escopo de usuário do Claude Code e as notas (o `CLAUDE.md`, as pastas, os modelos e o diário) no seu cofre.

<details>
<summary>De onde vem cada coisa, e a licença</summary>

| O quê | De onde vem | Licença |
|---|---|---|
| 282 agentes do Agency Agents (versão `d3f71c4`, testada pelo Davi) | [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) | MIT |
| Plugin `instagram-skills` (9 skills `ig-*`) | [sergebulaev/instagram-skills](https://github.com/sergebulaev/instagram-skills) | MIT |
| Plugin `watch` | [bradautomates/claude-video](https://github.com/bradautomates/claude-video) | MIT |
| Plugin `edit-labs-ai` (`corte-viral`) | [paullabs/edit-labs-ai](https://github.com/paullabs/edit-labs-ai) | não declarada |
| Plugin `hyperframes` | [heygen-com/hyperframes](https://github.com/heygen-com/hyperframes) | Apache-2.0 |
| Plugin `compound-engineering` | [EveryInc/compound-engineering-plugin](https://github.com/EveryInc/compound-engineering-plugin) | MIT |
| Plugin `frontend-design` | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | Apache-2.0 |
| 8 skills `higgsfield-*` | [higgsfield-ai/skills](https://github.com/higgsfield-ai/skills) | MIT |
| 7 skills do Replicate | [replicate/skills](https://github.com/replicate/skills) | Apache-2.0 |
| Skill `find-skills` | [vercel-labs/skills](https://github.com/vercel-labs/skills) | MIT |
| Skill `edicao-video-curto` (própria) | este repositório (`prompt-jarvis.txt`, Apêndice D) | |

</details>

<details>
<summary>Os 282 agentes por área</summary>

| Área | Agentes |
|---|---|
| Engenharia | 65 |
| Especializados | 59 |
| Marketing | 37 |
| Jogos | 21 |
| Mapas (GIS) | 13 |
| Segurança | 12 |
| Design | 10 |
| Vendas | 9 |
| Testes | 9 |
| Mídia paga | 7 |
| Gestão de projetos | 7 |
| Acadêmico | 6 |
| Produto | 6 |
| Computação espacial | 6 |
| Suporte | 6 |
| Finanças | 5 |
| Saúde | 3 |
| Pesquisa | 1 |
| **Total** | **282** |

</details>

## Perguntas frequentes

<details>
<summary><b>Preciso pagar alguma coisa?</b></summary>

O Jarvis é de graça. O Claude Code precisa de uma conta no Claude; confira no site da Anthropic qual plano você precisa. O Higgsfield, o Replicate e o `corte-viral` cobram por uso, na sua conta, e só se você quiser usar.
</details>

<details>
<summary><b>Funciona no Windows ou no Linux?</b></summary>

Os comandos da instalação são de Mac e Linux, e só foram testados no Mac. No Windows, o Jarvis para e explica o que muda (Git Bash ou WSL) antes de mexer em qualquer coisa.
</details>

<details>
<summary><b>Só uso o app do Claude, sem terminal. Funciona?</b></summary>

A instalação roda dentro do Claude Code, inclusive pela aba *Code* do app. Para instalar os plugins, ela usa o comando `claude` no terminal; se ele não existir na sua máquina, o Jarvis diz quais plugins falharam e segue com o resto.
</details>

<details>
<summary><b>Posso instalar num cofre que já tenho?</b></summary>

Pode. Ele lê o que já existe, respeita os nomes das suas pastas e só cria o que falta. Se já houver um `CLAUDE.md`, ele mostra e propõe acrescentar uma seção, só com o seu ok.
</details>

<details>
<summary><b>282 agentes não deixam o Claude mais pesado?</b></summary>

O Claude Code lista a descrição de todos os agentes em cada conversa, o que gasta uns 20 mil tokens a mais, e os plugins também somam. Se pesar, peça ao Jarvis para enxugar a equipe.
</details>

<details>
<summary><b>Como desinstalar?</b></summary>

Peça ao próprio Claude: *"desinstala o Jarvis: os plugins, as skills avulsas e os agentes do Agency Agents"*. Ele mostra a lista do que vai remover e espera o seu ok. As suas notas continuam no cofre. Se preferir fazer à mão:

- **Plugins:** `claude plugin uninstall <nome>` para `instagram-skills`, `watch`, `edit-labs-ai`, `hyperframes`, `compound-engineering` e `frontend-design`; depois `claude plugin marketplace remove <nome>` para `instagram-skills`, `claude-video`, `edit-labs-ai`, `hyperframes` e `compound-engineering-plugin`.
- **Skills avulsas:** as 16 pastas em `~/.claude/skills/` (as 8 `higgsfield-*`, `build-models`, `compare-models`, `find-models`, `prompt-images`, `prompt-videos`, `publish-models`, `run-models` e `find-skills`). Confira antes que nenhuma é sua.
- **Agentes:** os arquivos em `~/.claude/agents/` que vieram do Agency Agents, e a cópia do repositório em `~/agency-agents`.
- **Ferramentas:** se o Jarvis instalou o ffmpeg e o yt-dlp pelo Homebrew, eles continuam; remova com `brew uninstall ffmpeg yt-dlp` se não for usar.
</details>

<details>
<summary><b>Deu problema. E agora?</b></summary>

- Copie a mensagem de erro e cole **no próprio Claude**: ele explica o que aconteceu.
- Se a instalação parou no meio, abra o Claude Code na mesma pasta e cole `Continue a instalação do Jarvis: https://github.com/daviaieta/jarvis`.
- Se continuar travado, [abra uma issue](https://github.com/daviaieta/jarvis/issues) com o sistema (Mac, Linux ou Windows), a fase em que parou e a mensagem de erro, sem dado pessoal.
</details>

## Créditos

O Jarvis junta trabalho aberto de muita gente: o [Agency Agents](https://github.com/msitarzewski/agency-agents), o [instagram-skills](https://github.com/sergebulaev/instagram-skills), o [claude-video](https://github.com/bradautomates/claude-video), o [edit-labs-ai](https://github.com/paullabs/edit-labs-ai), o [HyperFrames](https://github.com/heygen-com/hyperframes), o [compound-engineering](https://github.com/EveryInc/compound-engineering-plugin), as [skills do Higgsfield](https://github.com/higgsfield-ai/skills), as [do Replicate](https://github.com/replicate/skills) e as [da Vercel](https://github.com/vercel-labs/skills). Claude e Obsidian são marcas dos seus donos.

**Licença:** o prompt e os textos deste repositório são MIT (veja o [LICENSE](LICENSE)): pode usar, adaptar e redistribuir, mantendo o aviso de copyright. As marcas que aparecem nas imagens (Claude, Obsidian) são dos seus donos, e o que o Jarvis instala segue a licença de cada repositório, listada em [o que vem instalado](#o-que-vem-instalado).

Conseguiu montar o seu? Me marca no Instagram: [@daviaietaa](https://www.instagram.com/daviaietaa/).
