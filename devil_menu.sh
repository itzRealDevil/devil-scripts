#!/bin/bash

# --- Devil's Professional Red Theme ---
# Regular Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'

# Bold & Bright Colors
BOLD='\033[1m'
B_RED='\033[1;31m'
B_GREEN='\033[1;32m'
B_YELLOW='\033[1;33m'
B_CYAN='\033[1;36m'
B_WHITE='\033[1;37m'

# Backgrounds
BG_RED='\033[41m'
NC='\033[0m' # No Color

# --- UI Helper Functions ---

# Print a sleek separator line
print_line() {
    echo -e "${B_RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Print a colored header
print_header() {
    echo -e "${BG_RED}${B_WHITE} ${1^^} ${NC}"
}

# Devil's ASCII Art Header (Main Menu)
devil_logo() {
echo -e "${B_RED}"
cat <<'EOF'
  ::::::::  :::::::::: :::     ::::::: :::        :::::::::::
 :+:    :+: :+:        :+:       :+:   :+:            :+:     
 +:+    +:+ +:+        +:+       +:+   +:+            +:+     
 +#+    +:+ +#++:++#   +#+       +#+   +#+            +#+     
 +#+    +:+ +#+        +#+       +#+   +#+            +#+     
 #+#    #+# #+#        #+#       #+#   #+#            #+#     
  ########  ########## ################# ##################### 
                        Hosting Manager
EOF
echo -e "${NC}"
}

# Function to print status messages
status_pending() { echo -e "${B_YELLOW}⏳ $1...${NC}"; }
status_ok() { echo -e "${B_GREEN}✅ $1${NC}"; }
status_fail() { echo -e "${B_RED}❌ $1${NC}"; }

# --- System Checks ---
check_curl() {
    if ! command -v curl &>/dev/null; then
        status_pending "Curl not found. Installing"
        sudo apt-get update && sudo apt-get install -y curl &>/dev/null
        status_ok "Curl installed"
    fi
}

# --- Core Functions ---

# Run a remote script with style
run_task() {
    local url=$1
    local task_name=$2
    
    clear
    print_line
    print_header "Running Task: $task_name"
    print_line
    echo ""
    
    check_curl
    local temp_script
    temp_script=$(mktemp)
    
    status_pending "Downloading script from Devil Servers"
    if curl -fsSL "$url" -o "$temp_script"; then
        status_ok "Download complete"
        echo ""
        print_line
        echo -e "${B_WHITE}Starting Execution...${NC}"
        print_line
        echo ""
        chmod +x "$temp_script"
        bash "$temp_script"
        rm -f "$temp_script"
        echo ""
        print_line
        status_ok "Task '$task_name' finished"
    else
        status_fail "Failed to download task script"
    fi
    echo ""
    read -p "$(echo -e "${B_YELLOW}Press Enter to return to Devil Menu...${NC}")"
}

# Themes & Blueprint Sub-menu
themes_menu() {
    while true; do
        clear
        print_line
        echo -e "${B_RED}        🎨 DEVIL THEMES & EXTENSIONS           ${NC}"
        print_line
        echo -e "${B_WHITE}  [1] 🛠️  Blueprint Setup${NC}"
        echo -e "${B_WHITE}  [2] 🎭 Themes + Extensions${NC}"
        echo -e "${B_RED}  [0] 🔙 Back to Main Menu${NC}"
        print_line
        echo -ne "${B_YELLOW}😈 Select Option: ${NC}"
        read -r subchoice
        case $subchoice in
            1) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/Blueprint2.sh" "Blueprint Setup" ;;
            2) run_task "https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/thame/chang.sh" "Themes & Extensions" ;;
            0) return 0 ;;
            *) status_fail "Invalid Option" ; sleep 1 ;;
        esac
    done
}

# Display system information in a neat box
show_sysinfo() {
    clear
    print_line
    print_header "System Information"
    print_line
    echo -e "${B_WHITE} 🖥️  Hostname:  ${B_CYAN}$(hostname)${NC}"
    echo -e "${B_WHITE} 🐧 OS:        ${B_CYAN}$(uname -srm)${NC}"
    echo -e "${B_WHITE} 💾 RAM Usage: ${B_CYAN}$(free -h | awk '/Mem:/ {print $3"/"$2}')${NC}"
    echo -e "${B_WHITE} ⏱️  Uptime:    ${B_CYAN}$(uptime -p)${NC}"
    echo -e "${B_WHITE} 👤 User:      ${B_CYAN}$(whoami)${NC}"
    print_line
    echo ""
    read -p "$(echo -e "${B_YELLOW}Press Enter to continue...${NC}")"
}

# Setup database user
setup_db() {
    clear
    print_line
    print_header "Database User Setup"
    print_line
    echo -ne "${B_WHITE}New DB Username: ${NC}"
    read DB_USER
    echo -ne "${B_WHITE}New DB Password: ${NC}"
    read -s DB_PASS
    echo ""
    status_pending "Creating user $DB_USER"
    mysql -u root -p -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}'; GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" &>/dev/null
    if [ $? -eq 0 ]; then
        status_ok "User $DB_USER created successfully"
    else
        status_fail "Failed to create user (check root password)"
    fi
    sleep 2
}

# --- Main Menu Interface ---
main_menu() {
    clear
    print_line
    echo -e "${B_RED}           👿 DEVIL HOSTING MANAGER            ${NC}"
    echo -e "${B_RED}             coded by itzRealDevil              ${NC}"
    print_line
    devil_logo
    print_line
    
    # Grid-like menu options for better look
    echo -e "${B_WHITE}  [1] 📦 Panel Install      ${B_WHITE}[5] ☁️  Cloudflare${NC}"
    echo -e "${B_WHITE}  [2] 💸 Wings Install     ${B_WHITE}[6] 📊 System Info${NC}"
    echo -e "${B_WHITE}  [3] 🗑️  Uninstall Tools    ${B_WHITE}[7] 🛡️  Tailscale VPN${NC}"
    echo -e "${B_WHITE}  [4] 🎨 Themes & Blueprint ${B_WHITE}[8] 🗄️  Database Setup${NC}"
    echo -e "${B_RED}  [0] ❌ Exit Devil Manager${NC}"
    print_line
    echo -ne "${B_YELLOW}😈 Enter Your Choice [0-8]: ${NC}"
}

# --- Main Loop ---
while true; do
    main_menu
    read -r choice
    case $choice in
        1) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/panel2.sh" "Panel Installation" ;;
        2) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/wing2.sh" "Wings Installation" ;;
        3) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/uninstall2.sh" "Uninstall Tools" ;;
        4) themes_menu ;;
        5) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/cloudflare.sh" "Cloudflare Setup" ;;
        6) show_sysinfo ;;
        7) run_task "https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/tools/Tailscale.sh" "Tailscale VPN" ;;
        8) setup_db ;;
        0) clear; echo -e "${B_RED}Devil is leaving... Bye!${NC}"; exit 0 ;;
        *) status_fail "Invalid Option!" ; sleep 1 ;;
    esac
done
