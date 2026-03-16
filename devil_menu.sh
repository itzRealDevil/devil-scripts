#!/bin/bash
# [ DEVIL HOSTING MANAGER ]
# Made by: itzRealDevil

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

# دالة لجلب وتشغيل السكريبتات من مستودعك
run_remote() {
    local script=$1
    echo -e "${YELLOW}⏳ Loading $script...${NC}"
    bash <(curl -fsSL "https://raw.githubusercontent.com/itzRealDevil/devil-scripts/main/$script")
    echo -e "${GREEN}✅ Done.${NC}"
    read -p "Press Enter to return..."
}

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
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

while true; do
    big_header
    echo -e "${WHITE}  1)${NC} ${RED}Install Pterodactyl Panel${NC}"
    echo -e "${WHITE}  2)${NC} ${RED}Install Wings (Nodes)${NC}"
    echo -e "${WHITE}  3)${NC} ${RED}Create Virtual VPS (B)${NC}"
    echo -e "${WHITE}  4)${NC} ${RED}System Stats${NC}"
    echo -e "${WHITE}  0)${NC} ${RED}Exit${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -ne "${YELLOW}😈 Select Option: ${NC}"
    read -r choice
    case $choice in
        1) echo "Feature in development..." ; sleep 2 ;;
        2) echo "Feature in development..." ; sleep 2 ;;
        3) run_remote "my_vps_script.sh" ;;
        4) uptime -p ; read -p "Press Enter..." ;;
        0) exit 0 ;;
        *) echo -e "${RED}Invalid!${NC}" ; sleep 1 ;;
    esac
done
