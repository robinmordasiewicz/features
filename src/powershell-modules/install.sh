#!/bin/env bash
set -e

MODULES=${MODULES:-undefined}
IFS=',' read -ra MODULES_ARRAY <<< "$MODULES"

for mod in "${MODULES_ARRAY[@]}"; do
    pwsh -NoProfile -NonInteractive -Command "Install-Module -Name $mod -Repository PSGallery -AllowClobber -Force -Scope AllUsers" || continue
done
