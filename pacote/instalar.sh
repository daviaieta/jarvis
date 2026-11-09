#!/usr/bin/env bash
# Pacote completo do Jarvis: instala as skills e os plugins que o Davi usa, direto dos repositórios originais.
#
#   bash pacote/instalar.sh                          # o padrão: design, codigo, claude, apps e minhas
#   bash pacote/instalar.sh --grupo design,codigo    # só esses grupos
#   bash pacote/instalar.sh --grupo seguranca        # segurança: só se você trabalha com isso (ver o README do pacote)
#   bash pacote/instalar.sh --dry-run                # mostra o que faria, sem mexer em nada
#   bash pacote/instalar.sh --sem-plugins            # só as skills
#
# Regras: nada é sobrescrito (skill que já existe em ~/.claude/skills fica como está); cada skill vem do commit fixado
# em skills.tsv, numa pasta temporária apagada no fim; nenhum comando usa sudo nem pede senha.
# Roda no Mac e no Linux (bash 3.2 ou mais novo). Precisa de git; os plugins precisam do comando `claude`.
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINO="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"
VALIDOS="design,codigo,seguranca,claude,apps,minhas"
GRUPOS="design,codigo,claude,apps,minhas"
SECO=0
PLUGINS=1
export GIT_TERMINAL_PROMPT=0

while [ $# -gt 0 ]; do
  case "$1" in
    --grupo)
      [ $# -ge 2 ] || { echo "Falta o nome do grupo depois de --grupo ($VALIDOS)."; exit 1; }
      GRUPOS="$2"; shift 2
      for g in $(echo "$GRUPOS" | tr ',' ' '); do
        case ",$VALIDOS," in *",$g,"*) ;; *) echo "Grupo desconhecido: $g (os grupos são: $VALIDOS)"; exit 1 ;; esac
      done ;;
    --dry-run) SECO=1; shift ;;
    --sem-plugins) PLUGINS=0; shift ;;
    -h|--help) sed -n '2,13p' "$0"; exit 0 ;;
    *) echo "Opção desconhecida: $1 (use --help)"; exit 1 ;;
  esac
done

quer_grupo() { case ",$GRUPOS," in *",$1,"*) return 0 ;; *) return 1 ;; esac; }
existe() { [ -e "$1" ] || [ -L "$1" ]; }

command -v git >/dev/null || { echo "Falta o git. No Mac: xcode-select --install"; exit 1; }
[ "$SECO" = 1 ] || mkdir -p "$DESTINO"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

instaladas=0; ja_tinha=0; falhas=""
TAB="$(printf '\t')"

baixar() {  # baixar <repo> <commit> <pasta-destino>: só aquele commit, sem symlinks
  local repo="$1" sha="$2" alvo="$3"
  mkdir -p "$alvo" && git -C "$alvo" init -q &&
    git -C "$alvo" -c core.symlinks=false fetch -q --depth 1 "https://github.com/$repo.git" "$sha" &&
    git -C "$alvo" -c core.symlinks=false checkout -q FETCH_HEAD
}

# --- 1. Skills de terceiros (pacote/skills.tsv) ----------------------------------------------------------------------
tabela="$(grep -v '^#' "$AQUI/skills.tsv")"
repos="$(printf '%s\n' "$tabela" | awk -F'\t' '{print $3}' | sort -u)"
for repo in $repos; do
  linhas="$(printf '%s\n' "$tabela" | awk -F'\t' -v r="$repo" '$3==r')"
  precisa=0; sha=""
  while IFS="$TAB" read -r grupo nome _ pasta licenca commit; do
    sha="$commit"
    quer_grupo "$grupo" || continue
    existe "$DESTINO/$nome" || precisa=1
  done <<EOF
$linhas
EOF
  clone="$TMP/$(echo "$repo" | tr '/' '_')"
  if [ "$precisa" = 1 ] && [ "$SECO" = 0 ]; then
    if ! baixar "$repo" "$sha" "$clone" >/dev/null 2>&1; then
      falhas="$falhas\n  - $repo (não consegui baixar o commit ${sha:0:8})"; continue
    fi
  fi
  while IFS="$TAB" read -r grupo nome _ pasta licenca commit; do
    quer_grupo "$grupo" || continue
    if existe "$DESTINO/$nome"; then ja_tinha=$((ja_tinha+1)); echo "  = $nome (já existe, não mexi)"; continue; fi
    if [ "$SECO" = 1 ]; then echo "  + $nome  ←  $repo/$pasta @${commit:0:8}  ($licenca)"; instaladas=$((instaladas+1)); continue; fi
    origem="$clone/$pasta"
    if [ ! -f "$origem/SKILL.md" ]; then falhas="$falhas\n  - $nome (não achei $pasta/SKILL.md em $repo)"; continue; fi
    case "$(cd "$origem" && pwd -P)/" in "$(cd "$clone" && pwd -P)/"*) ;; *) falhas="$falhas\n  - $nome (pasta fora do repositório)"; continue ;; esac
    parcial="$DESTINO/.parcial-$nome"
    rm -rf "$parcial"; mkdir -p "$parcial"
    if (cd "$origem" && tar --exclude .git --exclude .github --exclude node_modules -cf - .) | (cd "$parcial" && tar -xf -) \
       && mv "$parcial" "$DESTINO/$nome"; then
      echo "  + $nome  ←  $repo  ($licenca)"; instaladas=$((instaladas+1))
    else
      rm -rf "$parcial"; falhas="$falhas\n  - $nome (a cópia falhou; nada ficou pela metade)"
    fi
  done <<EOF
$linhas
EOF
done

# --- 2. As skills do próprio Davi (pacote/minhas-skills) --------------------------------------------------------------
if quer_grupo minhas; then
  for d in "$AQUI"/minhas-skills/*/; do
    [ -f "$d/SKILL.md" ] || continue
    nome="$(basename "$d")"
    if existe "$DESTINO/$nome"; then ja_tinha=$((ja_tinha+1)); echo "  = $nome (já existe, não mexi)"; continue; fi
    if [ "$SECO" = 1 ]; then echo "  + $nome  ←  este repositório"
    else cp -R "$d" "$DESTINO/$nome"; echo "  + $nome  ←  este repositório (MIT)"; fi
    instaladas=$((instaladas+1))
  done
fi

# --- 3. Plugins (pacote/plugins.tsv) ----------------------------------------------------------------------------------
plugins_ok=0
if [ "$PLUGINS" = 1 ]; then
  if ! command -v claude >/dev/null; then
    echo "  ! sem o comando 'claude' neste terminal: os plugins ficaram de fora (veja o README do pacote)."
  else
    ja_add=""
    while IFS="$TAB" read -r grupo plugin repo mkt licenca precisa; do
      case "$grupo" in \#*|"") continue ;; esac
      quer_grupo "$grupo" || continue
      if [ "$SECO" = 1 ]; then echo "  + plugin $plugin@$mkt  ($licenca; precisa: $precisa)"; plugins_ok=$((plugins_ok+1)); continue; fi
      case " $ja_add " in *" $mkt "*) ;; *) claude plugin marketplace add "$repo" </dev/null >/dev/null 2>&1 || true; ja_add="$ja_add $mkt" ;; esac
      if claude plugin install "$plugin@$mkt" </dev/null >/dev/null 2>&1; then
        echo "  + plugin $plugin  ($licenca)"; plugins_ok=$((plugins_ok+1))
      else
        falhas="$falhas\n  - plugin $plugin@$mkt (o install não deu certo, ou ele já estava instalado: rode à mão para ver)"
      fi
    done < "$AQUI/plugins.tsv"
  fi
fi

echo
[ "$SECO" = 1 ] && echo "Simulação: nada foi instalado."
echo "Grupos: $GRUPOS"
echo "Skills novas: $instaladas · já existiam: $ja_tinha · plugins: $plugins_ok"
[ -n "$falhas" ] && printf "Não deu certo:%b\n" "$falhas"
echo "Feche o Claude Code e abra de novo na pasta do cofre: skills e plugins só aparecem em conversa nova."
