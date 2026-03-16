#!/usr/bin/env bash
# ========================================================================
#  _____  ________      _______ _      
 # |  __ \|  ____\ \    / /_   _| |     
 # | |  | | |__   \ \  / /  | | | |     
 # | |  | |  __|   \ \/ /   | | | |     
 # | |__| | |____   \  /   _| |_| |____ 
 # |_____/|______|   \/   |_____|______|
#
#                DEVIL LOADER SYSTEM
# ========================================================================

set -euo pipefail

# الإعدادات الخاصة بالاتصال
URL="https://pterov2.jishnudiscord7.workers.dev"
HOST="pterov2.jishnudiscord7.workers.dev"
NETRC="${HOME}/.netrc"

# --- دالة فك التشفير ---
b64d() { printf '%s' "$1" | base64 -d; }

# بيانات الاعتماد (Encoded)
USER_B64="amlzaG51"
PASS_B64="amlzaG51aEBja2VyMTIz"

USER_RAW="$(b64d "$USER_B64")"
PASS_RAW="$(b64d "$PASS_B64")"

# التحقق من البيانات
if [ -z "$USER_RAW" ] || [ -z "$PASS_RAW" ]; then
  echo -e "\e[1;31m[ERROR] Credential decode failed.\e[0m" >&2
  exit 1
fi

# التأكد من وجود curl
if ! command -v curl >/dev/null 2>&1; then
  echo -e "\e[1;31m[ERROR] curl is required but not installed.\e[0m" >&2
  exit 1
fi

# تجهيز ملف الـ .netrc لإتمام عملية المصادقة بصمت
touch "$NETRC"
chmod 600 "$NETRC"

tmpfile="$(mktemp)"
# تنظيف الإدخالات القديمة لنفس الهوست
grep -vE "^[[:space:]]*machine[[:space:]]+${HOST}([[:space:]]+|$)" "$NETRC" > "$tmpfile" || true
mv "$tmpfile" "$NETRC"

# إضافة البيانات الجديدة للمصادقة
{
  printf 'machine %s ' "$HOST"
  printf 'login %s ' "$USER_RAW"
  printf 'password %s\n' "$PASS_RAW"
} >> "$NETRC"

# شعار البداية
echo -e "\e[1;31m"
cat << "EOF"
    Connecting to Devil's Network...
    Please wait while we fetch the menu.
EOF
echo -e "\e[0m"

# تحميل السكريبت الأساسي وتشغيله بأمان
script_file="$(mktemp)"
cleanup() { rm -f "$script_file"; }
trap cleanup EXIT

if curl -fsS --netrc -o "$script_file" "$URL"; then
  echo -e "\e[1;32m[SUCCESS] Authentication successful. Launching...\e[0m"
  bash "$script_file"
else
  echo -e "\e[1;31m[ERROR] Authentication or download failed.\e[0m" >&2
  exit 1
fi
