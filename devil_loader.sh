#!/usr/bin/env bash
# [ DEVIL SECURE LOADER ]
set -euo pipefail

URL="https://raw.githubusercontent.com/itzRealDevil/devil-scripts/main/devil_menu.sh"

clear
echo -e "\033[1;31m👿 Connecting to Devil Infrastructure...\033[0m"

script_file="$(mktemp)"
trap 'rm -f "$script_file"' EXIT

if curl -fsSL "$URL" -o "$script_file"; then
  bash "$script_file"
else
  echo "Access Denied."
  exit 1
fi