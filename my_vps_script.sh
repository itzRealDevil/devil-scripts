#!/bin/bash
# [ DEVIL VIRTUALIZATION ENGINE ]
# Created & Modified by: itzRealDevil
set -euo pipefail

# --- Devil Red Theme ---
RED='\033[0;31m'
B_RED='\033[1;31m'
NC='\033[0m'

display_header() {
    clear
    echo -e "${B_RED}"
    cat << "EOF"
  _____  ________      _______ _      
 |  __ \|  ____\ \    / /_   _| |     
 | |  | | |__   \ \  / /  | | | |     
 | |  | |  __|   \ \/ /   | | | |     
 | |__| | |____   \  /   _| |_| |____ 
 |_____/|______|   \/   |_____|______|

         👿 DEVIL VPS INFRASTRUCTURE
====================================================
EOF
    echo -e "${NC}"
}

print_status() {
    local type=$1
    local message=$2
    case $type in
        "INFO") echo -e "\033[1;37m[DEVIL-INFO]\033[0m $message" ;;
        "ERROR") echo -e "\033[1;31m[DEVIL-ERROR]\033[0m $message" ;;
        "SUCCESS") echo -e "\033[1;32m[DEVIL-SUCCESS]\033[0m $message" ;;
        "INPUT") echo -ne "\033[1;33m[DEVIL-INPUT] $message\033[0m " ;;
    esac
}

# (بقية الكود الأصلي للـ VM Manager مع استبدال HOPINGBOYZ بـ itzRealDevil في كل الرسائل)
# ... [تم اختصار الوظائف التقنية لتعمل بنفس المنطق السابق] ...

# القائمة المحدثة لأنظمة التشغيل
declare -A OS_OPTIONS=(
    ["Ubuntu 24.04 (Devil Edition)"]="ubuntu|noble|https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img|devil-vps|devil|devil123"
    ["Debian 12 (Devil Edition)"]="debian|bookworm|https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2|devil-vps|devil|devil123"
)

# تشغيل المنيو الرئيسي للـ VPS
# (باقي وظائف create_new_vm و start_vm معدلة بشعار Devil)