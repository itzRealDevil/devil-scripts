#!/bin/bash
# --- DEVIL'S ULTIMATE RED THEME (PRO VERSION) ---

# Colors
RED='\033[0;31m'
B_RED='\033[1;31m'
B_WHITE='\033[1;37m'
B_YELLOW='\033[1;33m'
B_CYAN='\033[1;36m'
BG_RED='\033[41m'
NC='\033[0m' # No Color

# Layout Helpers
print_line() { echo -e "${B_RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; }
print_header() { echo -e "${BG_RED}${B_WHITE} ${1^^} ${NC}"; }

# Fixed ASCII Logo (DEVIL)
devil_logo() {
echo -e "${B_RED}"
cat <<'EOF'
  _____  ________      _______ _      
 |  __ \|  ____\ \    / /_   _| |     
 | |  | | |__   \ \  / /  | | | |     
 | |  | |  __|   \ \/ /   | | | |     
 | |__| | |____   \  /   _| |_| |____ 
 |_____/|______|   \/   |_____|______|
EOF
echo -e "                Hosting Manager"
echo -e "${NC}"
}

# Task Runner
run_task() {
    local url=$1
    local name=$2
    clear
    print_line
    print_header "Executing: $name"
    print_line
    echo -e "${B_YELLOW}⏳ Downloading and running...${NC}"
    local tmp=$(mktemp)
    if curl -fsSL "$url" -o "$tmp"; then
        chmod +x "$tmp"
        bash "$tmp"
        rm -f "$tmp"
        echo -e "\n${B_GREEN}✅ Task '$name' Finished!${NC}"
    else
        echo -e "\n${RED}❌ Connection Failed!${NC}"
    fi
    echo ""
    read -p "Press Enter to return to Devil Menu..."
}

# Main Interface
while true; do
    clear
    print_line
    echo -e "${B_RED}           👿 DEVIL HOSTING MANAGER            ${NC}"
    echo -e "${B_RED}             coded by itzRealDevil             ${NC}"
    print_line
    devil_logo
    print_line
    
    # Grid Layout
    echo -e "${B_WHITE}  [1] 📦 Panel Install      ${B_WHITE}[5] ☁️  Cloudflare${NC}"
    echo -e "${B_WHITE}  [2] 💸 Wings Install     ${B_WHITE}[6] 📊 System Info${NC}"
    echo -e "${B_WHITE}  [3] 🗑️  Uninstall Tools    ${B_WHITE}[7] 🛡️  Tailscale VPN${NC}"
    echo -e "${B_WHITE}  [4] 🎨 Themes & Blueprint ${B_WHITE}[8] 🗄️  Database Setup${NC}"
    echo -e ""
    echo -e "${B_RED}  [0] ❌ Exit Devil Manager${NC}"
    print_line
    echo -ne "${B_YELLOW}😈 Enter Your Choice: ${NC}"
    read -r choice

    case $choice in
        1) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/panel2.sh" "Panel Install" ;;
        2) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/wing2.sh" "Wings Install" ;;
        3) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/uninstall2.sh" "Uninstall Tools" ;;
        4) run_task "https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/thame/chang.sh" "Themes & Extensions" ;;
        5) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/cloudflare.sh" "Cloudflare Setup" ;;
        6) 
            clear
            print_line
            print_header "System Information"
            echo -e "${B_WHITE} 🖥️  Hostname: ${B_CYAN}$(hostname)${NC}"
            echo -e "${B_WHITE} 💾 RAM:      ${B_CYAN}$(free -h | awk '/Mem:/ {print $3"/"$2}')${NC}"
            echo -e "${B_WHITE} ⏱️  Uptime:   ${B_CYAN}$(uptime -p)${NC}"
            print_line
            read -p "Press Enter to return..." ;;
        8)
           clear
           print_header "Database Setup"
           read -p "Enter DB User: " db_user
           read -sp "Enter DB Pass: " db_pass
           echo -e "\n${B_YELLOW}Creating user...${NC}"
           mysql -u root -p -e "CREATE USER '${db_user}'@'%' IDENTIFIED BY '${db_pass}'; GRANT ALL PRIVILEGES ON *.* TO '${db_user}'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" && echo -e "${B_GREEN}Done!${NC}" || echo -e "${RED}Failed!${NC}"
           sleep 2 ;;
        0) clear; echo -e "${B_RED}Devil is leaving... Bye!${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid Option!${NC}"; sleep 1 ;;
    esac
done
