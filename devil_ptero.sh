#!/usr/bin/env bash
# [ DEVIL HOSTING MANAGER - LOADER ]
# Created by: itzRealDevil
set -euo pipefail

# الرابط المباشر لملف المنيو (تأكد أن الاسم مطابق تماماً)
URL="https://raw.githubusercontent.com/itzRealDevil/devil-scripts/main/devil_menu.sh"

if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required." >&2
  exit 1
fi

clear
echo -e "\033[1;31m"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "        👿 DEVIL PTERO LOADER ACTIVATED          "
echo "          Checking Repository Status...          "
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "\033[0m"

script_file="$(mktemp)"
cleanup() { rm -f "$script_file"; }
trap cleanup EXIT

# إضافة timestamp لكسر الكاش برمجياً
if curl -fsSL "${URL}?$(date +%s)" -o "$script_file"; then
  bash "$script_file"
else
  echo -e "\033[0;31m❌ Error: Could not reach Devil Repository.\033[0m" >&2
  exit 1
fi
