#!/bin/bash
# [ DEVIL HOSTING MANAGER ]
# Made by: itzRealDevil

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

big_header() {
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

run_task() {
    local url=$1
    local name=$2
    echo -e "${YELLOW}⏳ Starting $name...${NC}"
    # يتم السحب من مستودعك الخاص مستقبلاً
    bash <(curl -fsSL "$url")
    read -p "Press Enter to return..."
}

while true; do
    clear
    big_header
    echo -e "${WHITE}  1)${NC} ${RED}Install Pterodactyl Panel${NC}"
    echo -e "${WHITE}  2)${NC} ${RED}Install Wings${NC}"
    echo -e "${WHITE}  3)${NC} ${RED}Create Virtual VPS (B)${NC}"
    echo -e "${WHITE}  4)${NC} ${RED}System Information${NC}"
    echo -e "${WHITE}  0)${NC} ${RED}Exit${NC}"
    echo -ne "\n${YELLOW}😈 Select Option: ${NC}"
    read -r choice
    case $choice in
        1) run_task "https://raw.githubusercontent.com/itzRealDevil/devil-scripts/main/devil_panel.sh" "Panel" ;;
        2) run_task "https://raw.githubusercontent.com/itzRealDevil/devil-scripts/main/devil_wings.sh" "Wings" ;;
        3) bash "$HOME/my_vps_script.sh" ;; # تشغيل سكريبت الوهمي المحلي
        4) uptime -p ; read ;;
        0) exit 0 ;;
    esac
done