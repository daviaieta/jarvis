# Pacote completo

Todas as skills e plugins que o Davi Aieta usa no dia a dia, num comando só. Lançado na live "Inteligência Artificial na
prática" (09/nov/2026), junto com o [tutorial do segundo cérebro](../docs/segundo-cerebro.md).

**Como vem:** nada de terceiros está copiado aqui dentro. O `instalar.sh` baixa cada skill **do repositório original**,
num commit fixo (o testado pelo Davi, anotado em `skills.tsv`), e cada uma segue a licença de quem a escreveu. O crédito
fica com quem fez. Só a pasta `minhas-skills/` é do Davi (MIT, como o resto deste repositório).

## Instalar

Se você instala o Jarvis agora, ele já oferece o pacote na Fase 2. Se instalou antes, abra o Claude Code na pasta do cofre
e cole:

```
Instala o pacote completo do Jarvis: https://github.com/daviaieta/jarvis
```

Ou rode você mesmo, num terminal (primeiro a simulação, que não mexe em nada):

```bash
T="$(mktemp -d)" && git clone -q --depth 1 https://github.com/daviaieta/jarvis.git "$T/jarvis" && bash "$T/jarvis/pacote/instalar.sh" --dry-run; rm -rf "$T"
```

```bash
T="$(mktemp -d)" && git clone -q --depth 1 https://github.com/daviaieta/jarvis.git "$T/jarvis" && bash "$T/jarvis/pacote/instalar.sh"; rm -rf "$T"
```

Leva uns 2 minutos. **Nada é sobrescrito:** skill com o mesmo nome que você já tenha fica como está. Depois, feche o Claude
Code e abra de novo: skill e plugin só aparecem em conversa nova.

**Por grupo:** `--grupo design` (ou `codigo`, `claude`, `apps`, `minhas`, `seguranca`; vários separados por vírgula).
Só as skills, sem plugins: `--sem-plugins`. Ajuda: `--help`.

## O que vem (o padrão)

**51 skills e 11 plugins**, em cima do que o Jarvis já instala (os 282 agentes, 6 plugins e 16 skills do README). Os plugins
trazem skills próprias: só o da Vercel traz umas 40.

### Do Davi (1 skill)

| Skill | O que faz |
|---|---|
| `edicao-video` | o método de edição de vídeo curto do Davi, com o Claude editando: contexto antes de ferramenta (perfil, estilo, regras), etapas com o seu ok, cada correção vira regra; vem com as regras e o estilo dele como ponto de partida e 5 ferramentas (preparar o bruto, achar silêncios, nivelar o áudio, guias de área segura, conferir a exportação). **Só Mac**; precisa de `brew install ffmpeg whisper-cpp` e do modelo `large-v3` do Whisper (uns 3 GB, baixado na primeira edição) |

### Design e interface (39 skills)

| Skills | De onde vem | Licença |
|---|---|---|
| `accessibility-compliance`, `design-system-patterns`, `responsive-design`, `tailwind-design-system` | [wshobson/agents](https://github.com/wshobson/agents) | MIT |
| `animate`, `animate-expo`, `animation-vocabulary`, `apple-design`, `ask-sonner`, `break-ui`, `emil-design-eng`, `find-animation-opportunities`, `improve-animations`, `mobile-native`, `pick-ui-library`, `prototype`, `review-animations` | [emilkowalski/skills](https://github.com/emilkowalski/skills) | MIT |
| `appllama-app-design-skill` | [Appllama/appllama-skills](https://github.com/Appllama/appllama-skills) | MIT |
| `canvas-design`, `theme-factory` | [anthropics/skills](https://github.com/anthropics/skills) | Apache-2.0 |
| `color-expert` | [meodai/skill.color-expert](https://github.com/meodai/skill.color-expert) | CC-BY-4.0 |
| `design-critique` | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Apache-2.0 |
| `hallmark` | [Nutlope/hallmark](https://github.com/Nutlope/hallmark) | MIT |
| `hue` | [dominikmartn/hue](https://github.com/dominikmartn/hue) | MIT |
| `impeccable` | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Apache-2.0 |
| `ip-as-logo-skill` | [s1dashu/ip-as-logo-skill](https://github.com/s1dashu/ip-as-logo-skill) | MIT |
| `kill-ai-slop` | [yetone/kill-ai-slop](https://github.com/yetone/kill-ai-slop) | Apache-2.0 |
| `landing-page-design` | [elayadesign/ai-design-skills](https://github.com/elayadesign/ai-design-skills) | MIT |
| `logo-generator-skill` | [op7418/logo-generator-skill](https://github.com/op7418/logo-generator-skill) | não declarada |
| `make-interfaces-feel-better` | [jakubkrehel/make-interfaces-feel-better](https://github.com/jakubkrehel/make-interfaces-feel-better) | MIT |
| `material-3` | [hamen/material-3-skill](https://github.com/hamen/material-3-skill) | MIT |
| `mono-color-skill` | [yanliudesign/mono-color-skill](https://github.com/yanliudesign/mono-color-skill) | MIT |
| `niblet` | [PyModel/niblet-skill-mcp](https://github.com/PyModel/niblet-skill-mcp) | Apache-2.0 |
| `refactoring-ui-skill` | [s0xDk/refactoring-ui-skill](https://github.com/s0xDk/refactoring-ui-skill) | não declarada |
| `taste-skill` | [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | MIT |
| `ui-design-brain` | [carmahhawwari/ui-design-brain](https://github.com/carmahhawwari/ui-design-brain) | não declarada |
| `ui-ux-pro-max` | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | MIT |
| `web-design` | [xiaopu-ai/web-design](https://github.com/xiaopu-ai/web-design) | MIT |
| `web-design-guidelines` | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | não declarada |

### Código (11 skills)

| Skills | De onde vem | Licença |
|---|---|---|
| `agent-browser` | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | Apache-2.0 |
| `api-design-principles`, `auth-implementation-patterns`, `modern-javascript-patterns`, `nextjs-app-router-patterns`, `openapi-spec-generation`, `react-native-architecture`, `react-state-management` | [wshobson/agents](https://github.com/wshobson/agents) | MIT |
| `remotion-best-practices` | [remotion-dev/skills](https://github.com/remotion-dev/skills) | não declarada |
| `reverse-engineer-anything` | [morluto/rea](https://github.com/morluto/rea) | MIT |
| `write-swift` | [emilkowalski/skills](https://github.com/emilkowalski/skills) | MIT |

### Plugins (11)

| Grupo | Plugins | De onde vem | Licença | Precisa |
|---|---|---|---|---|
| claude | `skill-creator`, `playwright`, `context7`, `github`, `vercel`, `security-guidance` | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | Apache-2.0 | `github` e `vercel` pedem conta |
| codigo | `codex` | [openai/codex-plugin-cc](https://github.com/openai/codex-plugin-cc) | Apache-2.0 | conta na OpenAI |
| apps | `paper-desktop` | [paper-design/agent-plugins](https://github.com/paper-design/agent-plugins) | não declarada | o app Paper aberto |
| apps | `warp` | [warpdotdev/claude-code-warp](https://github.com/warpdotdev/claude-code-warp) | MIT | o terminal Warp |
| apps | `savvy-progress`, `session-band` | [johnnyvizz/claude-kit](https://github.com/johnnyvizz/claude-kit) | MIT | nada |

## Segurança (só se você trabalha com isso)

Fora do padrão de propósito: traz listas de ataque (payloads, senhas, webshells) que o antivírus do computador pode pôr em
quarentena, e testes de invasão que **só se fazem em sistema seu ou com autorização por escrito**. Para instalar:
`--grupo seguranca`.

### Skills de segurança (12 skills)

| Skills | De onde vem | Licença |
|---|---|---|
| `llm-testing`, `security-fuzzing`, `security-passwords`, `security-patterns`, `security-payloads`, `security-usernames`, `security-webshells` | [Eyadkelleh/awesome-skills-security](https://github.com/Eyadkelleh/awesome-skills-security) | não declarada |
| `owasp-security` | [agamm/claude-code-owasp](https://github.com/agamm/claude-code-owasp) | MIT |
| `security-audit` | [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) | MIT |
| `security-auditor`, `threat-modeling` | [dralgorhythm/claude-agentic-framework](https://github.com/dralgorhythm/claude-agentic-framework) | não declarada |
| `snyk-fix` | [snyk/studio-recipes](https://github.com/snyk/studio-recipes) | Apache-2.0 |

| Plugins | De onde vem | Licença |
|---|---|---|
| `static-analysis`, `insecure-defaults`, `variant-analysis`, `differential-review`, `sharp-edges`, `yara-authoring`, `building-secure-contracts` | [trailofbits/skills](https://github.com/trailofbits/skills) | CC-BY-SA-4.0 |
| `secskills-core`, `secskills-defense`, `secskills-offense` | [trilwu/secskills](https://github.com/trilwu/secskills) | MIT |

## O que ficou de fora, e por quê

- **Skills de curso pago.** A licença é de quem vende o curso, e repassar o arquivo não é permitido. Se quiser, compre no curso.
- **Skills da É A Comunidade** (identidade visual e motion da casa): são da comunidade, não do Davi.
- **Skills sem origem pública conhecida:** sem saber de onde vieram, não dá para dar crédito nem conferir a licença.

## Antes de instalar

- **Peso:** o Claude Code lista a descrição de toda skill instalada em cada conversa; com o pacote, são dezenas de milhares
  de tokens a mais. Se pesar, instale por grupo ou peça ao Jarvis para enxugar.
- **Segurança:** leia o `instalar.sh` antes de rodar (cerca de 130 linhas, sem `sudo`, sem pedir senha). Os plugins de
  terceiros podem rodar um script no início da sessão, como qualquer plugin do Claude Code.
- **Contas externas:** o que pede conta (Codex, GitHub, Vercel, Snyk) só funciona com a sua, que você configura.
- **Desinstalar:** ver as perguntas frequentes do [README](../README.md#perguntas-frequentes).
