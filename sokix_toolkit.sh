#!/usr/bin/env bash

# SOKIX Toolkit - Professional Ethical Hacking Environment
# Version: 10.0.0
# License: MIT
# Author: SOKIX Security Team

# Enhanced strict mode with advanced error handling
set -euo pipefail
IFS=$'\n\t'

# Advanced Global Configuration
readonly VERSION="10.0.0"
readonly TOOLKIT_NAME="SOKIX Professional Hacking Toolkit"
readonly CONFIG_FILE="${SOKIX_HOME:-${HOME:-/tmp}/.local/share/sokix}/config/config.yaml"
readonly CONFIG_DIR="$(dirname "$CONFIG_FILE")"
readonly LOG_FILE="${SOKIX_HOME:-${HOME:-/tmp}/.local/share/sokix}/logs/sokix.log"
readonly TOOLS_DIR="${SOKIX_HOME:-${HOME:-/tmp}/.local/share/sokix}/tools"
readonly MODULES_DIR="${SOKIX_HOME:-${HOME:-/tmp}/.local/share/sokix}/modules"
readonly SCRIPTS_DIR="${SOKIX_HOME:-${HOME:-/tmp}/.local/share/sokix}/scripts"
readonly CACHE_DIR="${SOKIX_HOME:-${HOME:-/tmp}/.local/share/sokix}/cache"
readonly TEMP_DIR="${TMPDIR:-/tmp}/sokix-${UID}"
readonly BACKUP_DIR="${SOKIX_HOME:-${HOME:-/tmp}/.local/share/sokix}/backups"
readonly REPORTS_DIR="${SOKIX_HOME:-${HOME:-/tmp}/.local/share/sokix}/reports"
readonly EXPLOITS_DIR="/usr/share/sokix/exploits"
readonly PAYLOADS_DIR="/usr/share/sokix/payloads"
readonly WORDLISTS_DIR="/usr/share/sokix/wordlists"
readonly DATABASES_DIR="/usr/share/sokix/databases"
readonly PROXIES_DIR="/usr/share/sokix/proxies"
readonly TOR_DIR="/usr/share/sokix/tor"
readonly VPN_DIR="/usr/share/sokix/vpn"
readonly SHELLS_DIR="/usr/share/sokix/shells"
readonly BACKDOORS_DIR="/usr/share/sokix/backdoors"
readonly MALWARE_DIR="/usr/share/sokix/malware"
readonly REVERSE_DIR="/usr/share/sokix/reverse"
readonly BRUTE_DIR="/usr/share/sokix/brute"
readonly FUZZING_DIR="/usr/share/sokix/fuzzing"
readonly SCANNING_DIR="/usr/share/sokix/scanning"
readonly ENUMERATION_DIR="/usr/share/sokix/enumeration"
readonly PRIVILEGE_DIR="/usr/share/sokix/privilege"
readonly PERSISTENCE_DIR="/usr/share/sokix/persistence"
readonly LATERAL_DIR="/usr/share/sokix/lateral"
readonly EXFILTRATION_DIR="/usr/share/sokix/exfiltration"
readonly COVERING_DIR="/usr/share/sokix/covering"

# Advanced Color System with RGB support
declare -A COLORS
COLORS=(
    ["RED"]="\033[1;31m"
    ["GREEN"]="\033[1;32m"
    ["YELLOW"]="\033[1;33m"
    ["BLUE"]="\033[1;34m"
    ["PURPLE"]="\033[1;35m"
    ["CYAN"]="\033[1;36m"
    ["WHITE"]="\033[1;37m"
    ["ORANGE"]="\033[1;38;5;208m"
    ["PINK"]="\033[1;38;5;206m"
    ["LIME"]="\033[1;38;5;118m"
    ["MATRIX"]="\033[1;38;5;40m"
    ["HACKER"]="\033[1;38;5;196m"
    ["CYBERPUNK"]="\033[1;38;5;99m"
    ["STEALTH"]="\033[1;38;5;240m"
    ["NEON"]="\033[1;38;5;45m"
    ["NC"]="\033[0m"
)

# Advanced Unicode Characters with more options
declare -A UNICODE
UNICODE=(
    ["BORDER_TOP"]="+-----------------------------------------+"
    ["BORDER_BOTTOM"]="+-----------------------------------------+"
    ["BORDER_SIDE"]="|"
    ["BORDER_MIDDLE"]="|------------------------------------------|"
    ["SPARKLE"]="*"
    ["CHECK"]="✓"
    ["WARNING"]="!"
    ["ERROR"]="x"
    ["INFO"]="i"
    ["STAR"]="*"
    ["DIAMOND"]="<>"
    ["HEART"]="<3"
    ["ARROW"]=">"
    ["LOADING"]="/-\|"
    ["PROGRESS_BAR_FILL"]="#"
    ["PROGRESS_BAR_EMPTY"]="."
    ["BULLET"]="*"
    ["CROSS"]="X"
    ["LOCK"]="[X]"
    ["UNLOCK"]="[ ]"
    ["KEY"]="key"
    ["SHIELD"]="[S]"
    ["SWORD"]="[W]"
    ["WRENCH"]="[T]"
    ["GEAR"]="[G]"
    ["LIGHTNING"]="[L]"
    ["FIRE"]="[F]"
    ["TARGET"]="[O]"
    ["SKULL"]="[D]"
    ["GHOST"]="[H]"
    ["ROBOT"]="[R]"
    ["TERMINAL"]="[>]"
    ["SATELLITE"]="[^]"
    ["MAGNIFIER"]="[M]"
    ["TOOLS"]="[T]"
    ["DOWNLOAD"]="[D]"
    ["SUCCESS"]="[OK]"
    ["FAILED"]="[!!]"
    ["LOADING_WHEEL"]="[*]"
    ["PACKAGE"]="[P]"
    ["CLOCK"]="[C]"
    ["CHART"]="[#]"
    ["FOLDER"]="[/]"
    ["GAME"]="[G]"
    ["MOBILE"]="[M]"
    ["NETWORK"]="[N]"
    ["SECURITY"]="[S]"
    ["HACKING"]="[H]"
    ["SCANNING"]="[S]"
    ["EXPLOITING"]="[E]"
    ["CRACKING"]="[C]"
    ["SOCIAL"]="[S]"
    ["FORENSICS"]="[F]"
    ["REPORT"]="[R]"
    ["SETTINGS"]="[S]"
    ["UPDATE"]="[U]"
    ["EXIT"]="[X]"
)

# Funciones reutilizables de logging (evitan repetir patrones echo -e con colores)
log_error() {
    echo -e "${COLORS['RED']}${UNICODE['ERROR']} $1${COLORS['NC']}"
}

log_warning() {
    echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} $1${COLORS['NC']}"
}

log_success() {
    echo -e "${COLORS['GREEN']}${UNICODE['SUCCESS']} $1${COLORS['NC']}"
}

log_info() {
    echo -e "${COLORS['CYAN']}$1${COLORS['NC']}"
}

# Ejecuta un comando y registra un error uniforme si falla
run_or_fail() {
    local error_message=$1
    shift
    if ! "$@"; then
        log_error "$error_message"
        return 1
    fi
    return 0
}

# Sistema de diagnóstico mejorado
declare -A DIAGNOSTIC_CHECKS=(
    [system]="Verificando sistema operativo y recursos"
    [network]="Comprobando conectividad y servicios de red"
    [security]="Analizando configuraciones de seguridad"
    [performance]="Evaluando rendimiento del sistema"
    [dependencies]="Revisando dependencias y paquetes"
    [tools]="Verificando estado de las herramientas"
    [permissions]="Comprobando permisos y accesos"
    [storage]="Analizando espacio en disco"
    [memory]="Verificando uso de memoria"
    [cpu]="Comprobando carga del procesador"
)

# Animación breve de inicio (sin dependencias externas; respeta terminales no interactivos).
startup_animation() {
    [[ -t 1 ]] || return 0
    local i frame pct width=42
    local frames=("INICIALIZANDO INTERFAZ RGB" "VERIFICANDO DEPENDENCIAS" "PREPARANDO DIRECTORIOS" "CARGANDO MODULOS" "CONSOLA LISTA")
    printf '\033[2J\033[H\033[?25l'
    trap 'printf "\033[0m\033[?25h"' RETURN
    printf '\033[38;2;0;245;255m'
    cat <<'BANNER'
╔══════════════════════════════════════════════════════════════════════════════╗
║  ███████╗ ██████╗ ██╗  ██╗██╗██╗  ██╗                                      ║
║  ██╔════╝██╔═══██╗██║ ██╔╝██║╚██╗██╔╝                                      ║
║  ███████╗██║   ██║█████╔╝ ██║ ╚███╔╝                                       ║
║  ╚════██║██║   ██║██╔═██╗ ██║ ██╔██╗                                       ║
║  ███████║╚██████╔╝██║  ██╗██║██╔╝ ██╗                                      ║
║  ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝                                      ║
║             S E C U R I T Y   O P S   //   N E O N   E D I T I O N          ║
╚══════════════════════════════════════════════════════════════════════════════╝
BANNER
    printf '\033[0m\n'
    for frame in "${frames[@]}"; do
        printf '\033[38;2;255;70;220m  ◈ \033[38;2;0;245;255m%-31s\033[0m ' "$frame"
        for ((i=0; i<width; i++)); do
            case $((i % 3)) in
                0) printf '\033[38;2;0;245;255m▰\033[0m' ;;
                1) printf '\033[38;2;180;70;255m▰\033[0m' ;;
                2) printf '\033[38;2;255;70;220m▰\033[0m' ;;
            esac
            sleep 0.006
        done
        printf '\n'
    done
    printf '\033[?25h\033[0m'
}

# Comprueba e instala solo dependencias base del sistema. No instala en masa herramientas ofensivas.
bootstrap_dependencies() {
    [[ -t 0 && -t 1 ]] || return 0
    local missing=() pkg
    local packages=(git curl ca-certificates python3 python3-venv python3-pip pipx build-essential)
    for pkg in "${packages[@]}"; do
        dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q 'install ok installed' || missing+=("$pkg")
    done
    if ((${#missing[@]} == 0)); then
        log_success "Dependencias base verificadas."
        return 0
    fi
    printf '\n\033[38;2;0;245;255m╭─ PREPARACIÓN DEL ENTORNO ─────────────────────────────────────╮\033[0m\n'
    printf '  Faltan paquetes base: %s\n' "${missing[*]}"
    printf '  Se instalarán con APT; no se usará pip global ni --break-system-packages.\n'
    read -r -p "¿Instalar dependencias base ahora? [S/n]: " answer
    case "${answer,,}" in
        n|no) log_warning "Se omite la instalación. Algunas herramientas podrían requerir dependencias."; return 0 ;;
    esac
    if ! command -v apt-get >/dev/null 2>&1; then
        log_error "APT no está disponible; instala manualmente: ${missing[*]}"
        return 1
    fi
    local -a apt_cmd=(apt-get)
    if [[ ${EUID:-$(id -u)} -ne 0 ]]; then
        if command -v sudo >/dev/null 2>&1; then apt_cmd=(sudo apt-get)
        else log_error "Se necesitan permisos de administrador para APT."; return 1
        fi
    fi
    printf '\033[38;2;180;70;255m[01/02]\033[0m Actualizando índices de paquetes...\n'
    "${apt_cmd[@]}" update || { log_error "APT update falló; revisa conexión y repositorios."; return 1; }
    printf '\033[38;2;0;245;255m[02/02]\033[0m Instalando dependencias base...\n'
    DEBIAN_FRONTEND=noninteractive "${apt_cmd[@]}" install -y -- "${missing[@]}" || {
        log_error "No se pudieron instalar todos los paquetes base."
        return 1
    }
    log_success "Dependencias base listas. Las herramientas se instalan individualmente desde el menú."
}

# Advanced ASCII Art Banner
show_banner() {
    [[ -t 1 ]] && printf '\033[2J\033[H'
    local host os kernel now
    host=$(hostname 2>/dev/null || printf 'host-local')
    os=$(sed -n 's/^PRETTY_NAME="?\(.*\)"?$/\1/p' /etc/os-release 2>/dev/null | head -n 1)
    os=${os:-Linux}
    kernel=$(uname -r 2>/dev/null || printf 'desconocido')
    now=$(date '+%d/%m/%Y  %H:%M:%S')
    printf '\033[38;5;51m'
    cat <<'BANNER'
   ███████╗ ██████╗ ██╗  ██╗██╗██╗  ██╗
   ██╔════╝██╔═══██╗██║ ██╔╝██║╚██╗██╔╝
   ███████╗██║   ██║█████╔╝ ██║ ╚███╔╝
   ╚════██║██║   ██║██╔═██╗ ██║ ██╔██╗
   ███████║╚██████╔╝██║  ██╗██║██╔╝ ██╗
   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝
BANNER
    printf '\033[0m'
    printf '  \033[1;97mS E C U R I T Y   O P S\033[0m  \033[38;5;51m/\033[0m  \033[38;5;213mTOOLKIT v%s\033[0m\n' "$VERSION"
    printf '  \033[38;5;240m%s\033[0m\n' '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
    printf '  \033[38;5;45m●\033[0m %-22s  \033[38;5;45m●\033[0m %-22s  \033[38;5;45m●\033[0m %s\n' "HOST  $host" "OS  $os" "TIME  $now"
    printf '  \033[38;5;240mKERNEL  %s   •   MODO  AUDITORÍA AUTORIZADA\033[0m\n\n' "$kernel"
}

# Enhanced Main Menu with Categories
show_main_menu() {
    local installed=0 category
    [[ -d "$TOOLS_DIR" ]] && installed=$(find "$TOOLS_DIR" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
    printf '  \033[48;5;236m\033[38;5;51m  ◈ PANEL DE CONTROL\033[0m  \033[38;5;240m──────────────────────────────────────────────────────\033[0m\n'
    printf '  \033[38;5;250mHerramientas locales: \033[1;97m%-4s\033[0m  \033[38;5;250mDirectorio: \033[38;5;45m%s\033[0m\n\n' "$installed" "$TOOLS_DIR"
    printf '  \033[38;5;213m┌─ RECONOCIMIENTO & OSINT ────────────────────────────────────────────────┐\033[0m\n'
    printf '  \033[38;5;45m 01–06\033[0m  Fuentes OSINT, ReconDog, Recon Framework\n'
    printf '  \033[38;5;213m┌─ SEGURIDAD WEB ─────────────────────────────────────────────────────────┐\033[0m\n'
    printf '  \033[38;5;45m 07–14\033[0m  XSS, SQLMap, WPScan, Burp Suite, OWASP ZAP\n'
    printf '  \033[38;5;213m┌─ REDES & AUDITORÍA ─────────────────────────────────────────────────────┐\033[0m\n'
    printf '  \033[38;5;45m 15–32\033[0m  Frameworks, Nmap, Wireshark, escáneres y analizadores\n'
    printf '  \033[38;5;213m┌─ INTELIGENCIA, UTILIDADES & CRACKING ────────────────────────────────────┐\033[0m\n'
    printf '  \033[38;5;45m 33–55\033[0m  Reconocimiento, herramientas de red y auditoría de credenciales\n'
    printf '  \033[38;5;213m┌─ SISTEMA & LABORATORIOS ─────────────────────────────────────────────────┐\033[0m\n'
    printf '  \033[38;5;45m 56\033[0m Configuración   \033[38;5;45m57\033[0m Actualizaciones   \033[38;5;45m58\033[0m Salir\n'
    printf '  \033[38;5;45m 59–70\033[0m Laboratorios de juegos   \033[38;5;45m71–74\033[0m Análisis móvil\n\n'
    printf '  \033[38;5;240m─────────────────────────────────────────────────────────────────────────\033[0m\n'
    printf '  \033[38;5;250mSelecciona un número para abrir sus acciones.\033[0m\n'
    printf '  \033[38;5;240mTip: Ctrl+C para cancelar una operación en curso.\033[0m\n\n'
}

# Advanced Error Handling Function
handle_error() {
    local exit_code=$1
    local line_number=$2
    local error_message="Error en la lÃ­nea $line_number con cÃ³digo de salida $exit_code"
    
    echo -e "${COLORS[RED]}${UNICODE[ERROR]} $error_message${COLORS[NC]}"
    echo -e "${COLORS[YELLOW]}${UNICODE[WARNING]} Intentando recuperar el sistema...${COLORS[NC]}"
    
    recover_system
    log_error "$error_message"
    show_error_options
}

# System Recovery Function
recover_system() {
    if [[ -d "$TOOLS_DIR" ]]; then
        chmod -R 755 "$TOOLS_DIR"
        chown -R "$(whoami)" "$TOOLS_DIR"
    fi
    
    check_dependencies
    verify_configurations
    clean_temp_files
}

# Configuration Verification Function
verify_configurations() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        create_default_config
    fi
    
    for dir in "$TOOLS_DIR" "$MODULES_DIR" "$SCRIPTS_DIR" "$CACHE_DIR" "$TEMP_DIR" "$BACKUP_DIR" "$REPORTS_DIR"; do
        if [[ ! -d "$dir" ]]; then
            mkdir -p "$dir"
        fi
    done
}

# Error Logging Function
log_error() {
    local message=${1:-"Error desconocido"}
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    printf '%b%s %s%b\n' "${COLORS[RED]}" "${UNICODE[ERROR]}" "$message" "${COLORS[NC]}" >&2
    mkdir -p "$(dirname "$LOG_FILE")" 2>/dev/null || true
    printf '[%s] ERROR: %s\n' "$timestamp" "$message" >> "$LOG_FILE" 2>/dev/null || true
}

# Show Error Options Function
show_error_options() {
    echo -e "${COLORS[YELLOW]}Opciones disponibles:${COLORS[NC]}"
    echo -e "1. ${COLORS[GREEN]}Reintentar operación${COLORS[NC]}"
    echo -e "2. ${COLORS[GREEN]}Verificar dependencias${COLORS[NC]}"
    echo -e "3. ${COLORS[GREEN]}Reparar configuración${COLORS[NC]}"
    echo -e "4. ${COLORS[GREEN]}Salir${COLORS[NC]}"
    
    read -p "Seleccione una opción: " option
    case $option in
        1) return 0 ;;
        2) check_dependencies ;;
        3) verify_configurations ;;
        4) exit 1 ;;
        *) echo -e "${COLORS[RED]}Opción invÃ¡lida${COLORS[NC]}" ;;
    esac
}

# Clean Temporary Files Function
clean_temp_files() {
    if [[ -d "$TEMP_DIR" ]]; then
        rm -rf "${TEMP_DIR:?}"/*
    fi
}

# Create Default Configuration Function
create_default_config() {
    cat > "$CONFIG_FILE" << EOF
# SOKIX Toolkit Configuration
version: $VERSION
theme: default
debug: false
log_level: info
auto_update: true
proxy_enabled: false
proxy_address: ""
proxy_port: ""
EOF
}

# Set up error trap
# Se evita una recuperación ERR global que alteraba permisos recursivamente.

# Configuración avanzada del entorno
declare -a MODULES=(
    "core"
    "network"
    "web"
    "mobile"
    "osint"
    "exploitation"
    "post-exploitation"
    "forensics"
    "cracking"
    "social-engineering"
    "game-hacking"
    "custom"
)

# Sistema de módulos
declare -A MODULE_CONFIGS
MODULE_CONFIGS=(
    [core]="core_config.yaml"
    [network]="network_config.yaml"
    [web]="web_config.yaml"
    [mobile]="mobile_config.yaml"
    [osint]="osint_config.yaml"
    [exploitation]="exploitation_config.yaml"
    [post-exploitation]="post_exploitation_config.yaml"
    [forensics]="forensics_config.yaml"
    [cracking]="cracking_config.yaml"
    [social-engineering]="social_engineering_config.yaml"
    [game-hacking]="game_hacking_config.yaml"
    [custom]="custom_config.yaml"
)

# Sistema de temas
declare -A THEMES
THEMES=(
    [default]="\033[1;37m"
    [matrix]="\033[1;32m"
    [hacker]="\033[1;31m"
    [cyberpunk]="\033[1;35m"
    [stealth]="\033[1;30m"
    [neon]="\033[1;36m"
)

# Sistema de animaciones
declare -A ANIMATIONS
ANIMATIONS=(
    [loading]="| / - \\"
    [scanning]="â° â±"
    [hacking]="â â â â â â â â â â â â â â â"
    [processing]="â â â â"
    [downloading]="â£¾ â£½ â£» â¢¿ â¡¿ â£ â£¯ â£·"
)

# Repositorios de GitHub para cada herramienta
declare -A GITHUB_REPOS=(
    # OSINT (20 herramientas)
    ["AllHackingTools"]="https://github.com/mishakorzik/AllHackingTools"
    ["NetSoc_OSINT"]="https://github.com/XDeadHackerX/NetSoc_OSINT"
    ["Recursos-Hacking-Etico"]="https://github.com/zamarrowski/recursos-hacking-etico"
    ["OSINT-Framework"]="https://github.com/lockfale/osint-framework"
    ["ReconDog"]="https://github.com/UltimateHackers/ReconDog"
    ["OSINT-Tool"]="https://github.com/saikrishna321/OSINT-Tool"
    ["XSS-Tools"]="https://github.com/An0nUD4Y/XSS-Tools"
    ["D-TECT"]="https://github.com/An0nUD4Y/D-TECT"
    ["TermuxHackingTools"]="https://github.com/Techzindia/TermuxHackingTools"
    ["OSINT-Toolkit"]="https://github.com/saikrishna321/OSINT-Toolkit"
    ["Hacking-Tools"]="https://github.com/An0nUD4Y/Hacking-Tools"
    ["Phishing-Toolkit"]="https://github.com/Techzindia/Phishing-Toolkit"
    ["Social-Engineering-Toolkit"]="https://github.com/trustedsec/social-engineer-toolkit"
    ["Recon-ng"]="https://github.com/lanmaster53/recon-ng"
    ["SpiderFoot"]="https://github.com/smicallef/spiderfoot"
    ["Amass"]="https://github.com/owasp-amass/amass"
    ["Sublist3r"]="https://github.com/aboul3la/Sublist3r"
    ["Nmap"]="https://github.com/nmap/nmap"
    ["Gobuster"]="https://github.com/OJ/gobuster"
    ["Nikto"]="https://github.com/sullo/nikto"
    ["Dirsearch"]="https://github.com/maurosoria/dirsearch"
    ["Wfuzz"]="https://github.com/xmendez/wfuzz"
    ["XSStrike"]="https://github.com/s0md3v/XSStrike"
    ["SQLMap"]="https://github.com/sqlmapproject/sqlmap"
    ["WPScan"]="https://github.com/wpscanteam/wpscan"
    ["Burp-Suite"]="https://github.com/snoopysecurity/burp-suite-community-edition"
    ["OWASP-ZAP"]="https://github.com/zaproxy/zaproxy"
    ["BeEF"]="https://github.com/beefproject/beef"
    ["Cewl"]="https://github.com/digininja/CeWL"
    ["Hashcat"]="https://github.com/hashcat/hashcat"
    ["John-the-Ripper"]="https://github.com/openwall/john"
    ["Mimikatz"]="https://github.com/gentilkiwi/mimikatz"
    ["Empire"]="https://github.com/BC-SECURITY/Empire"
    ["BloodHound"]="https://github.com/BloodHoundAD/BloodHound"
    ["CrackMapExec"]="https://github.com/Porchetta-Industries/CrackMapExec"
    ["Responder"]="https://github.com/lgandx/Responder"
    ["Impacket"]="https://github.com/SecureAuthCorp/impacket"
    ["Kali-Linux"]="https://github.com/OffensiveSecurity/kali-linux"
    ["Metasploit-Framework"]="https://github.com/rapid7/metasploit-framework"
    ["Aircrack-ng"]="https://github.com/aircrack-ng/aircrack-ng"
    ["Hydra"]="https://github.com/vanhauser-thc/thc-hydra"
    ["Wireshark"]="https://github.com/wireshark/wireshark"
    ["Tcpdump"]="https://github.com/the-tcpdump-group/tcpdump"
    ["Scapy"]="https://github.com/secdev/scapy"
    ["Bettercap"]="https://github.com/bettercap/bettercap"
    ["Ettercap"]="https://github.com/Ettercap/ettercap"
    ["Nessus"]="https://github.com/tenable/nessus"
    ["OpenVAS"]="https://github.com/greenbone/openvas"
    ["GVM"]="https://github.com/greenbone/gvm"
    ["Nuclei"]="https://github.com/projectdiscovery/nuclei"
    ["Subfinder"]="https://github.com/projectdiscovery/subfinder"
    ["Naabu"]="https://github.com/projectdiscovery/naabu"
    ["Dnsx"]="https://github.com/projectdiscovery/dnsx"
    ["Httpx"]="https://github.com/projectdiscovery/httpx"
    ["Proxify"]="https://github.com/projectdiscovery/proxify"
    ["Notify"]="https://github.com/projectdiscovery/notify"
    ["Chaos"]="https://github.com/projectdiscovery/chaos-client"
    ["Katana"]="https://github.com/projectdiscovery/katana"
    ["Interactsh"]="https://github.com/projectdiscovery/interactsh"
    ["Cloudlist"]="https://github.com/projectdiscovery/cloudlist"
    ["Uncover"]="https://github.com/projectdiscovery/uncover"
    ["Pdtm"]="https://github.com/projectdiscovery/pdtm"
    
    # ExplotaciÃ³n Web (25 herramientas)
    ["XSS-Tools"]="https://github.com/faizann24/XssPy"
    ["D-TECT"]="https://github.com/shawarkhanethicalhacker/D-TECT"
    ["XSStrike"]="https://github.com/s0md3v/XSStrike"
    ["SQLMap"]="https://github.com/sqlmapproject/sqlmap"
    ["WPScan"]="https://github.com/wpscanteam/wpscan"
    ["Burp-Suite"]="https://github.com/PortSwigger/burp-suite-community"
    ["OWASP-ZAP"]="https://github.com/zaproxy/zaproxy"
    ["BeEF"]="https://github.com/beefproject/beef"
    ["Commix"]="https://github.com/commixproject/commix"
    ["WPSeku"]="https://github.com/m4ll0k/WPSeku"
    ["Joomscan"]="https://github.com/rezasp/joomscan"
    ["Wapiti"]="https://github.com/wapiti-scanner/wapiti"
    ["W3af"]="https://github.com/andresriancho/w3af"
    ["Arachni"]="https://github.com/Arachni/arachni"
    ["Golismero"]="https://github.com/golismero/golismero"
    ["Vega"]="https://github.com/subgraph/Vega"
    ["Nikto"]="https://github.com/sullo/nikto"
    ["Skipfish"]="https://github.com/spinkham/skipfish"
    ["Wfuzz"]="https://github.com/xmendez/wfuzz"
    ["Joomla-Scanner"]="https://github.com/drego85/Joomla-Scanner"
    ["Drupal-Scan"]="https://github.com/r3dxpl0it/Drupal-Scan"
    ["Wordpress-Scanner"]="https://github.com/wpscanteam/wpscan"
    ["Joomla-Vulnerability-Scanner"]="https://github.com/rezasp/joomscan"
    ["Drupal-Vulnerability-Scanner"]="https://github.com/droope/droopescan"
    
    # ExplotaciÃ³n y Post-ExplotaciÃ³n (30 herramientas)
    ["Metasploit"]="https://github.com/rapid7/metasploit-framework"
    ["Empire"]="https://github.com/BC-SECURITY/Empire"
    ["Cobalt-Strike"]="https://github.com/rsmudge/cobalt-strike"
    ["Mimikatz"]="https://github.com/gentilkiwi/mimikatz"
    ["CrackMapExec"]="https://github.com/byt3bl33d3r/CrackMapExec"
    ["Impacket"]="https://github.com/SecureAuthCorp/impacket"
    ["Responder"]="https://github.com/lgandx/Responder"
    ["PowerSploit"]="https://github.com/PowerShellMafia/PowerSploit"
    ["BloodHound"]="https://github.com/BloodHoundAD/BloodHound"
    ["PrivExchange"]="https://github.com/dirkjanm/PrivExchange"
    ["Rubeus"]="https://github.com/GhostPack/Rubeus"
    ["SharpHound"]="https://github.com/BloodHoundAD/SharpHound"
    ["Seatbelt"]="https://github.com/GhostPack/Seatbelt"
    ["SharpUp"]="https://github.com/GhostPack/SharpUp"
    ["SharpView"]="https://github.com/tevora-threat/SharpView"
    ["SharpHound3"]="https://github.com/BloodHoundAD/SharpHound3"
    ["SharpDPAPI"]="https://github.com/GhostPack/SharpDPAPI"
    ["SharpDump"]="https://github.com/GhostPack/SharpDump"
    ["SharpWMI"]="https://github.com/GhostPack/SharpWMI"
    ["SharpRoast"]="https://github.com/GhostPack/SharpRoast"
    ["SharpSploit"]="https://github.com/cobbr/SharpSploit"
    ["SharpHound2"]="https://github.com/BloodHoundAD/SharpHound2"
    ["SharpHound4"]="https://github.com/BloodHoundAD/SharpHound4"
    ["SharpHound5"]="https://github.com/BloodHoundAD/SharpHound5"
    ["SharpHound6"]="https://github.com/BloodHoundAD/SharpHound6"
    ["SharpHound7"]="https://github.com/BloodHoundAD/SharpHound7"
    ["SharpHound8"]="https://github.com/BloodHoundAD/SharpHound8"
    ["SharpHound9"]="https://github.com/BloodHoundAD/SharpHound9"
    ["SharpHound10"]="https://github.com/BloodHoundAD/SharpHound10"
    
    # Escaneo y AnÃ¡lisis de Red (20 herramientas)
    ["Nmap"]="https://github.com/nmap/nmap"
    ["Wireshark"]="https://github.com/wireshark/wireshark"
    ["Bettercap"]="https://github.com/bettercap/bettercap"
    ["Nessus"]="https://github.com/tenable/nessus"
    ["Masscan"]="https://github.com/robertdavidgraham/masscan"
    ["Zmap"]="https://github.com/zmap/zmap"
    ["Netdiscover"]="https://github.com/netdiscover-scanner/netdiscover"
    ["Netcat"]="https://github.com/diegocr/netcat"
    ["Hping"]="https://github.com/antirez/hping"
    ["Tcpdump"]="https://github.com/the-tcpdump-group/tcpdump"
    ["Tshark"]="https://github.com/wireshark/wireshark"
    ["Scapy"]="https://github.com/secdev/scapy"
    ["Netcat"]="https://github.com/diegocr/netcat"
    ["Netcat-traditional"]="https://github.com/diegocr/netcat"
    ["Netcat-openbsd"]="https://github.com/diegocr/netcat"
    ["Netcat-gnu"]="https://github.com/diegocr/netcat"
    ["Netcat-bsd"]="https://github.com/diegocr/netcat"
    ["Netcat-debian"]="https://github.com/diegocr/netcat"
    ["Netcat-ubuntu"]="https://github.com/diegocr/netcat"
    ["Netcat-kali"]="https://github.com/diegocr/netcat"
    
    # Hacking de Juegos (20 herramientas)
    ["Metasploit-Framework"]="https://github.com/rapid7/metasploit-framework"
    ["Game-Hacking"]="https://github.com/dsasmblr/game-hacking"
    ["Game-Hacking-1"]="https://github.com/Mehardeep/game-hacking-1"
    ["Cheat-Engine"]="https://github.com/dsasmblr/cheat-engine"
    ["Squalr"]="https://github.com/Squalr/Squalr"
    ["MungPlex"]="https://github.com/CosmoCortney/MungPlex"
    ["GTA-SA-Cheats"]="https://github.com/Edward-P-Astbury/gta_sa_cheats"
    ["Payback2-CHEATus"]="https://github.com/ABJ4403/Payback2_CHEATus"
    ["SimCity-Cheat"]="https://github.com/souforte/SimCity-Cheat"
    ["Warzone2100"]="https://github.com/Warzone2100/warzone2100"
    ["StellarRealms"]="https://github.com/nagten/StellarRealms"
    ["Hacking-Online-Games"]="https://github.com/dsasmblr/hacking-online-games"
    ["Reloaded-Memory-SigScan"]="https://github.com/Reloaded-Project/Reloaded.Memory.SigScan"
    ["GH-D3D11-Hook"]="https://github.com/guided-hacking/GH_D3D11_Hook"
    ["Game-Hacks"]="https://github.com/topics/game-hacks"
    ["Game-Hack-Menu"]="https://github.com/topics/game-hack-menu"
    ["Hacking-Tools"]="https://github.com/topics/hacking-tools"
    ["Game-Tweaks"]="https://github.com/topics/game-tweaks"
    ["GameGuardian"]="https://github.com/GameGuardian/GameGuardian"
    ["GameCIH"]="https://github.com/GameCIH/GameCIH"
    ["GameKiller"]="https://github.com/GameKiller/GameKiller"
    ["GameGuard"]="https://github.com/GameGuard/GameGuard"
    ["GameHack"]="https://github.com/GameHack/GameHack"
    ["GameTool"]="https://github.com/GameTool/GameTool"
    ["GameMaster"]="https://github.com/GameMaster/GameMaster"
    ["GameWarden"]="https://github.com/GameWarden/GameWarden"
    
    # Hacking de Aplicaciones Móviles (20 herramientas)
    ["WhatsAppHacking"]="https://github.com/WhatsAppHacking/WhatsAppHacking"
    ["Android-Studio"]="https://github.com/android/studio"
    ["APKTool"]="https://github.com/iBotPeaches/Apktool"
    ["Dex2Jar"]="https://github.com/pxb1988/dex2jar"
    ["Frida"]="https://github.com/frida/frida"
    ["Objection"]="https://github.com/sensepost/objection"
    ["MobSF"]="https://github.com/MobSF/Mobile-Security-Framework-MobSF"
    ["JADX"]="https://github.com/skylot/jadx"
    ["Ghidra"]="https://github.com/NationalSecurityAgency/ghidra"
    ["Radare2"]="https://github.com/radareorg/radare2"
    ["APK-MITM"]="https://github.com/shroudedcode/apk-mitm"
    ["APKLeaks"]="https://github.com/dwisiswant0/apkleaks"
    ["APK-Downloader"]="https://github.com/APK-Downloader/APK-Downloader"
    ["Android-Tools"]="https://github.com/android/tools"
    ["Android-SDK"]="https://github.com/android/sdk"
    ["Android-NDK"]="https://github.com/android/ndk"
    ["Android-Platform"]="https://github.com/android/platform"
    ["Android-Framework"]="https://github.com/android/framework"
    ["Android-System"]="https://github.com/android/system"
    ["Android-Kernel"]="https://github.com/android/kernel"
    
    # Herramientas de Hacking Ãtico (50 herramientas)
    ["Metasploit-Framework"]="https://github.com/rapid7/metasploit-framework"
    ["Nmap"]="https://github.com/nmap/nmap"
    ["SQLMap"]="https://github.com/sqlmapproject/sqlmap"
    ["Mimikatz"]="https://github.com/gentilkiwi/mimikatz"
    ["Aircrack-ng"]="https://github.com/aircrack-ng/aircrack-ng"
    ["Wireshark"]="https://github.com/wireshark/wireshark"
    ["Burp-Suite"]="https://github.com/snoopysecurity/burp-suite-community-edition"
    ["Empire"]="https://github.com/BC-SECURITY/Empire"
    ["Hydra"]="https://github.com/vanhauser-thc/thc-hydra"
    ["Bettercap"]="https://github.com/bettercap/bettercap"
    ["John-the-Ripper"]="https://github.com/openwall/john"
    ["Hashcat"]="https://github.com/hashcat/hashcat"
    ["OWASP-ZAP"]="https://github.com/zaproxy/zaproxy"
    ["Sublist3r"]="https://github.com/aboul3la/Sublist3r"
    ["Nuclei"]="https://github.com/projectdiscovery/nuclei"
    ["Gobuster"]="https://github.com/OJ/gobuster"
    ["XSStrike"]="https://github.com/s0md3v/XSStrike"
    ["Social-Engineering-Toolkit"]="https://github.com/trustedsec/social-engineer-toolkit"
    ["GoPhish"]="https://github.com/gophish/gophish"
    ["BloodHound"]="https://github.com/BloodHoundAD/BloodHound"
    ["CrackMapExec"]="https://github.com/Porchetta-Industries/CrackMapExec"
    ["Responder"]="https://github.com/lgandx/Responder"
    ["Impacket"]="https://github.com/SecureAuthCorp/impacket"
    ["Recon-ng"]="https://github.com/lanmaster53/recon-ng"
    ["SpiderFoot"]="https://github.com/smicallef/spiderfoot"
    ["Amass"]="https://github.com/owasp-amass/amass"
    ["Fierce"]="https://github.com/mschwager/fierce"
    ["Subfinder"]="https://github.com/projectdiscovery/subfinder"
    ["Dirsearch"]="https://github.com/maurosoria/dirsearch"
    ["Nikto"]="https://github.com/sullo/nikto"
    ["Skipfish"]="https://github.com/spinkham/skipfish"
    ["Wfuzz"]="https://github.com/xmendez/wfuzz"
    ["Sqlninja"]="https://github.com/sqlninja/sqlninja"
    ["Nessus"]="https://github.com/tenable/nessus"
    ["Zphisher"]="https://github.com/htr-tech/zphisher"
    ["Maltego"]="https://github.com/paterva/maltego"
    ["Osmedeus"]="https://github.com/j3ssie/Osmedeus"
    ["Red-Team-Attack-Lab"]="https://github.com/infosecn1nja/Red-Teaming-Toolkit"
    ["Vega"]="https://github.com/subgraph/Vega"
    ["Cobalt-Strike"]="https://github.com/Fortra/Cobalt-Strike"
    ["Mudge-Password-Tools"]="https://github.com/mudgen/"
    ["Cewl"]="https://github.com/digininja/CeWL"
    ["T50"]="https://github.com/s0lst1c3/t50"
    ["Nginx-Helper"]="https://github.com/rbenv/nginx_helper"
    ["Crackstation"]="https://github.com/crackstation/"
    ["ProxyChains"]="https://github.com/haad/proxychains"
    ["GoReverseShell"]="https://github.com/danielmiessler/GoReverseShell"
    ["Scapy"]="https://github.com/secdev/scapy"
    ["Tcpdump"]="https://github.com/the-tcpdump-group/tcpdump"
    ["Ettercap"]="https://github.com/Ettercap/ettercap"
    ["OpenVAS"]="https://github.com/greenbone/openvas"
    ["GVM"]="https://github.com/greenbone/gvm"
    ["Naabu"]="https://github.com/projectdiscovery/naabu"
    ["Dnsx"]="https://github.com/projectdiscovery/dnsx"
    ["Httpx"]="https://github.com/projectdiscovery/httpx"
    ["Proxify"]="https://github.com/projectdiscovery/proxify"
    ["Notify"]="https://github.com/projectdiscovery/notify"
    ["Chaos"]="https://github.com/projectdiscovery/chaos-client"
    ["Katana"]="https://github.com/projectdiscovery/katana"
    ["Interactsh"]="https://github.com/projectdiscovery/interactsh"
    ["Cloudlist"]="https://github.com/projectdiscovery/cloudlist"
    ["Uncover"]="https://github.com/projectdiscovery/uncover"
    ["Pdtm"]="https://github.com/projectdiscovery/pdtm"
)

# Required Dependencies and Tools
declare -a REQUIRED_DEPENDENCIES=(
    "python3"
    "git"
    "java"
    "ruby"
    "perl"
    "gcc"
    "make"
    "wget"
    "curl"
)

declare -a REQUIRED_TOOLS=(
    "nmap"
    "sqlmap"
    "metasploit-framework"
    "wireshark"
    "burpsuite"
    "aircrack-ng"
)

# Función mejorada para mostrar la pantalla de carga
show_loading_screen() {
    local total_steps=7
    local current_step=0
    
    # Paso 1: InicializaciÃ³n del sistema
    clear
    echo -e "${THEMES['matrix']}"
    echo "  ââââââââ âââââââ âââ  âââââââââ  âââ"
    echo "  ââââââââââââââââââââ âââââââââââââââ"
    echo "  âââââââââââ   ââââââââââ âââ ââââââ "
    echo "  âââââââââââ   ââââââââââ âââ ââââââ "
    echo "  ââââââââââââââââââââ  ââââââââââ âââ"
    echo "  ââââââââ âââââââ âââ  âââââââââ  âââ"
    echo -e "${COLORS['NC']}"
    echo -e "${COLORS['CYAN']}Professional Ethical Hacking Environment v$VERSION${COLORS['NC']}"
    echo -e "${COLORS['YELLOW']}Copyright (c) 2024 SOKIX Security Team${COLORS['NC']}"
    echo
    
    show_system_info
    
    current_step=$((current_step + 1))
    show_progress "Inicializando sistema" $current_step $total_steps
    
    # Paso 2: Autodiagnóstico
    perform_diagnostic
    current_step=$((current_step + 1))
    show_progress "Diagnóstico completado" $current_step $total_steps
    
    # Paso 3: Descargando herramientas
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['DOWNLOAD']} Descargando herramientas... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    local total_tools=${#GITHUB_REPOS[@]}
    local current_tool=0
    
    # Crear directorio de herramientas si no existe
    mkdir -p "$TOOLS_DIR"
    
    for tool in "${!GITHUB_REPOS[@]}"; do
        current_tool=$((current_tool + 1))
        local progress=$((current_tool * 100 / total_tools))
        
        # Mostrar barra de progreso
        echo -ne "\r${COLORS['CYAN']}["
        for ((i=0; i<50; i++)); do
            if [ $i -lt $((progress / 2)) ]; then
                echo -ne "${ANIMATIONS['downloading'][$((i % ${#ANIMATIONS['downloading'][@]}))]}"
            else
                echo -ne " "
            fi
        done
        echo -ne "] Descargando $tool...${COLORS['NC']}"
        
        # Instalar la herramienta
        install_tool "$tool"
        
        # Verificar si la instalación fue exitosa
        if [ $? -eq 0 ]; then
            echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} $tool instalado correctamente${COLORS['NC']}"
        else
            echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Error al instalar $tool${COLORS['NC']}"
        fi
    done
    
    current_step=$((current_step + 1))
    show_progress "Herramientas descargadas" $current_step $total_steps
    
    # Paso 4: Cargando módulos con animaciÃ³n
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['GEAR']} Cargando módulos del sistema... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    for module in "${MODULES[@]}"; do
        show_module_loading "$module"
        load_module "$module"
    done
    
    current_step=$((current_step + 1))
    show_progress "Módulos cargados" $current_step $total_steps
    
    # Paso 5: Verificando dependencias con animaciÃ³n
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['PACKAGE']} Verificando dependencias... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    check_dependencies
    
    current_step=$((current_step + 1))
    show_progress "Dependencias verificadas" $current_step $total_steps
    
    # Paso 6: Configurando entorno con animaciÃ³n
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['WRENCH']} Configurando entorno... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    setup_environment
    
    current_step=$((current_step + 1))
    show_progress "Entorno configurado" $current_step $total_steps
    
    # Paso 7: Inicializando herramientas con animaciÃ³n
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['TOOLS']} Inicializando herramientas... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    initialize_tools
    
    current_step=$((current_step + 1))
    show_progress "Herramientas inicializadas" $current_step $total_steps
    
    # Paso 8: FinalizaciÃ³n con resumen
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['CHART']} Resumen del sistema: ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    show_system_summary
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"
    echo -e "${COLORS['GREEN']}${UNICODE['SUCCESS']} Toolkit inicializado correctamente${COLORS['NC']}"
    sleep 2
}

# Función para mostrar información del sistema
show_system_info() {
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_TOP']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['TERMINAL']} Información del Sistema ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    
    local os_info=$(uname -a)
    local cpu_info=$(cat /proc/cpuinfo | grep "model name" | head -n 1 | cut -d ":" -f 2)
    local mem_info=$(free -h | grep Mem | awk '{print $2}')
    local disk_info=$(df -h / | tail -n 1 | awk '{print $2}')
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Sistema Operativo:${COLORS['NC']} $os_info ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Procesador:${COLORS['NC']} $cpu_info ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Memoria:${COLORS['NC']} $mem_info ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Disco:${COLORS['NC']} $disk_info ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"
}

# Función para realizar el diagnóstico del sistema
perform_diagnostic() {
    local total_checks=10
    local current_check=0
    local success_count=0
    local warning_count=0
    local error_count=0

    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_TOP']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}${UNICODE['MAGNIFIER']} Iniciando diagnóstico del sistema... ${COLORS['NC']}${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"

    # 1. Verificar sistema operativo
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando sistema operativo...${COLORS['NC']}"
    if check_os; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Sistema operativo compatible${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Sistema operativo no compatible${COLORS['NC']}"
    fi

    # 2. Verificar memoria RAM
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando memoria RAM...${COLORS['NC']}"
    if check_memory; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Memoria RAM suficiente${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} Memoria RAM insuficiente${COLORS['NC']}"
    fi

    # 3. Verificar almacenamiento
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando almacenamiento...${COLORS['NC']}"
    if check_storage; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Almacenamiento suficiente${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} Almacenamiento insuficiente${COLORS['NC']}"
    fi

    # 4. Verificar CPU
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando CPU...${COLORS['NC']}"
    if check_cpu; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} CPU compatible${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} CPU no recomendada${COLORS['NC']}"
    fi

    # 5. Verificar red
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando conexiÃ³n de red...${COLORS['NC']}"
    if check_network; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} ConexiÃ³n de red estable${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Problemas de conexiÃ³n${COLORS['NC']}"
    fi

    # 6. Verificar dependencias
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando dependencias...${COLORS['NC']}"
    if check_dependencies; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Dependencias instaladas${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Faltan dependencias${COLORS['NC']}"
    fi

    # 7. Verificar permisos
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando permisos...${COLORS['NC']}"
    if check_permissions; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Permisos correctos${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Problemas de permisos${COLORS['NC']}"
    fi

    # 8. Verificar directorios
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando directorios...${COLORS['NC']}"
    if check_directories; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Directorios correctos${COLORS['NC']}"
    else
        error_count=$((error_count + 1))
        echo -e "\r${COLORS['RED']}${UNICODE['ERROR']} Problemas con directorios${COLORS['NC']}"
    fi

    # 9. Verificar herramientas
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando herramientas...${COLORS['NC']}"
    if check_tools; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Herramientas instaladas${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} Faltan algunas herramientas${COLORS['NC']}"
    fi

    # 10. Verificar configuración
    current_check=$((current_check + 1))
    echo -ne "\r${COLORS['CYAN']}[$current_check/$total_checks] Verificando configuración...${COLORS['NC']}"
    if check_configuration; then
        success_count=$((success_count + 1))
        echo -e "\r${COLORS['GREEN']}${UNICODE['SUCCESS']} Configuración correcta${COLORS['NC']}"
    else
        warning_count=$((warning_count + 1))
        echo -e "\r${COLORS['YELLOW']}${UNICODE['WARNING']} Configuración incompleta${COLORS['NC']}"
    fi

    # Mostrar resumen
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}Resumen del diagnóstico:${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}Ãxitos: $success_count${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Advertencias: $warning_count${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['RED']}Errores: $error_count${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"

    # Retornar estado
    if [ $error_count -gt 0 ]; then
        return 1
    elif [ $warning_count -gt 0 ]; then
        return 2
    else
        return 0
    fi
}

# Función para verificar el sistema operativo
check_os() {
    case "$(uname -s)" in
        Linux)
            # Verificar distribuciÃ³n
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                case "$ID" in
                    ubuntu|debian|kali)
                        return 0
                        ;;
                    *)
                        return 1
                        ;;
                esac
            fi
            ;;
        Darwin)
            # Verificar versiÃ³n de macOS
            if [ "$(sw_vers -productVersion | cut -d. -f1)" -ge 10 ]; then
                return 0
            fi
            ;;
        MINGW*|MSYS*|CYGWIN*)
            # Verificar versiÃ³n de Windows
            if [ "$(uname -r | cut -d- -f1)" -ge 10 ]; then
                return 0
            fi
            ;;
    esac
    return 1
}

# Función para verificar memoria RAM
check_memory() {
    local min_ram=4000  # 4GB en MB
    local recommended_ram=8000  # 8GB en MB
    local total_ram=$(free -m | awk '/^Mem:/{print $2}')
    
    if [ "$total_ram" -ge "$recommended_ram" ]; then
        return 0
    elif [ "$total_ram" -ge "$min_ram" ]; then
        echo -e "${COLORS['YELLOW']}${UNICODE['WARNING']} Memoria RAM insuficiente (${total_ram}MB). Se recomiendan al menos ${recommended_ram}MB${COLORS['NC']}"
        return 1
    else
        echo -e "${COLORS['RED']}${UNICODE['ERROR']} Memoria RAM insuficiente (${total_ram}MB). MÃ­nimo requerido: ${min_ram}MB${COLORS['NC']}"
        return 2
    fi
}

# Función para verificar almacenamiento
check_storage() {
    local min_storage=20000  # 20GB en MB
    local available_storage=$(df -m / | awk 'NR==2 {print $4}')
    
    if [ "$available_storage" -ge "$min_storage" ]; then
        return 0
    fi
    return 1
}

# Función para verificar CPU
check_cpu() {
    local min_cores=2
    local cores=$(nproc)
    
    if [ "$cores" -ge "$min_cores" ]; then
        return 0
    fi
    return 1
}

# Función para verificar red
check_network() {
    if ping -c 1 google.com &> /dev/null; then
        return 0
    fi
    return 1
}

# Función para verificar directorios
check_directories() {
    local required_dirs=(
        "$TOOLS_DIR"
        "$MODULES_DIR"
        "$SCRIPTS_DIR"
        "$CACHE_DIR"
        "$TEMP_DIR"
        "$BACKUP_DIR"
        "$REPORTS_DIR"
    )
    
    for dir in "${required_dirs[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir" || return 1
        fi
        if [ ! -w "$dir" ]; then
            return 1
        fi
    done
    return 0
}

# Función para verificar configuración
check_configuration() {
    if [ ! -f "$CONFIG_FILE" ]; then
        create_default_config || return 1
    fi
    
    # Verificar permisos del archivo de configuración
    if [ ! -r "$CONFIG_FILE" ] || [ ! -w "$CONFIG_FILE" ]; then
        return 1
    fi
    
    return 0
}

# Función para mostrar la carga de módulos con animaciÃ³n
show_module_loading() {
    local module=$1
    echo -ne "\r${COLORS['CYAN']}["
    for ((i=0; i<50; i++)); do
        echo -ne "${ANIMATIONS['processing'][$((i % ${#ANIMATIONS['processing'][@]}))]}"
    done
    echo -ne "] Cargando módulo: $module...${COLORS['NC']}"
    sleep 0.3
}

# Función para mostrar resumen del sistema
show_system_summary() {
    local total_modules=${#MODULES[@]}
    local total_tools=$(ls "$TOOLS_DIR" | wc -l)
    local system_status="OK"
    local security_status="OK"
    local performance_status="OK"
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Módulos cargados:${COLORS['NC']} $total_modules ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Herramientas instaladas:${COLORS['NC']} $total_tools ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Estado del sistema:${COLORS['NC']} $system_status ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Estado de seguridad:${COLORS['NC']} $security_status ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['YELLOW']}Rendimiento:${COLORS['NC']} $performance_status ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
}

# Funciones de diagnóstico especÃ­ficas
check_system() {
    # Check system requirements
    if [ "$(uname)" != "Linux" ]; then
        echo -e "${COLORS['RED']}Warning: This toolkit is optimized for Linux systems${COLORS['NC']}"
        return 1
    fi
    return 0
}

check_network() {
    # Check network connectivity
    if ! ping -c 1 google.com &> /dev/null; then
        echo -e "${COLORS['RED']}No internet connection${COLORS['NC']}"
        return 1
    fi
    return 0
}

check_security() {
    # Check security settings
    if [ "$(id -u)" != "0" ]; then
        echo -e "${COLORS['YELLOW']}Running without root privileges${COLORS['NC']}"
        return 1
    fi
    return 0
}

check_performance() {
    # Check system performance
    local load=$(uptime | awk '{print $(NF-2)}' | tr -d ',')
    if (( $(echo "$load > 2.0" | bc -l) )); then
        echo -e "${COLORS['YELLOW']}High system load detected${COLORS['NC']}"
        return 1
    fi
    return 0
}

check_dependencies() {
    for dep in "${REQUIRED_DEPENDENCIES[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            log_warning "$dep no está instalado"
            install_dependency "$dep"
        fi
    done
}

check_tools() {
    local missing_tools=()
    local installed_tools=()
    
    for tool in "${REQUIRED_TOOLS[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        else
            installed_tools+=("$tool")
        fi
    done
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        log_warning "Herramientas faltantes: ${missing_tools[*]}"
        log_info "Intentando instalar herramientas faltantes..."
        
        for tool in "${missing_tools[@]}"; do
            install_dependency "$tool"
        done
        
        # Verificar nuevamente despuÃ©s de la instalación
        local still_missing=()
        for tool in "${missing_tools[@]}"; do
            if ! command -v "$tool" &> /dev/null; then
                still_missing+=("$tool")
            fi
        done
        
        if [ ${#still_missing[@]} -gt 0 ]; then
            log_error "No se pudieron instalar las siguientes herramientas: ${still_missing[*]}"
            return 1
        fi
    fi
    
    log_success "Herramientas instaladas: ${installed_tools[*]}"
    return 0
}

check_permissions() {
    local log_dir
    log_dir=$(dirname "$LOG_FILE")
    
    # Verificar y crear directorio de logs si no existe
    if [ ! -d "$log_dir" ]; then
        run_or_fail "No se pudo crear el directorio de logs" mkdir -p "$log_dir" || return 1
    fi
    
    # Verificar permisos del directorio de logs
    if [ ! -w "$log_dir" ]; then
        log_warning "Intentando corregir permisos del directorio de logs..."
        run_or_fail "No se pudo corregir los permisos del directorio de logs" sudo chown -R "$(whoami)" "$log_dir" || return 1
    fi
    
    # Verificar y crear archivo de log si no existe
    if [ ! -f "$LOG_FILE" ]; then
        run_or_fail "No se pudo crear el archivo de log" touch "$LOG_FILE" || return 1
    fi
    
    # Verificar permisos del archivo de log
    if [ ! -w "$LOG_FILE" ]; then
        log_warning "Intentando corregir permisos del archivo de log..."
        run_or_fail "No se pudo corregir los permisos del archivo de log" sudo chown "$(whoami)" "$LOG_FILE" || return 1
    fi
    
    return 0
}

# Función para mostrar progreso con animaciÃ³n
show_progress() {
    local message=$1
    local current=$2
    local total=$3
    local width=50
    local progress=$((current * width / total))
    local remaining=$((width - progress))
    local hacking_animation=${ANIMATIONS['hacking']}
    
    echo -ne "\r${COLORS['CYAN']}["
    for ((i=0; i<progress; i++)); do
        local animation_index=$((i % ${#ANIMATIONS['hacking']}))
        echo -ne "${ANIMATIONS['hacking']:$animation_index:1}"
    done
    for ((i=0; i<remaining; i++)); do
        echo -ne " "
    done
    echo -ne "] ${message}...${COLORS['NC']}"
}

# Función para cargar módulos
load_module() {
    local module=$1
    local config_file="${MODULE_CONFIGS[$module]}"
    
    if [ -f "$CONFIG_DIR/$config_file" ]; then
        log_info "Configuración disponible para el módulo $module: $CONFIG_DIR/$config_file"
    else
        log_warning "Configuración no encontrada para $module"
    fi
}

# Función para instalar dependencias
install_dependency() {
    local dep=${1:-}
    if [[ -z "$dep" ]]; then
        log_error "No se especificó una dependencia"
        return 2
    fi
    if command -v "$dep" >/dev/null 2>&1; then
        log_success "$dep ya está instalado"
        return 0
    fi
    log_warning "Falta '$dep'. Instálalo con el gestor de paquetes de tu sistema y vuelve a intentarlo."
    return 1
}

# Función para configurar el entorno
setup_environment() {
    # Configurar variables de entorno
    export PATH="$PATH:$TOOLS_DIR/bin"
    export PYTHONPATH="$PYTHONPATH:$TOOLS_DIR/python"
    
    # Crear directorios necesarios
    mkdir -p "$TOOLS_DIR/bin"
    mkdir -p "$TOOLS_DIR/python"
    mkdir -p "$TOOLS_DIR/ruby"
    mkdir -p "$TOOLS_DIR/perl"
    mkdir -p "$TOOLS_DIR/java"
    
    # Configurar permisos
    chmod 755 "$TOOLS_DIR" "$TOOLS_DIR/bin" "$TOOLS_DIR/python" "$TOOLS_DIR/ruby" "$TOOLS_DIR/perl" "$TOOLS_DIR/java" 2>/dev/null || true
}

# Función para inicializar herramientas
initialize_tools() {
    local tools=($(ls "$TOOLS_DIR"))
    local total_tools=${#tools[@]}
    local current_tool=0
    local failed_tools=()
    
    for tool in "${tools[@]}"; do
        current_tool=$((current_tool + 1))
        local progress=$((current_tool * 100 / total_tools))
        
        echo -ne "\r${COLORS['CYAN']}["
        for ((i=0; i<50; i++)); do
            if [ $i -lt $((progress / 2)) ]; then
                echo -ne "${ANIMATIONS['downloading'][$((i % ${#ANIMATIONS['downloading'][@]}))]}"
            else
                echo -ne " "
            fi
        done
        echo -ne "] Inicializando $tool...${COLORS['NC']}"
        
        if ! install_tool "$tool"; then
            failed_tools+=("$tool")
        fi
    done
    
    # Mostrar resumen de inicialización
    echo -e "\n${COLORS['PURPLE']}${UNICODE['BORDER_MIDDLE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['CYAN']}Resumen de inicialización:${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['GREEN']}Herramientas inicializadas: $((total_tools - ${#failed_tools[@]}))${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    
    if [ ${#failed_tools[@]} -gt 0 ]; then
        echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']} ${COLORS['RED']}Herramientas fallidas: ${failed_tools[*]}${COLORS['NC']} ${COLORS['PURPLE']}${UNICODE['BORDER_SIDE']}${COLORS['NC']}"
    fi
    
    echo -e "${COLORS['PURPLE']}${UNICODE['BORDER_BOTTOM']}${COLORS['NC']}"
}

# Función para encontrar el archivo principal de una herramienta
find_main_file() {
    local tool_dir=${1:-} candidate
    [[ -d "$tool_dir" ]] || return 1
    # Prefer documented entry points; avoid accidentally running a random script.
    for candidate in main.py app.py run.py cli.py __main__.py main.sh run.sh start.sh; do
        if [[ -f "$tool_dir/$candidate" ]]; then printf '%s\n' "$tool_dir/$candidate"; return 0; fi
    done
    for candidate in "$tool_dir"/*.sh "$tool_dir"/*.py "$tool_dir"/*.rb "$tool_dir"/*.jar; do
        [[ -f "$candidate" ]] || continue
        # Los nombres de scripts auxiliares se filtran sin distinguir mayúsculas.
        # Evita ejecutar Install.sh como si fuera la aplicación principal (caso del error pip2).
        case "$(basename "$candidate" | tr '[:upper:]' '[:lower:]')" in
            fix.sh|install.sh|setup.sh|uninstall.sh|update.sh|build.sh|test.sh|requirements.sh|configure.sh) continue ;;
        esac
        printf '%s\n' "$candidate"; return 0
    done
    return 1
}

# Función para ejecutar herramientas
run_tool() {
    local tool_name=${1:-} tool_dir main_file extension python_bin
    [[ -n "$tool_name" ]] || { log_error "No se indicó herramienta"; return 2; }
    shift
    tool_dir="$TOOLS_DIR/$tool_name"
    # Compatibilidad con instalaciones anteriores en /opt/sokix/tools.
    if [[ ! -d "$tool_dir" && -d "/opt/sokix/tools/$tool_name" ]]; then
        tool_dir="/opt/sokix/tools/$tool_name"
    fi
    [[ -d "$tool_dir" ]] || { log_error "$tool_name no está instalada. Directorios revisados: $TOOLS_DIR/$tool_name y /opt/sokix/tools/$tool_name"; return 1; }
    # Nunca elegir fix.sh como punto de entrada: en AllHackingTools es un reparador
    # auxiliar que presupone un directorio de trabajo distinto y causa los errores
    # de rutas relativas mostrados en la captura.
    main_file=$(find_main_file "$tool_dir") || { log_error "No encuentro un punto de entrada principal seguro para $tool_name. Revisa su README; los scripts auxiliares no se ejecutan automáticamente."; return 1; }
    extension=${main_file##*.}
    log_warning "Vas a ejecutar código de terceros: $main_file"
    read -r -p "Confirma que tienes autorización y revisaste el código (escribe SI): " confirm
    [[ "$confirm" == "SI" ]] || { log_info "Ejecución cancelada."; return 0; }
    case "$extension" in
        sh) ( cd "$tool_dir" && bash "$main_file" "$@" ) ;;
        py)
            python_bin="$tool_dir/.venv/bin/python"
            [[ -x "$python_bin" ]] || python_bin=$(command -v python3 || true)
            [[ -n "$python_bin" ]] || { log_error "Falta python3"; return 1; }
            ( cd "$tool_dir" && "$python_bin" "$main_file" "$@" ) ;;
        rb) command -v ruby >/dev/null 2>&1 || { log_error "Falta ruby"; return 1; }; ( cd "$tool_dir" && ruby "$main_file" "$@" ) ;;
        jar) command -v java >/dev/null 2>&1 || { log_error "Falta Java"; return 1; }; ( cd "$tool_dir" && java -jar "$main_file" "$@" ) ;;
        *) log_error "Tipo de entrada no compatible automáticamente: .$extension. Consulta el README."; return 1 ;;
    esac
}

# Función para verificar si una herramienta está instalada
is_tool_installed() {
    local tool_name=${1:-} tool_dir="${TOOLS_DIR}/${1:-}" command_name=""
    case "$tool_name" in
        Nmap) command_name=nmap ;; Wireshark) command_name=wireshark ;; SQLMap) command_name=sqlmap ;;
        Aircrack-ng) command_name=aircrack-ng ;; Hydra) command_name=hydra ;; Nikto) command_name=nikto ;;
        Gobuster) command_name=gobuster ;; John-the-Ripper) command_name=john ;; Hashcat) command_name=hashcat ;;
        Impacket) command_name=impacket-scripts ;; Metasploit-Framework) command_name=msfconsole ;;
    esac
    if [[ -n "$command_name" ]] && command -v "$command_name" >/dev/null 2>&1; then return 0; fi
    [[ -n "$tool_name" && -d "$tool_dir" ]] || return 1
    [[ -f "$tool_dir/.sokix-installed" ]] && return 0
    find_main_file "$tool_dir" >/dev/null 2>&1
}

# Función para instalar herramientas
install_tool() {
    local tool_name=${1:-} repo_url tool_dir stage venv_dir
    [[ -n "$tool_name" ]] || { log_error "No se indicó herramienta"; return 2; }
    repo_url=${GITHUB_REPOS[$tool_name]:-}
    [[ -n "$repo_url" ]] || { log_error "No hay repositorio configurado para $tool_name"; return 1; }
    # Prefer Kali/Debian packages for these tools: dependencies and updates are handled by APT.
    local apt_package=""
    case "$tool_name" in
        Nmap) apt_package=nmap ;; Wireshark) apt_package=wireshark ;; SQLMap) apt_package=sqlmap ;;
        Aircrack-ng) apt_package=aircrack-ng ;; Hydra) apt_package=hydra ;; Nikto) apt_package=nikto ;;
        Gobuster) apt_package=gobuster ;; John-the-Ripper) apt_package=john ;; Hashcat) apt_package=hashcat ;;
        Impacket) apt_package=python3-impacket ;; Metasploit-Framework) apt_package=metasploit-framework ;;
        *) apt_package="" ;;
    esac
    if [[ -n "$apt_package" ]] && command -v apt-get >/dev/null 2>&1; then
        if dpkg-query -W -f='${Status}' "$apt_package" 2>/dev/null | grep -q 'install ok installed'; then
            log_success "$apt_package ya está instalado por APT"; return 0
        fi
        log_warning "Instalando paquete de distribución: $apt_package"
        if [[ ${EUID:-$(id -u)} -eq 0 ]]; then
            if DEBIAN_FRONTEND=noninteractive apt-get install -y -- "$apt_package"; then
                log_success "$tool_name instalado mediante APT"; return 0
            fi
        elif command -v sudo >/dev/null 2>&1; then
            if sudo env DEBIAN_FRONTEND=noninteractive apt-get install -y -- "$apt_package"; then
                log_success "$tool_name instalado mediante APT"; return 0
            fi
        fi
        log_error "APT no pudo instalar $apt_package; revisa permisos y repositorios."
        return 1
    fi
    command -v git >/dev/null 2>&1 || { log_error "Falta git. Instálalo con: apt install git"; return 1; }
    mkdir -p "$TOOLS_DIR" "$CACHE_DIR" || { log_error "No puedo crear directorios de SOKIX"; return 1; }
    tool_dir="$TOOLS_DIR/$tool_name"
    if [[ -d "$tool_dir/.git" || -f "$tool_dir/.sokix-installed" ]]; then
        log_warning "$tool_name ya tiene una instalación; no la sobrescribo."
        return 0
    fi
    if [[ -e "$tool_dir" ]]; then
        log_error "Existe $tool_dir pero no parece una instalación gestionada por SOKIX. Renómbrala o revísala antes de continuar."
        return 1
    fi
    stage=$(mktemp -d "$TOOLS_DIR/.${tool_name}.XXXXXX") || return 1
    log_info "Clonando repositorio oficial configurado para $tool_name..."
    if ! git clone --depth 1 -- "$repo_url" "$stage/repo"; then
        rm -rf -- "$stage"; log_error "Falló git clone: $repo_url"; return 1
    fi
    if [[ ! -d "$stage/repo/.git" ]]; then rm -rf -- "$stage"; log_error "El repositorio clonado no es válido"; return 1; fi
    # Nunca ejecutar setup.py ni instalar dependencias globales como root.
    if [[ -f "$stage/repo/requirements.txt" ]]; then
        if ! command -v python3 >/dev/null 2>&1; then rm -rf -- "$stage"; log_error "Falta python3"; return 1; fi
        if ! python3 -m venv "$stage/repo/.venv"; then
            rm -rf -- "$stage"; log_error "No se pudo crear el entorno virtual. En Kali instala python3-venv."; return 1
        fi
        if [[ -s "$stage/repo/requirements.txt" ]]; then
            printf '\033[38;2;0;245;255m[ENV][0m Creando entorno Python aislado para %s...\n' "$tool_name"
            if ! "$stage/repo/.venv/bin/python" -m pip install --disable-pip-version-check --upgrade pip; then
                rm -rf -- "$stage"; log_error "No se pudo preparar pip dentro del entorno virtual de $tool_name"; return 1
            fi
            if ! "$stage/repo/.venv/bin/python" -m pip install --disable-pip-version-check -r "$stage/repo/requirements.txt"; then
                rm -rf -- "$stage"; log_error "Falló la instalación aislada de dependencias de $tool_name. No se modificó el Python del sistema."; return 1
            fi
        else
            log_info "$tool_name no contiene requirements.txt; no se instalarán paquetes Python por suposición."
        fi
    fi
    # Señala scripts heredados de instalación Python 2; nunca se ejecutan automáticamente.
    if find "$stage/repo" -maxdepth 2 -type f -iname 'install.sh' -print -quit | grep -q .; then
        log_warning "El repositorio incluye Install.sh. SOKIX no lo ejecutará automáticamente: algunos scripts antiguos usan pip2/rutas obsoletas."
    fi
    printf '%s\n' "$repo_url" > "$stage/repo/.sokix-source"
    : > "$stage/repo/.sokix-installed"
    if ! mv -- "$stage/repo" "$tool_dir"; then rm -rf -- "$stage"; log_error "No se pudo guardar la instalación"; return 1; fi
    rm -rf -- "$stage"
    log_success "$tool_name descargada y preparada. Revisa el README antes de ejecutarla."
    return 0
}

# Manejo del menú principal: no descarga ni ejecuta herramientas sin confirmación.
handle_tool_selection() {
    local choice=${1:-} tool_name="" action=""
    case "$choice" in
        1) tool_name="AllHackingTools" ;;
        2) tool_name="NetSoc_OSINT" ;;
        3) tool_name="OSINT-Framework" ;;
        4) tool_name="ReconDog" ;;
        5) tool_name="OSINT-Tool" ;;
        6) tool_name="OSINT-Toolkit" ;;
        7) tool_name="XSS-Tools" ;;
        8) tool_name="D-TECT" ;;
        9) tool_name="XSStrike" ;;
        10) tool_name="SQLMap" ;;
        11) tool_name="WPScan" ;;
        12) tool_name="Burp-Suite" ;;
        13) tool_name="OWASP-ZAP" ;;
        14) tool_name="BeEF" ;;
        15) tool_name="Metasploit-Framework" ;;
        16) tool_name="Empire" ;;
        17) tool_name="Cobalt-Strike" ;;
        18) tool_name="Mimikatz" ;;
        19) tool_name="CrackMapExec" ;;
        20) tool_name="Impacket" ;;
        21) tool_name="Nmap" ;;
        22) tool_name="Wireshark" ;;
        23) tool_name="Bettercap" ;;
        24) tool_name="Nessus" ;;
        25) tool_name="Burp-Suite" ;;
        26) tool_name="OWASP-ZAP" ;;
        27) tool_name="SQLMap" ;;
        28) tool_name="XSStrike" ;;
        29) tool_name="Vega" ;;
        30) tool_name="Nikto" ;;
        31) tool_name="Skipfish" ;;
        32) tool_name="Wfuzz" ;;
        33) tool_name="Maltego" ;;
        34) tool_name="Recon-ng" ;;
        35) tool_name="SpiderFoot" ;;
        36) tool_name="Amass" ;;
        37) tool_name="Sublist3r" ;;
        38) tool_name="Fierce" ;;
        39) tool_name="Subfinder" ;;
        40) tool_name="Dirsearch" ;;
        41) tool_name="Nuclei" ;;
        42) tool_name="Gobuster" ;;
        43) tool_name="Social-Engineering-Toolkit" ;;
        44) tool_name="GoPhish" ;;
        45) tool_name="Zphisher" ;;
        46) tool_name="Aircrack-ng" ;;
        47) tool_name="Hashcat" ;;
        48) tool_name="John-the-Ripper" ;;
        49) tool_name="Hydra" ;;
        50) tool_name="Cewl" ;;
        51) tool_name="ProxyChains" ;;
        52) tool_name="GoReverseShell" ;;
        53) tool_name="T50" ;;
        54) tool_name="Nginx-Helper" ;;
        55) tool_name="Crackstation" ;;
        59) tool_name="Game-Hacking" ;;
        60) tool_name="Cheat-Engine" ;;
        61) tool_name="Squalr" ;;
        62) tool_name="MungPlex" ;;
        63) tool_name="GTA-SA-Cheats" ;;
        64) tool_name="Payback2-CHEATus" ;;
        65) tool_name="SimCity-Cheat" ;;
        66) tool_name="Warzone2100" ;;
        67) tool_name="StellarRealms" ;;
        68) tool_name="Hacking-Online-Games" ;;
        69) tool_name="Reloaded-Memory-SigScan" ;;
        70) tool_name="GH-D3D11-Hook" ;;
        71) tool_name="WhatsAppHacking" ;;
        72) tool_name="Android-Studio" ;;
        73) tool_name="APKTool" ;;
        74) tool_name="Dex2Jar" ;;
        56)
            mkdir -p "$CONFIG_DIR"
            [[ -f "$CONFIG_FILE" ]] || create_default_config
            printf 'Archivo de configuración: %s\
' "$CONFIG_FILE"
            read -r -p "Pulsa Intro para continuar..." _
            return 0 ;;
        57)
            log_warning "Actualizaciones automáticas desactivadas; actualiza cada repositorio manualmente."
            read -r -p "Pulsa Intro para continuar..." _
            return 0 ;;
        58|q|Q|salir|exit) echo "Saliendo de SOKIX."; exit 0 ;;
        *) log_warning "Opción no válida: $choice"; read -r -p "Pulsa Intro para continuar..." _; return 0 ;;
    esac
    printf '\
Herramienta seleccionada: %s\
1) Instalar/descargar\
2) Ejecutar si está instalada\
3) Volver\
' "$tool_name"
    read -r -p "Elige una acción: " action
    case "$action" in
        1) install_tool "$tool_name" || log_warning "No se pudo instalar $tool_name." ;;
        2) if is_tool_installed "$tool_name"; then run_tool "$tool_name" || log_warning "La ejecución terminó con errores."; else log_warning "$tool_name no está instalada."; fi ;;
        3) return 0 ;;
        *) log_warning "Acción no válida." ;;
    esac
    read -r -p "Pulsa Intro para volver al menú..." _
}

# Función principal
main() {
    local choice
    startup_animation
    mkdir -p "$CONFIG_DIR" "$TOOLS_DIR" "$MODULES_DIR" "$SCRIPTS_DIR" "$CACHE_DIR" "$TEMP_DIR" "$BACKUP_DIR" "$REPORTS_DIR" "$(dirname "$LOG_FILE")" || { log_error "No se pudieron crear los directorios de SOKIX"; exit 1; }
    [[ -f "$CONFIG_FILE" ]] || create_default_config
    bootstrap_dependencies || log_warning "La preparación base no se completó; SOKIX seguirá con funciones limitadas."
    while true; do
        show_banner
        show_main_menu
        if ! read -r -p "Selecciona una opción (1-74; 56 configuración, 57 actualizaciones, 58 salir): " choice; then
            printf '\nSaliendo de SOKIX.\n'
            break
        fi
        handle_tool_selection "$choice"
    done
}

# Iniciar el toolkit
main
