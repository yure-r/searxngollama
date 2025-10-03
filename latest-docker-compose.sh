#!/usr/bin/env bash
set -euo pipefail

# 1️⃣  Grab  the latest release tag from GitHub
GITHUB_REPO="open-webui/open-webui"
LATEST_TAG=$(curl -s "https://api.github.com/repos/$GITHUB_REPO/releases/latest" |
  jq -r .tag_name)

# 2️⃣  Fallback  to “main” if the API returned nothing
: "${LATEST_TAG:=main}"

# 3️⃣  Export  the tag so Compose sees it
export OPENWEBUI_TAG="$LATEST_TAG"

# 4️⃣  Pull  the image *before* starting the stack
docker compose pull open-webui

# 5️⃣  Bring  everything up
docker compose up -d
