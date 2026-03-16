#!/usr/bin/env bash
# [ DEVIL SECURE LOADER ]
# Created by: itzRealDevil
set -euo pipefail

# رابط المنيو الأساسي من مستودعك - تأكد أن المسار صحيح
URL="https://raw.githubusercontent.com/itzRealDevil/devil-scripts/main/devil_menu.sh"

clear
echo -e "\033[1;31m"
cat << "EOF"
  _____  ________      _______ _      
 |  __ \|  ____\ \    / /_   _| |     
 | |  | | |__   \ \  / /  | | | |     
 | |  | |  __|   \ \/ /   | | | |     
 | |__| | |____   \  /   _| |_| |____ 
 |_____/|______|   \/   |_____|______|

     👿 CONNECTING TO DEVIL INFRASTRUCTURE...
EOF
echo -e "\033[0m"

script_file="$(mktemp)"
trap 'rm -f "$script_file"' EXIT

# محاولة سحب المنيو
if curl -fsSL "$URL" -o "$script_file"; then
    bash "$script_file"
else
    echo -e "\033[1;31m[!] Error: Access Denied or Connection Failed.\033[0m"
    echo -e "\033[1;37mCheck your GitHub repository visibility (Must be Public).\033[0m"
    exit 1
fi
