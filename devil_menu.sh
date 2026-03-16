#!/bin/bash
# --- DEVIL'S ULTIMATE RED THEME ---
RED='\033[0;31m'
B_RED='\033[1;31m'
B_WHITE='\033[1;37m'
B_YELLOW='\033[1;33m'
BG_RED='\033[41m'
NC='\033[0m'

print_line() { echo -e "${B_RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; }
print_header() { echo -e "${BG_RED}${B_WHITE} ${1^^} ${NC}"; }

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

run_task() {
    local url=$1
    local name=$2
    clear
    print_line
    print_header "Executing: $name"
    print_line
    local tmp=$(mktemp)
    if curl -fsSL "$url" -o "$tmp"; then
        chmod +x "$tmp"
        bash "$tmp"
        rm -f "$tmp"
        echo -e "\n${B_GREEN}✅ Task Finished Successfully!${NC}"
    else
        echo -e "\n${RED}❌ Connection Failed!${NC}"
    fi
    read -p "Press Enter to return..."
}

while true; do
    clear
    print_line
    echo -e "${B_RED}           👿 DEVIL HOSTING MANAGER            ${NC}"
    echo -e "${B_RED}             coded by itzRealDevil             ${NC}"
    print_line
    devil_logo
    print_line
    echo -e "${B_WHITE}  [1] 📦 Panel Install      ${B_WHITE}[5] ☁️  Cloudflare${NC}"
    echo -e "${B_WHITE}  [2] 💸 Wings Install     ${B_WHITE}[6] 📊 System Info${NC}"
    echo -e "${B_WHITE}  [3] 🗑️  Uninstall Tools    ${B_WHITE}[7] 🛡️  Tailscale VPN${NC}"
    echo -e "${B_WHITE}  [4] 🎨 Themes & Blueprint ${B_WHITE}[8] 🗄️  Database Setup${NC}"
    echo -e "${B_RED}  [0] ❌ Exit Devil Manager${NC}"
    print_line
    echo -ne "${B_YELLOW}😈 Enter Your Choice: ${NC}"
    read -r choice
    case $choice in
        1) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/panel2.sh" "Panel Install" ;;
        2) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/wing2.sh" "Wings Install" ;;
        3) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/uninstall2.sh" "Uninstall" ;;
        4) # Submenu can be added here
           run_task "https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/thame/chang.sh" "Themes" ;;
        5) run_task "https://raw.githubusercontent.com/JishnuTheGamer/Vps/refs/heads/main/cd/cloudflare.sh" "Cloudflare" ;;
        6) clear; print_header "SysInfo"; uptime; free -h; read -p "Enter..." ;;
        0) exit 0 ;;
        *) echo "Invalid!"; sleep 1 ;;
    esac
done
