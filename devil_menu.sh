#!/bin/bash
# [ DEVIL HOSTING MANAGER ]
# Made by: itzRealDevil

RED='\033[0;31m'
NC='\033[0m'

big_header() {
    clear
    echo -e "${RED}"
cat <<'EOF'
  _____  ________      _______ _      
 |  __ \|  ____\ \    / /_   _| |     
 | |  | | |__   \ \  / /  | | | |     
 | |  | |  __|   \ \/ /   | | | |     
 | |__| | |____   \  /   _| |_| |____ 
 |_____/|______|   \/   |_____|______|
EOF
    echo -e "       👿 DEVIL HOSTING MANAGER PRO\n${NC}"
}

# دالة تشغيل السكريبتات من مستودعك
run_devil_script() {
    local script_name=$1
    # استبدل YOUR_USERNAME باسم حسابك الحقيقي في جيت هاب
    local url="https://raw.githubusercontent.com/YOUR_USERNAME/devil-scripts/main/$script_name"
    bash <(curl -fsSL "$url")
}

while true; do
    big_header
    echo -e "  1) Install Pterodactyl Panel"
    echo -e "  2) Create Virtual VPS (B)"
    echo -e "  0) Exit"
    echo -ne "\n😈 Select Option: "
    read -r choice
    case $choice in
        1) echo "Installing Panel..." ;; # ضيف رابط سكريبت البانل هنا
        2) run_devil_script "my_vps_script.sh" ;;
        0) exit 0 ;;
    esac
done
