#!/bin/bash
set -euo pipefail

# ========================================================================
# [ DEVIL VIRTUALIZATION ENGINE - PRO ]
# Modified & Enhanced by: itzRealDevil
# ========================================================================

# --- Colors & Theme ---
RED='\033[0;31m'
B_RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# --- Function to display DEVIL header ---
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
========================================================================
EOF
    echo -e "${NC}"
}

# --- Function to display colored status ---
print_status() {
    local type=$1
    local message=$2
    case $type in
        "INFO")    echo -e "${WHITE}[${RED}DEVIL-INFO${WHITE}]${NC} $message" ;;
        "WARN")    echo -e "${WHITE}[${YELLOW}DEVIL-WARN${WHITE}]${NC} $message" ;;
        "ERROR")   echo -e "${WHITE}[${RED}DEVIL-ERROR${WHITE}]${NC} $message" ;;
        "SUCCESS") echo -e "${WHITE}[${GREEN}DEVIL-OK${WHITE}]${NC} $message" ;;
        "INPUT")   echo -e "${CYAN}👿 $message${NC}" ;;
    esac
}

# --- Validation Logic ---
validate_input() {
    local type=$1
    local value=$2
    case $type in
        "number") [[ "$value" =~ ^[0-9]+$ ]] || { print_status "ERROR" "Must be a number"; return 1; } ;;
        "size")   [[ "$value" =~ ^[0-9]+[GgMm]$ ]] || { print_status "ERROR" "Use format like 20G or 512M"; return 1; } ;;
        "port")   ([[ "$value" =~ ^[0-9]+$ ]] && [ "$value" -ge 22 ] && [ "$value" -le 65535 ]) || { print_status "ERROR" "Invalid port (22-65535)"; return 1; } ;;
        "name")   [[ "$value" =~ ^[a-zA-Z0-9_-]+$ ]] || { print_status "ERROR" "Invalid characters in name"; return 1; } ;;
    esac
    return 0
}

# --- Dependency Check ---
check_dependencies() {
    local deps=("qemu-system-x86_64" "wget" "cloud-localds" "qemu-img")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            print_status "INFO" "Installing missing core: $dep..."
            sudo apt update && sudo apt install -y qemu-system cloud-image-utils wget qemu-utils
            break
        fi
    done
}

# --- VM Configuration Management ---
load_vm_config() {
    local vm_name=$1
    local config_file="$VM_DIR/$vm_name.conf"
    if [[ -f "$config_file" ]]; then
        source "$config_file"
        return 0
    fi
    print_status "ERROR" "VM config not found"
    return 1
}

save_vm_config() {
    cat > "$VM_DIR/$VM_NAME.conf" <<EOF
VM_NAME="$VM_NAME"
OS_TYPE="$OS_TYPE"
HOSTNAME="$HOSTNAME"
USERNAME="$USERNAME"
PASSWORD="$PASSWORD"
DISK_SIZE="$DISK_SIZE"
MEMORY="$MEMORY"
CPUS="$CPUS"
SSH_PORT="$SSH_PORT"
GUI_MODE="$GUI_MODE"
IMG_FILE="$IMG_FILE"
SEED_FILE="$SEED_FILE"
CREATED="$(date)"
EOF
}

# --- Core Action: Setup VM ---
setup_vm_image() {
    print_status "INFO" "Preparing Devil's Soul (Image Setup)..."
    mkdir -p "$VM_DIR"
    
    if [[ ! -f "$IMG_FILE" ]]; then
        print_status "INFO" "Fetching OS Image..."
        wget "$IMG_URL" -O "$IMG_FILE"
    fi

    qemu-img resize "$IMG_FILE" "$DISK_SIZE" &>/dev/null || true

    # Cloud-init (Auto Login Setup)
    cat > user-data <<EOF
#cloud-config
hostname: $HOSTNAME
ssh_pwauth: true
users:
  - name: $USERNAME
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    password: $(openssl passwd -6 "$PASSWORD")
EOF
    echo "instance-id: iid-$VM_NAME" > meta-data
    cloud-localds "$SEED_FILE" user-data meta-data
    rm user-data meta-data
}

# --- Main Logic: Start VM ---
start_vm() {
    if load_vm_config "$1"; then
        print_status "SUCCESS" "Ignition: Starting $1..."
        echo -e "${YELLOW}Access via: ssh -p $SSH_PORT $USERNAME@localhost${NC}"
        
        local qemu_cmd=(
            qemu-system-x86_64 -m "$MEMORY" -smp "$CPUS" -cpu qemu64
            -drive "file=$IMG_FILE,format=qcow2,if=virtio"
            -drive "file=$SEED_FILE,format=raw,if=virtio"
            -netdev "user,id=n0,hostfwd=tcp::$SSH_PORT-:22"
            -device virtio-net-pci,netdev=n0
        )

        [[ "$GUI_MODE" == "true" ]] && qemu_cmd+=(-vga virtio -display gtk) || qemu_cmd+=(-nographic -serial mon:stdio)
        
        "${qemu_cmd[@]}"
    fi
}

# --- Menu System ---
main_menu() {
    while true; do
        display_header
        local vms=($(find "$VM_DIR" -name "*.conf" -exec basename {} .conf \; 2>/dev/null))
        
        if [ ${#vms[@]} -gt 0 ]; then
            echo -e "${RED}Your Active Legions (VMs):${NC}"
            for i in "${!vms[@]}"; do
                echo -e "  $((i+1))) ${vms[$i]}"
            done
            echo ""
        fi

        echo -e "${WHITE}1) Create New Devil VM${NC}"
        echo -e "${WHITE}2) Start Existing VM${NC}"
        echo -e "${WHITE}3) Delete a VM${NC}"
        echo -e "${WHITE}0) Exit${NC}"
        
        read -p "$(print_status "INPUT" "Select Command: ")" choice
        case $choice in
            1)
                print_status "INPUT" "Choose OS (1: Ubuntu 22, 2: Debian 12): "; read os_c
                if [ "$os_c" == "1" ]; then
                    OS_TYPE="Ubuntu"; IMG_URL="https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
                else
                    OS_TYPE="Debian"; IMG_URL="https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
                fi
                
                read -p "👿 VM Name: " VM_NAME
                read -p "👿 RAM (MB): " MEMORY
                read -p "👿 Disk (e.g. 20G): " DISK_SIZE
                read -p "👿 SSH Port: " SSH_PORT
                
                USERNAME="devil"; PASSWORD="123"; HOSTNAME="$VM_NAME"
                IMG_FILE="$VM_DIR/$VM_NAME.img"; SEED_FILE="$VM_DIR/$VM_NAME-seed.iso"; GUI_MODE="false"
                
                setup_vm_image && save_vm_config
                print_status "SUCCESS" "VM $VM_NAME is ready!"
                ;;
            2)
                read -p "👿 Enter VM Number: " vm_idx
                start_vm "${vms[$((vm_idx-1))]}"
                ;;
            3)
                read -p "👿 VM Number to DELETE: " vm_idx
                rm -f "$VM_DIR/${vms[$((vm_idx-1))]}.conf" "$VM_DIR/${vms[$((vm_idx-1))]}.img"
                print_status "SUCCESS" "Purged!"
                ;;
            0) exit 0 ;;
        esac
        read -p "Press Enter..."
    done
}

# --- Entry Point ---
VM_DIR="$HOME/devil_vms"
check_dependencies
main_menu
