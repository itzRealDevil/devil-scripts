#!/usr/bin/env bash
# [ DEVIL SECURE LOADER ]
set -euo pipefail

# استبدل YOUR_USERNAME باسم حسابك في GitHub
URL="https://raw.githubusercontent.com/YOUR_USERNAME/devil-scripts/main/devil_menu.sh"

clear
echo -e "\033[1;31m👿 Connecting to Devil Infrastructure...\033[0m"

script_file="$(mktemp)"
trap 'rm -f "$script_file"' EXIT

if curl -fsSL "$URL" -o "$script_file"; then
  bash "$script_file"
else
  echo -e "\033[0;31mError 404: Devil Scripts not found. Check your GitHub Username!\033[0m"
  exit 1
fi
