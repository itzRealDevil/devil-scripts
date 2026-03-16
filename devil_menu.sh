#!/bin/bash
# [ DEVIL HOSTING MANAGER ]
# Made by: itzRealDevil

RED='\033[0;31m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
NC='\033[0m'

# دالة تشغيل السكريبتات من مستودعك مباشرة
run_devil_script() {
    local script_name=$1
    local url="https://raw.githubusercontent.com/itzRealDevil/devil-scripts/main/$script_name"
    echo -e "${YELLOW}⏳ Fetching $script_name from Devil Infrastructure...${NC}"
    bash <(curl -fsSL "$url")
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
}

while true; do
    big_header
    echo -e "${WHITE}  1)${NC} ${RED}Install Pterodactyl Panel${NC}"
    echo -e "${WHITE}  2)${NC} ${RED}Create Virtual VPS (B)${NC}"
    echo -e "${WHITE}  0)${NC} ${RED}Exit${NC}"
    echo -ne "\n${YELLOW}😈 Select Option: ${NC}"
    read -r choice
    case $choice in
        1) echo "Feature coming soon..." ; sleep 2 ;;
        2) run_devil_script "my_vps_script.sh" ;;
        0) exit 0 ;;
        *) echo "Invalid option" ; sleep 1 ;;
    esac
done
