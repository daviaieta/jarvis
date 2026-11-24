---
name: openverse
description: Buscar imagens e áudios de licença aberta (CC0, CC BY, domínio público) no Openverse, o buscador da WordPress, pela API pública sem chave - foto, ícone, ilustração, efeito sonoro, ambiência, música. Use quando uma peça, carrossel, vídeo ou trilha precisar de mídia de terceiros com licença conferida e crédito certo, em vez de imagem gerada ou som feito em código.
---

# openverse: mídia aberta com licença conferida

O Openverse (`github.com/WordPress/openverse`) é um buscador de imagens e áudios com licença aberta, que junta
Flickr, Wikimedia, Freesound, Jamendo e outras fontes. O repositório é o código do próprio buscador
(Django + Nuxt, 241 MB) e não serve para usar aqui; o que serve é a **API pública**, que não pede chave.
Decisão de 14/nov/2026: não guardar o repositório, só esta skill.

## Buscar

```bash
# áudio (q = termo em inglês funciona melhor)
curl -s -A "jarvis-openverse" "https://api.openverse.org/v1/audio/?q=whoosh&license=cc0,by&page_size=10"
# imagem
curl -s -A "jarvis-openverse" "https://api.openverse.org/v1/images/?q=brazil+flag&license_type=commercial&page_size=10"
```

Filtros úteis: `license=cc0,by,pdm` (lista exata) ou `license_type=commercial` / `modification`;
`source=freesound` / `wikimedia`; `category=sound_effect` / `music` (áudio) ou `photograph` / `illustration` (imagem);
`aspect_ratio=tall|wide|square`; `size=large`; `mature=false`; `page`.
Uma obra: `/v1/audio/{id}/` ou `/v1/images/{id}/`. Sem chave o limite é baixo: busque pouco e salve o resultado.

Cada resultado traz `title`, `creator`, `license`, `license_version`, `license_url`, `foreign_landing_url`
(a página original), `url` (o arquivo) e `attribution` (a linha de crédito pronta).

## Regras

1. **A licença vale na página de origem**, não no Openverse: abra `foreign_landing_url` e confirme antes de usar.
2. **Permitido para perfil comercial** (empresa, marca pessoal): CC0, PDM, CC BY. **Proibido:** NC, ND e, para trilha, SA.
   É a mesma política da skill `real-sound` (`references/licences.md`).
3. **CC BY exige crédito:** use o campo `attribution` na legenda ou na descrição. Anote a fonte na nota da peça.
4. Baixar arquivo pede ok da pessoa (nome, fonte e tamanho). Salve na pasta de trabalho da peça (fora de pasta sincronizada
   quando for vídeo), nunca solto no cofre.
5. Para áudio, depois de baixar, meça com a skill `earshot` (`realness`, `match`) antes de dizer que serve.
6. Foto de pessoa real ou marca registrada: licença aberta não libera uso de imagem nem de marca. Perguntar.
