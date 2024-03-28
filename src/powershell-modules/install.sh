#!/bin/env bash
set -e

EXTENSIONS=${EXTENSIONS:-undefined}

for ext in "${EXTENSIONS_ARRAY[@]}"; do
    pwsh -NoProfile -NonInteractive -Command "Install-Module -Name $ext -Repository PSGallery -AllowClobber -Force -Scope AllUsers" || continue
done
