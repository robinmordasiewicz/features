#!/bin/env bash
set -e

EXTENSIONS=${EXTENSIONS:-undefined}

for ext in "${EXTENSIONS_ARRAY[@]}"; do
    npm install -g $ext || continue
done
