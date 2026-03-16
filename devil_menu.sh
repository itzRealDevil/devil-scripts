#!/bin/bash

# Colors for output - DEVIL RED THEME
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to print section headers
print_header_rule() {
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Big ASCII header using heredoc (DEVIL RED theme)
big_header() {
    local title="$1"
    echo -e "${RED}"
    case "$title" in
        "MAIN MENU")
cat <<'EOF'
  _____  ________      _______ _      
 |  __ \|  ____\ \    / /_   _| |     
 | |  | | |__   \ \  / /  | | | |     
 | |  | |  __|   \ \/ /   | | | |     
 | |__| | |____   \  /   _| |_| |____ 
 |_____/|______|   \/   |_____|______|
                                      
EOF
            ;;
        "SYSTEM INFORMATION")
cat <<'EOF'
   _____ _     _   _ 
  / ____| |   | | | |
 | (___ | |__ | | | |
  \___ \| '_ \| | | |
  ____) | | | | | | |
 |_____/|_| |_|_| |_|
EOF
            ;;
        "DATABASE SETUP")
cat <<'EOF'
  _____  ____  
 |  __ \|  _ \ 
 | |  | | |_) |
 | |  | |  _ < 
 | |__| | |_) |
 |_____/|____/ 
EOF
            ;;
        *)
            echo -e "${BOLD}${title}${NC}"
            ;;
    esac
    echo -e "${NC}"
}

# Function to print status messages
print_status() { echo -e "${YELLOW}⏳ $1...${NC}"; }
print_success() { echo -e "${GREEN}✅ $1${NC}"; }
print_error() { echo -e "${RED}❌ $1${NC}"; }

# Check if curl is installed
check_curl() {
    if ! command -v curl &>/dev/null; then
        print_error "curl is not installed"
        sudo apt-get update && sudo apt-get install -y curl
    fi
}

# Function to run remote scripts
run_remote_script() {
    local url=$1
    local script_name="Devil Task"

    print_header_rule
    echo -e "${RED}Running: ${BOLD}${script_name}${NC}"
    print_header_rule

    check_curl
    local temp_script
    temp_script=$(mktemp)
    
    if curl -fsSL "$url" -o "$temp_script"; then
        chmod +x "$temp_script"
        bash "$temp_script"
        rm -f "$temp_script"
    else
        print_error "Failed to download script from source"
    fi
    echo -e ""
    read -p "$(echo -e "${YELLOW}Press Enter to return to Devil Menu...${NC}")" -n 1
}

# Sub-menu for Themes
blueprint_theme_menu() {
    while true; do
        clear
        print_header_rule
        echo -e "${RED}        🔧 DEVIL THEMES & EXTENSIONS           ${NC}"
        print_header_rule
        big_header "MAIN MENU"
        echo -e "${WHITE}${BOLD}  1)${NC} ${RED}Blueprint Setup${NC}"
        echo -e "${WHITE}${BOLD}  2)${NC} ${RED}Themes + Extensions${NC}"
        echo -e "${WHITE}${BOLD}  0)${NC} ${RED}Back${NC}"
        print_header_rule
        read -r subchoice
        case $subchoice in
            1) run_remote_script "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/Blueprint2.sh" ;;
            2) bash <(curl -s https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/thame/chang.sh) ;;
            0) return 0 ;;
        esac
    done
}

# System info
system_info() {
    clear
    print_header_rule
    big_header "SYSTEM INFORMATION"
    echo -e "${WHITE} Hostname:  ${GREEN}$(hostname)${NC}"
    echo -e "${WHITE} OS:        ${GREEN}$(uname -srm)${NC}"
    echo -e "${WHITE} RAM:       ${GREEN}$(free -h | awk '/Mem:/ {print $3"/"$2}')${NC}"
    echo -e "${WHITE} Uptime:    ${GREEN}$(uptime -p)${NC}"
    print_header_rule
    read -p "Press Enter to continue..."
}

# Main menu
show_menu() {
    clear
    print_header_rule
    echo -e "${RED}           🚀 DEVIL HOSTING MANAGER            ${NC}"
    echo -e "${RED}             made by itzRealDevil              ${NC}"
    print_header_rule
    big_header "MAIN MENU"
    print_header_rule
    echo -e "${WHITE}  1)${NC} ${RED}Panel Installation${NC}"
    echo -e "${WHITE}  2)${NC} ${RED}Wings Installation${NC}"
    echo -e "${WHITE}  3)${NC} ${RED}Uninstall Tools${NC}"
    echo -e "${WHITE}  4)${NC} ${RED}Themes & Blueprint${NC}"
    echo -e "${WHITE}  5)${NC} ${RED}Cloudflare Setup${NC}"
    echo -e "${WHITE}  6)${NC} ${RED}System Information${NC}"
    echo -e "${WHITE}  7)${NC} ${RED}Tailscale VPN${NC}"
    echo -e "${WHITE}  8)${NC} ${RED}Database Setup${NC}"
    echo -e "${WHITE}  0)${NC} ${RED}Exit${NC}"
    print_header_rule
    echo -ne "${YELLOW}📝 Select an option [0-8]: ${NC}"
}

# Main loop
while true; do
    show_menu
    read -r choice
    case $choice in
        1) run_remote_script "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/panel2.sh" ;;
        2) run_remote_script "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/wing2.sh" ;;
        3) run_remote_script "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/uninstall2.sh" ;;
        4) blueprint_theme_menu ;;
        5) run_remote_script "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/cloudflare.sh" ;;
        6) system_info ;;
        7) run_remote_script "https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/tools/Tailscale.sh" ;;
        8) # Simple DB Setup
           read -p "DB Username: " DB_USER
           read -sp "DB Password: " DB_PASS
           mysql -u root -p -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}'; GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
           print_success "Database User $DB_USER Created!"
           sleep 2 ;;
        0) exit 0 ;;
        *) print_error "Invalid Option!" ; sleep 1 ;;
    esac
done