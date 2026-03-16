#!/usr/bin/env bash
# [ DEVIL HOSTING MANAGER - LOADER ]
# Created by: itzRealDevil
set -euo pipefail

# الرابط المباشر لملف القائمة الجديد تبعك على GitHub
URL="https://raw.githubusercontent.com/itzRealDevil/devil-scripts/main/devil_menu.sh"

# التأكد من وجود curl
if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required but not installed." >&2
  exit 1
fi

clear
echo -e "\033[0;31m"
echo "------------------------------------------"
echo "        🚀 DEVIL PTERO MANAGER           "
echo "          Powered by itzRealDevil        "
echo "------------------------------------------"
echo -e "\033[0m"

# سحب ملف المنيو وتشغيله
script_file="$(mktemp)"
cleanup() { rm -f "$script_file"; }
trap cleanup EXIT

echo "Connecting to Devil Servers..."

# السحب من GitHub مباشرة بدون تعقيد
if curl -fsSL "$URL" -o "$script_file"; then
  bash "$script_file"
else
  echo "Error: Could not connect to Devil Repository." >&2
  exit 1
fi
