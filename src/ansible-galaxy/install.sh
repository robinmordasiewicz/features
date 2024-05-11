#!/bin/env bash
set -e

EXTENSIONS="${EXTENSIONS:-undefined}"

for ext in "${EXTENSIONS_ARRAY[@]}"; do
  ansible-galaxy collection install "${ext}" || continue
done
