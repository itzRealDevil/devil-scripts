#!/bin/bash
# [ DEVIL VIRTUALIZATION ENGINE ]
# Created & Modified by: itzRealDevil
set -euo pipefail

RED='\033[0;31m'
B_RED='\033[1;31m'
NC='\033[0m'

# الشعار الاحترافي للـ VPS
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

# دالة التحقق من المتطلبات (Docker)
check_deps() {
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}[!] Installing Docker Engine...${NC}"
        curl -fsSL https://get.docker.com | sh
    fi
}

# دالة إنشاء الجهاز الوهمي
create_vps() {
    display_header
    echo -ne "${RED}Enter VPS Name: ${NC}"; read -r NAME
    echo -ne "${RED}Enter RAM (e.g. 2G): ${NC}"; read -r RAM
    echo -ne "${RED}Enter Port (e.g. 2022): ${NC}"; read -r PORT
    
    echo -e "${RED}👿 Spinning up Devil-Environment...${NC}"
    
    # تشغيل الحاوية بنظام أوبنتو مع SSH جاهز
    docker run -d \
        --name "$NAME" \
        --memory "$RAM" \
        -p "$PORT:22" \
        -it ubuntu:latest /bin/bash -c "apt update && apt install -y openssh-server sudo && service ssh start && sleep infinity"
        
    if [ $? -eq 0 ]; then
        echo -e "${B_RED}✅ SUCCESS: VPS '$NAME' is active on port $PORT!${NC}"
    else
        echo -e "${RED}❌ FAILED to create VPS.${NC}"
    fi
    read -p "Press Enter..."
}

# بدء التشغيل
check_deps
create_vps
