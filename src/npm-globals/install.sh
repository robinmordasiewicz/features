#!/bin/env bash
set -e

EXTENSIONS="${EXTENSIONS:-undefined}"

npm install -g npm@latest

for ext in "${EXTENSIONS_ARRAY[@]}"; do
  npm install -g "${ext}" || continue
done
