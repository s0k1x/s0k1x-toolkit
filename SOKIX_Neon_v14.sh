#!/usr/bin/env bash
# SOKIX NEON v14.0 — consola RGB y gestor de herramientas para auditoría autorizada
# No ejecuta código de repositorios descargados automáticamente.
set -uo pipefail
IFS=$'\n\t'
VERSION="14.0.0"
APP="SOKIX NEON"
ROOT="${SOKIX_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/sokix}"
TOOLS_DIR="$ROOT/tools"; LOG_DIR="$ROOT/logs"; CACHE_DIR="$ROOT/cache"; REPORT_DIR="$ROOT/reports"
LOG_FILE="$LOG_DIR/sokix.log"
mkdir -p "$TOOLS_DIR" "$LOG_DIR" "$CACHE_DIR" "$REPORT_DIR" 2>/dev/null || { echo "No puedo crear $ROOT" >&2; exit 1; }

# Truecolor RGB con degradación automática para terminales simples.
if [[ -t 1 && -n "${TERM:-}" && "${TERM:-dumb}" != dumb ]]; then
  C_RESET=$'\033[0m'; C_DIM=$'\033[2m'; C_BOLD=$'\033[1m'
  C_RED=$'\033[38;2;255;70;110m'; C_ORANGE=$'\033[38;2;255;145;70m'
  C_CYAN=$'\033[38;2;0;240;255m'; C_BLUE=$'\033[38;2;65;130;255m'
  C_PURPLE=$'\033[38;2;175;75;255m'; C_PINK=$'\033[38;2;255;50;210m'
  C_GREEN=$'\033[38;2;80;255;160m'; C_WHITE=$'\033[38;2;235;242;255m'
else
  C_RESET=''; C_DIM=''; C_BOLD=''; C_RED=''; C_ORANGE=''; C_CYAN=''; C_BLUE=''; C_PURPLE=''; C_PINK=''; C_GREEN=''; C_WHITE=''
fi

log() { printf '[%s] %s\n' "$(date '+%F %T')" "$*" >> "$LOG_FILE"; }
ok() { printf '%s  ✔ %s%s\n' "$C_GREEN" "$*" "$C_RESET"; log "OK $*"; }
warn() { printf '%s  ! %s%s\n' "$C_ORANGE" "$*" "$C_RESET"; log "WARN $*"; }
err() { printf '%s  ✖ %s%s\n' "$C_RED" "$*" "$C_RESET" >&2; log "ERROR $*"; }
info() { printf '%s  › %s%s\n' "$C_CYAN" "$*" "$C_RESET"; }
press_enter() { printf '\n%sPulsa Intro para continuar...%s' "$C_DIM" "$C_RESET"; IFS= read -r _ || true; }

# Las 71 entradas originales permanecen numeradas igual; 56 configuración, 57 actualización, 58 salida.
declare -A TOOLS=(
  [1]=AllHackingTools
  [2]=NetSoc_OSINT
  [3]=OSINT-Framework
  [4]=ReconDog
  [5]=OSINT-Tool
  [6]=OSINT-Toolkit
  [7]=XSS-Tools
  [8]=D-TECT
  [9]=XSStrike
  [10]=SQLMap
  [11]=WPScan
  [12]=Burp-Suite
  [13]=OWASP-ZAP
  [14]=BeEF
  [15]=Metasploit-Framework
  [16]=Empire
  [17]=Cobalt-Strike
  [18]=Mimikatz
  [19]=CrackMapExec
  [20]=Impacket
  [21]=Nmap
  [22]=Wireshark
  [23]=Bettercap
  [24]=Nessus
  [25]=Burp-Suite
  [26]=OWASP-ZAP
  [27]=SQLMap
  [28]=XSStrike
  [29]=Vega
  [30]=Nikto
  [31]=Skipfish
  [32]=Wfuzz
  [33]=Maltego
  [34]=Recon-ng
  [35]=SpiderFoot
  [36]=Amass
  [37]=Sublist3r
  [38]=Fierce
  [39]=Subfinder
  [40]=Dirsearch
  [41]=Nuclei
  [42]=Gobuster
  [43]=Social-Engineering-Toolkit
  [44]=GoPhish
  [45]=Zphisher
  [46]=Aircrack-ng
  [47]=Hashcat
  [48]=John-the-Ripper
  [49]=Hydra
  [50]=Cewl
  [51]=ProxyChains
  [52]=GoReverseShell
  [53]=T50
  [54]=Nginx-Helper
  [55]=Crackstation
  [59]=Game-Hacking
  [60]=Cheat-Engine
  [61]=Squalr
  [62]=MungPlex
  [63]=GTA-SA-Cheats
  [64]=Payback2-CHEATus
  [65]=SimCity-Cheat
  [66]=Warzone2100
  [67]=StellarRealms
  [68]=Hacking-Online-Games
  [69]=Reloaded-Memory-SigScan
  [70]=GH-D3D11-Hook
  [71]=WhatsAppHacking
  [72]=Android-Studio
  [73]=APKTool
  [74]=Dex2Jar
)
declare -A REPOS=(
  [AllHackingTools]=https://github.com/mishakorzik/AllHackingTools
  [NetSoc_OSINT]=https://github.com/XDeadHackerX/NetSoc_OSINT
  [Recursos-Hacking-Etico]=https://github.com/zamarrowski/recursos-hacking-etico
  [OSINT-Framework]=https://github.com/lockfale/osint-framework
  [ReconDog]=https://github.com/UltimateHackers/ReconDog
  [OSINT-Tool]=https://github.com/saikrishna321/OSINT-Tool
  [XSS-Tools]=https://github.com/faizann24/XssPy
  [D-TECT]=https://github.com/shawarkhanethicalhacker/D-TECT
  [TermuxHackingTools]=https://github.com/Techzindia/TermuxHackingTools
  [OSINT-Toolkit]=https://github.com/saikrishna321/OSINT-Toolkit
  [Hacking-Tools]=https://github.com/topics/hacking-tools
  [Phishing-Toolkit]=https://github.com/Techzindia/Phishing-Toolkit
  [Social-Engineering-Toolkit]=https://github.com/trustedsec/social-engineer-toolkit
  [Recon-ng]=https://github.com/lanmaster53/recon-ng
  [SpiderFoot]=https://github.com/smicallef/spiderfoot
  [Amass]=https://github.com/owasp-amass/amass
  [Sublist3r]=https://github.com/aboul3la/Sublist3r
  [Nmap]=https://github.com/nmap/nmap
  [Gobuster]=https://github.com/OJ/gobuster
  [Nikto]=https://github.com/sullo/nikto
  [Dirsearch]=https://github.com/maurosoria/dirsearch
  [Wfuzz]=https://github.com/xmendez/wfuzz
  [XSStrike]=https://github.com/s0md3v/XSStrike
  [SQLMap]=https://github.com/sqlmapproject/sqlmap
  [WPScan]=https://github.com/wpscanteam/wpscan
  [Burp-Suite]=https://github.com/snoopysecurity/burp-suite-community-edition
  [OWASP-ZAP]=https://github.com/zaproxy/zaproxy
  [BeEF]=https://github.com/beefproject/beef
  [Cewl]=https://github.com/digininja/CeWL
  [Hashcat]=https://github.com/hashcat/hashcat
  [John-the-Ripper]=https://github.com/openwall/john
  [Mimikatz]=https://github.com/gentilkiwi/mimikatz
  [Empire]=https://github.com/BC-SECURITY/Empire
  [BloodHound]=https://github.com/BloodHoundAD/BloodHound
  [CrackMapExec]=https://github.com/Porchetta-Industries/CrackMapExec
  [Responder]=https://github.com/lgandx/Responder
  [Impacket]=https://github.com/SecureAuthCorp/impacket
  [Kali-Linux]=https://github.com/OffensiveSecurity/kali-linux
  [Metasploit-Framework]=https://github.com/rapid7/metasploit-framework
  [Aircrack-ng]=https://github.com/aircrack-ng/aircrack-ng
  [Hydra]=https://github.com/vanhauser-thc/thc-hydra
  [Wireshark]=https://github.com/wireshark/wireshark
  [Tcpdump]=https://github.com/the-tcpdump-group/tcpdump
  [Scapy]=https://github.com/secdev/scapy
  [Bettercap]=https://github.com/bettercap/bettercap
  [Ettercap]=https://github.com/Ettercap/ettercap
  [Nessus]=https://github.com/tenable/nessus
  [OpenVAS]=https://github.com/greenbone/openvas
  [GVM]=https://github.com/greenbone/gvm
  [Nuclei]=https://github.com/projectdiscovery/nuclei
  [Subfinder]=https://github.com/projectdiscovery/subfinder
  [Naabu]=https://github.com/projectdiscovery/naabu
  [Dnsx]=https://github.com/projectdiscovery/dnsx
  [Httpx]=https://github.com/projectdiscovery/httpx
  [Proxify]=https://github.com/projectdiscovery/proxify
  [Notify]=https://github.com/projectdiscovery/notify
  [Chaos]=https://github.com/projectdiscovery/chaos-client
  [Katana]=https://github.com/projectdiscovery/katana
  [Interactsh]=https://github.com/projectdiscovery/interactsh
  [Cloudlist]=https://github.com/projectdiscovery/cloudlist
  [Uncover]=https://github.com/projectdiscovery/uncover
  [Pdtm]=https://github.com/projectdiscovery/pdtm
  [Commix]=https://github.com/commixproject/commix
  [WPSeku]=https://github.com/m4ll0k/WPSeku
  [Joomscan]=https://github.com/rezasp/joomscan
  [Wapiti]=https://github.com/wapiti-scanner/wapiti
  [W3af]=https://github.com/andresriancho/w3af
  [Arachni]=https://github.com/Arachni/arachni
  [Golismero]=https://github.com/golismero/golismero
  [Vega]=https://github.com/subgraph/Vega
  [Skipfish]=https://github.com/spinkham/skipfish
  [Joomla-Scanner]=https://github.com/drego85/Joomla-Scanner
  [Drupal-Scan]=https://github.com/r3dxpl0it/Drupal-Scan
  [Wordpress-Scanner]=https://github.com/wpscanteam/wpscan
  [Joomla-Vulnerability-Scanner]=https://github.com/rezasp/joomscan
  [Drupal-Vulnerability-Scanner]=https://github.com/droope/droopescan
  [Metasploit]=https://github.com/rapid7/metasploit-framework
  [Cobalt-Strike]=https://github.com/Fortra/Cobalt-Strike
  [PowerSploit]=https://github.com/PowerShellMafia/PowerSploit
  [PrivExchange]=https://github.com/dirkjanm/PrivExchange
  [Rubeus]=https://github.com/GhostPack/Rubeus
  [SharpHound]=https://github.com/BloodHoundAD/SharpHound
  [Seatbelt]=https://github.com/GhostPack/Seatbelt
  [SharpUp]=https://github.com/GhostPack/SharpUp
  [SharpView]=https://github.com/tevora-threat/SharpView
  [SharpHound3]=https://github.com/BloodHoundAD/SharpHound3
  [SharpDPAPI]=https://github.com/GhostPack/SharpDPAPI
  [SharpDump]=https://github.com/GhostPack/SharpDump
  [SharpWMI]=https://github.com/GhostPack/SharpWMI
  [SharpRoast]=https://github.com/GhostPack/SharpRoast
  [SharpSploit]=https://github.com/cobbr/SharpSploit
  [SharpHound2]=https://github.com/BloodHoundAD/SharpHound2
  [SharpHound4]=https://github.com/BloodHoundAD/SharpHound4
  [SharpHound5]=https://github.com/BloodHoundAD/SharpHound5
  [SharpHound6]=https://github.com/BloodHoundAD/SharpHound6
  [SharpHound7]=https://github.com/BloodHoundAD/SharpHound7
  [SharpHound8]=https://github.com/BloodHoundAD/SharpHound8
  [SharpHound9]=https://github.com/BloodHoundAD/SharpHound9
  [SharpHound10]=https://github.com/BloodHoundAD/SharpHound10
  [Masscan]=https://github.com/robertdavidgraham/masscan
  [Zmap]=https://github.com/zmap/zmap
  [Netdiscover]=https://github.com/netdiscover-scanner/netdiscover
  [Netcat]=https://github.com/diegocr/netcat
  [Hping]=https://github.com/antirez/hping
  [Tshark]=https://github.com/wireshark/wireshark
  [Netcat-traditional]=https://github.com/diegocr/netcat
  [Netcat-openbsd]=https://github.com/diegocr/netcat
  [Netcat-gnu]=https://github.com/diegocr/netcat
  [Netcat-bsd]=https://github.com/diegocr/netcat
  [Netcat-debian]=https://github.com/diegocr/netcat
  [Netcat-ubuntu]=https://github.com/diegocr/netcat
  [Netcat-kali]=https://github.com/diegocr/netcat
  [Game-Hacking]=https://github.com/dsasmblr/game-hacking
  [Game-Hacking-1]=https://github.com/Mehardeep/game-hacking-1
  [Cheat-Engine]=https://github.com/dsasmblr/cheat-engine
  [Squalr]=https://github.com/Squalr/Squalr
  [MungPlex]=https://github.com/CosmoCortney/MungPlex
  [GTA-SA-Cheats]=https://github.com/Edward-P-Astbury/gta_sa_cheats
  [Payback2-CHEATus]=https://github.com/ABJ4403/Payback2_CHEATus
  [SimCity-Cheat]=https://github.com/souforte/SimCity-Cheat
  [Warzone2100]=https://github.com/Warzone2100/warzone2100
  [StellarRealms]=https://github.com/nagten/StellarRealms
  [Hacking-Online-Games]=https://github.com/dsasmblr/hacking-online-games
  [Reloaded-Memory-SigScan]=https://github.com/Reloaded-Project/Reloaded.Memory.SigScan
  [GH-D3D11-Hook]=https://github.com/guided-hacking/GH_D3D11_Hook
  [Game-Hacks]=https://github.com/topics/game-hacks
  [Game-Hack-Menu]=https://github.com/topics/game-hack-menu
  [Game-Tweaks]=https://github.com/topics/game-tweaks
  [GameGuardian]=https://github.com/GameGuardian/GameGuardian
  [GameCIH]=https://github.com/GameCIH/GameCIH
  [GameKiller]=https://github.com/GameKiller/GameKiller
  [GameGuard]=https://github.com/GameGuard/GameGuard
  [GameHack]=https://github.com/GameHack/GameHack
  [GameTool]=https://github.com/GameTool/GameTool
  [GameMaster]=https://github.com/GameMaster/GameMaster
  [GameWarden]=https://github.com/GameWarden/GameWarden
  [WhatsAppHacking]=https://github.com/WhatsAppHacking/WhatsAppHacking
  [Android-Studio]=https://github.com/android/studio
  [APKTool]=https://github.com/iBotPeaches/Apktool
  [Dex2Jar]=https://github.com/pxb1988/dex2jar
  [Frida]=https://github.com/frida/frida
  [Objection]=https://github.com/sensepost/objection
  [MobSF]=https://github.com/MobSF/Mobile-Security-Framework-MobSF
  [JADX]=https://github.com/skylot/jadx
  [Ghidra]=https://github.com/NationalSecurityAgency/ghidra
  [Radare2]=https://github.com/radareorg/radare2
  [APK-MITM]=https://github.com/shroudedcode/apk-mitm
  [APKLeaks]=https://github.com/dwisiswant0/apkleaks
  [APK-Downloader]=https://github.com/APK-Downloader/APK-Downloader
  [Android-Tools]=https://github.com/android/tools
  [Android-SDK]=https://github.com/android/sdk
  [Android-NDK]=https://github.com/android/ndk
  [Android-Platform]=https://github.com/android/platform
  [Android-Framework]=https://github.com/android/framework
  [Android-System]=https://github.com/android/system
  [Android-Kernel]=https://github.com/android/kernel
  [GoPhish]=https://github.com/gophish/gophish
  [Fierce]=https://github.com/mschwager/fierce
  [Sqlninja]=https://github.com/sqlninja/sqlninja
  [Zphisher]=https://github.com/htr-tech/zphisher
  [Maltego]=https://github.com/paterva/maltego
  [Osmedeus]=https://github.com/j3ssie/Osmedeus
  [Red-Team-Attack-Lab]=https://github.com/infosecn1nja/Red-Teaming-Toolkit
  [Mudge-Password-Tools]=https://github.com/mudgen/
  [T50]=https://github.com/s0lst1c3/t50
  [Nginx-Helper]=https://github.com/rbenv/nginx_helper
  [Crackstation]=https://github.com/crackstation/
  [ProxyChains]=https://github.com/haad/proxychains
  [GoReverseShell]=https://github.com/danielmiessler/GoReverseShell
)

# Instalación base del sistema: solo paquetes de infraestructura, no explota ni clona 71 proyectos.
BASE_PACKAGES=(git curl wget ca-certificates python3 python3-venv python3-pip pipx ruby perl default-jre-headless build-essential make unzip jq)
apt_cmd() { if (( EUID == 0 )); then apt-get "$@"; elif command -v sudo >/dev/null 2>&1; then sudo apt-get "$@"; else err 'Se necesita root o sudo para APT.'; return 1; fi; }
command_exists() { command -v "$1" >/dev/null 2>&1; }

term_width() { local w; w=$(tput cols 2>/dev/null || echo 80); (( w > 110 )) && w=110; (( w < 60 )) && w=60; echo "$w"; }
line() { local w i; w=$(term_width); printf '%s' "$C_PURPLE"; for ((i=0;i<w;i++)); do printf '─'; done; printf '%s\n' "$C_RESET"; }
center() { local text="$1" w; w=$(term_width); printf '%*s%s\n' "$(( (w + ${#text}) / 2 ))" '' "$text"; }
rgb() { local r=$1 g=$2 b=$3; if [[ -t 1 && -n "${TERM:-}" && "${TERM:-dumb}" != dumb ]]; then printf '\033[38;2;%d;%d;%dm' "$r" "$g" "$b"; fi; }
progress() {
  local label="$1" pct="$2" width=34 filled i phase=$(( $(date +%S) % 6 )); (( pct<0 )) && pct=0; (( pct>100 )) && pct=100
  filled=$((pct*width/100)); printf '\r  '
  for ((i=0;i<width;i++)); do
    if (( i<filled )); then case $(( (i+phase)%4 )) in 0) printf '%s▰' "$(rgb 0 245 255)";; 1) printf '%s▰' "$(rgb 80 130 255)";; 2) printf '%s▰' "$(rgb 190 65 255)";; 3) printf '%s▰' "$(rgb 255 55 190)";; esac
    else printf '%s·' "$C_DIM"; fi
  done
  printf '%s] %3d%%  %s%s' "$C_RESET" "$pct" "$label" "$C_RESET"
}

show_splash() {
  [[ -t 1 ]] && printf '\033[2J\033[H'
  printf '%s' "$(rgb 0 245 255)"; printf '  ███████╗ ██████╗ ██╗  ██╗██╗██╗  ██╗\n'
  printf '%s' "$(rgb 65 130 255)"; printf '  ██╔════╝██╔═══██╗██║ ██╔╝██║╚██╗██╔╝\n'
  printf '%s' "$(rgb 150 75 255)"; printf '  ███████╗██║   ██║█████╔╝ ██║╚███╔╝\n'
  printf '%s' "$(rgb 220 55 240)"; printf '  ╚════██║██║   ██║██╔═██╗ ██║ ██╔██╗\n'
  printf '%s' "$(rgb 255 55 190)"; printf '  ███████║╚██████╔╝██║  ██╗██║██╔╝ ██╗\n'
  printf '%s' "$(rgb 255 125 80)"; printf '  ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝\n'
  printf '%s' "$C_RESET"
  printf '%s' "$(rgb 255 55 210)"; center 'S O K I X   /   N E O N   C Y B E R   C O N S O L E'; printf '%s' "$C_RESET"
  center "SECURITY WORKBENCH  v$VERSION  ·  RGB EDITION"
  line
  printf '  %sHOST%s %-18s %sOS%s %-24s %sTIME%s %s\n' "$C_CYAN" "$C_RESET" "$(hostname 2>/dev/null || echo unknown)" "$C_CYAN" "$C_RESET" "$(. /etc/os-release 2>/dev/null; echo "${PRETTY_NAME:-Linux}")" "$C_CYAN" "$C_RESET" "$(date '+%H:%M:%S %d/%m/%Y')"
  printf '  %sWORKSPACE%s %s\n' "$C_CYAN" "$C_RESET" "$ROOT"
  line
}

loading_intro() {
  local i
  show_splash
  info 'INICIALIZANDO MÓDULOS · DIAGNÓSTICO · CATÁLOGO · LANZADOR'
  for i in 10 25 40 55 70 85 100; do progress 'Preparando consola RGB' "$i"; sleep 0.035; done
  printf '\n\n'
}

bootstrap() {
  local missing=() p i total ans
  loading_intro
  info 'FASE 01/04 · Plataforma y permisos'
  if [[ -r /etc/os-release ]]; then . /etc/os-release; else warn 'No se encuentra /etc/os-release'; fi
  ok "Bash ${BASH_VERSION%%(*} · $(uname -m) · kernel $(uname -r)"
  info 'FASE 02/04 · Dependencias base'
  for p in "${BASE_PACKAGES[@]}"; do
    if ! dpkg-query -W -f='${Status}' "$p" 2>/dev/null | grep -q 'install ok installed'; then missing+=("$p"); fi
  done
  printf '\n%s¿Quieres preparar el entorno e instalar TODAS las dependencias base que falten? [S/n]: %s' "$C_PINK" "$C_RESET"
  IFS= read -r ans || ans=n
  if [[ "$ans" =~ ^([sS]|[sS][iI]|[yY]|[yY][eE][sS])?$ ]]; then
    if ((${#missing[@]})); then
      info 'Actualizando índices de paquetes…'
      if apt_cmd update >> "$LOG_FILE" 2>&1; then
        total=${#missing[@]}; i=0
        for p in "${missing[@]}"; do
          i=$((i+1)); progress "Dependencia $i/$total: $p" "$((i*100/total))"
          if DEBIAN_FRONTEND=noninteractive apt_cmd install -y -- "$p" >> "$LOG_FILE" 2>&1; then printf '\n'; ok "$p instalado"; else printf '\n'; warn "No se pudo instalar $p; consulta $LOG_FILE"; fi
        done
      else warn 'APT no pudo actualizar índices; comprueba red y repositorios.'; fi
    else ok 'Todas las dependencias base ya están instaladas.'; fi
    printf '\n%s¿Descargar ahora todos los repositorios válidos del catálogo? Puede tardar bastante. [s/N]: %s' "$C_ORANGE" "$C_RESET"
    IFS= read -r ans || ans=n
    if [[ "$ans" =~ ^([sS]|[sS][iI])$ ]]; then install_all_catalog; fi
  else warn 'Preparación aplazada; puedes hacerlo más tarde desde [I] o [D].'; fi
  info 'FASE 04/04 · Verificación rápida'
  for p in git python3 curl; do if command_exists "$p"; then ok "$p disponible"; else warn "$p no está disponible"; fi; done
  if command_exists curl && curl -fsSI --connect-timeout 3 https://github.com >/dev/null 2>&1; then ok 'Conectividad HTTPS con GitHub'; else warn 'GitHub no responde desde esta conexión.'; fi
  df -h "$ROOT" 2>/dev/null | awk 'NR==2 {printf "  Espacio libre: %s de %s\n",$4,$2}'
  printf '\n%sInicio listo. Los repositorios descargados NO se ejecutan sin confirmación explícita.%s\n' "$C_GREEN" "$C_RESET"
  press_enter
}

# Catálogo organizado por áreas. Se mantienen las 71 entradas originales y su numeración.
declare -A CATEGORIES=(
  [1]="OSINT y reconocimiento"
  [2]="Seguridad de aplicaciones web"
  [3]="Pentesting y laboratorios"
  [4]="Redes y análisis de tráfico"
  [5]="Escáneres y enumeración"
  [6]="Auditoría de credenciales y utilidades"
  [7]="Juegos e investigación de memoria"
  [8]="Seguridad móvil y Android"
)
declare -A CATEGORY_RANGES=(
  [1]="1-6" [2]="7-14" [3]="15-20" [4]="21-24" [5]="29-42" [6]="43-55" [7]="59-70" [8]="71-74"
)

category_for_number() {
  local n=$1
  if (( n>=1 && n<=6 )); then echo 1
  elif (( n>=7 && n<=14 )); then echo 2
  elif (( n>=15 && n<=20 )); then echo 3
  elif (( n>=21 && n<=24 )); then echo 4
  elif (( n>=25 && n<=42 )); then echo 5
  elif (( n>=43 && n<=55 )); then echo 6
  elif (( n>=59 && n<=70 )); then echo 7
  elif (( n>=71 && n<=74 )); then echo 8
  else echo 0; fi
}

show_header() {
  [[ -t 1 ]] && printf '\033[2J\033[H'
  printf '%s' "$(rgb 0 245 255)"; printf '   ███████╗ ██████╗ ██╗  ██╗██╗██╗  ██╗\n'
  printf '%s' "$(rgb 65 130 255)"; printf '   ██╔════╝██╔═══██╗██║ ██╔╝██║╚██╗██╔╝\n'
  printf '%s' "$(rgb 150 75 255)"; printf '   ███████╗██║   ██║█████╔╝ ██║╚███╔╝\n'
  printf '%s' "$(rgb 220 55 240)"; printf '   ╚════██║██║   ██║██╔═██╗ ██║ ██╔██╗\n'
  printf '%s' "$(rgb 255 55 190)"; printf '   ███████║╚██████╔╝██║  ██╗██║██╔╝ ██╗\n'
  printf '%s' "$(rgb 255 125 80)"; printf '   ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝\n'
  printf '%s' "$C_RESET"
  printf '%s  S O K I X   N E O N   /   C Y B E R   O P S  %s%s\n' "$(rgb 255 50 210)" "$VERSION" "$C_RESET"
  printf '  %sRGB SECURITY WORKBENCH · AUTODETECT · TOOL LAUNCHER%s\n' "$C_DIM" "$C_RESET"
  line
  printf '  %sHOST%s %-16s %sKERNEL%s %-18s %sLOCAL%s %s  %sREPOS%s %s\n' "$C_CYAN" "$C_RESET" "$(hostname 2>/dev/null || echo unknown)" "$C_CYAN" "$C_RESET" "$(uname -r)" "$C_CYAN" "$C_RESET" "$(find "$TOOLS_DIR" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')" "$C_CYAN" "$C_RESET" "$(find "$TOOLS_DIR" -mindepth 2 -maxdepth 2 -type d -name .git 2>/dev/null | wc -l | tr -d ' ')"
  printf '  %s[56]%s Configuración   %s[57]%s Actualizar   %s[58/Q]%s Salir\n' "$C_PINK" "$C_RESET" "$C_PINK" "$C_RESET" "$C_RED" "$C_RESET"
  line
  printf '%s  CATEGORÍAS · ELIGE UNA TECLA%s\n' "$C_PURPLE" "$C_RESET"
  local c count n
  for c in 1 2 3 4 5 6 7 8; do
    count=0
    for n in $(seq 1 55) $(seq 59 74); do [[ "$(category_for_number "$n")" == "$c" ]] && [[ -n "${TOOLS[$n]:-}" ]] && count=$((count+1)); done
    printf '  %s[%s]%s %-40s %s%2d herramientas%s\n' "$C_CYAN" "$(printf '%s' "$c" | tr '12345678' 'OWPNECGM')" "$C_RESET" "${CATEGORIES[$c]}" "$C_DIM" "$count" "$C_RESET"
  done
  line
  printf '  %sATAJOS%s  [número] acciones · [O/W/P/N/E/C/G/M] categorías · [S] buscar\n' "$C_CYAN" "$C_RESET"
  printf '  %s[I] instalar por número · [A] instalar catálogo · [D] diagnóstico · [U] actualizar · [B] logs · [Q] salir%s\n' "$C_CYAN" "$C_RESET"
  printf '  %sEn acciones de herramienta encontrarás INSTALAR, EJECUTAR y LEER INSTRUCCIONES.%s\n' "$C_DIM" "$C_RESET"
}

show_category() {
  local c="$1" n name status found=0
  [[ -n "${CATEGORIES[$c]:-}" ]] || { warn 'Categoría no válida.'; return 1; }
  show_header
  printf '\n%s  %s%s\n' "$C_PINK" "${CATEGORIES[$c]}" "$C_RESET"; line
  for n in $(seq 1 55) $(seq 59 74); do
    [[ "$(category_for_number "$n")" == "$c" ]] || continue
    name=${TOOLS[$n]:-}; [[ -n "$name" ]] || continue
    found=1; status="${C_DIM}○ no detectada${C_RESET}"
    if [[ -d "$TOOLS_DIR/$name/.git" || -f "$TOOLS_DIR/$name/.sokix-installed" ]]; then status="${C_GREEN}● descargada${C_RESET}"
    elif command_for_tool "$name" >/dev/null 2>&1; then status="${C_CYAN}● sistema${C_RESET}"; fi
    printf '  %s%02d%s  %-32s %b\n' "$C_PINK" "$n" "$C_RESET" "$name" "$status"
  done
  (( found )) || warn 'Esta categoría no tiene entradas.'
  line
  printf 'Número para abrir · Intro para volver: '
  local choice; IFS= read -r choice || return 0
  [[ -n "$choice" ]] && show_tool_actions "$choice"
}

search_tools() {
  local query n name found=0 choice
  printf 'Buscar por nombre (ej. nmap, android, osint): '; IFS= read -r query || return 0
  [[ -n "$query" ]] || return 0
  printf '\n%sResultados para: %s%s\n' "$C_PINK" "$query" "$C_RESET"
  for n in $(seq 1 55) $(seq 59 74); do
    name=${TOOLS[$n]:-}; [[ -n "$name" ]] || continue
    if [[ "${name,,}" == *"${query,,}"* ]]; then printf '  %s%02d%s  %s\n' "$C_CYAN" "$n" "$C_RESET" "$name"; found=1; fi
  done
  if (( ! found )); then warn 'No hay coincidencias.'; return 0; fi
  printf '\nNúmero para abrir (Intro para volver): '; IFS= read -r choice || return 0
  [[ -n "$choice" ]] && show_tool_actions "$choice"
}

command_for_tool() {
  case "$1" in
    Nmap) command -v nmap;; SQLMap) command -v sqlmap;; Wireshark) command -v wireshark;; Aircrack-ng) command -v aircrack-ng;; Hashcat) command -v hashcat;; John-the-Ripper) command -v john;; Hydra) command -v hydra;; Nikto) command -v nikto;; Gobuster) command -v gobuster;; Impacket) command -v impacket-scripts || command -v impacket-GetNPUsers;; Metasploit-Framework) command -v msfconsole;; ProxyChains) command -v proxychains4 || command -v proxychains;; Cewl) command -v cewl;; APKTool) command -v apktool;; Dex2Jar) command -v d2j-dex2jar || command -v dex2jar;; WPScan) command -v wpscan;; Bettercap) command -v bettercap;; Nuclei) command -v nuclei;; Subfinder) command -v subfinder;; Amass) command -v amass;; Dirsearch) command -v dirsearch;; XSStrike) [[ -x "$TOOLS_DIR/XSStrike/venv/bin/python" ]] && printf '%s\n' "$TOOLS_DIR/XSStrike/venv/bin/python";; *) return 1;; esac
}

apt_package_for() {
  case "$1" in
    Nmap) echo nmap;; SQLMap) echo sqlmap;; Wireshark) echo wireshark;; Aircrack-ng) echo aircrack-ng;; Hashcat) echo hashcat;; John-the-Ripper) echo john;; Hydra) echo hydra;; Nikto) echo nikto;; Gobuster) echo gobuster;; Impacket) echo python3-impacket;; Metasploit-Framework) echo metasploit-framework;; ProxyChains) echo proxychains4;; Cewl) echo cewl;; APKTool) echo apktool;; Dex2Jar) echo dex2jar;; WPScan) echo wpscan;; Bettercap) echo bettercap;; Nuclei) echo nuclei;; Subfinder) echo subfinder;; Amass) echo amass;; Dirsearch) echo dirsearch;; *) return 1;; esac
}

install_all_catalog() {
  local n name url count=0 skipped=0 ans
  printf '\n%sINSTALACIÓN DEL CATÁLOGO%s\n' "$C_PINK" "$C_RESET"
  warn 'Se descargarán repositorios públicos que tengan URL configurada; no se ejecutarán instaladores de terceros automáticamente.'
  printf '¿Continuar? Es posible que ocupe bastante espacio y tarde. [s/N]: '; IFS= read -r ans || ans=n
  [[ "$ans" =~ ^([sS]|[sS][iI])$ ]] || { info 'Operación cancelada.'; return 0; }
  for n in $(seq 1 55) $(seq 59 74); do
    name=${TOOLS[$n]:-}; [[ -n "$name" ]] || continue
    url=${REPOS[$name]:-}
    if [[ -d "$TOOLS_DIR/$name/.git" || -f "$TOOLS_DIR/$name/.sokix-installed" ]] || command_for_tool "$name" >/dev/null 2>&1; then
      printf '%s[%02d/71] existente: %s%s\n' "$C_GREEN" "$((count+skipped+1))" "$name" "$C_RESET"; skipped=$((skipped+1)); continue
    fi
    if [[ -z "$url" || "$url" == *'/topics/'* || "$url" == *'/users/'* || "$url" == *'/orgs/'* || "$url" == https://github.com/*/ ]]; then
      printf '%s[%02d/71] omitida (URL no verificada): %s%s\n' "$C_ORANGE" "$((count+skipped+1))" "$name" "$C_RESET"; skipped=$((skipped+1)); continue
    fi
    # Instala por APT solo herramientas con paquete mapeado; evita clonar el mismo nombre sin necesidad.
    if pkg=$(apt_package_for "$name") && command_exists apt-get; then
      printf '%s[%02d/71] APT: %s%s\n' "$C_CYAN" "$((count+skipped+1))" "$name" "$C_RESET"
      if DEBIAN_FRONTEND=noninteractive apt_cmd install -y -- "$pkg" >> "$LOG_FILE" 2>&1; then count=$((count+1)); else warn "APT falló para $name"; skipped=$((skipped+1)); fi
      continue
    fi
    if ! command_exists git; then warn 'Git no está instalado; se detiene la descarga.'; break; fi
    printf '%s[%02d/71] Descargando: %s%s\n' "$C_CYAN" "$((count+skipped+1))" "$name" "$C_RESET"
    local stage
    stage=$(mktemp -d "$TOOLS_DIR/.stage.XXXXXX") || { skipped=$((skipped+1)); continue; }
    if git clone --depth 1 -- "$url" "$stage/repo" >> "$LOG_FILE" 2>&1; then
      printf '%s\n' "$url" > "$stage/repo/.sokix-source"
      : > "$stage/repo/.sokix-installed"
      if mv "$stage/repo" "$TOOLS_DIR/$name" 2>>"$LOG_FILE"; then count=$((count+1)); else warn "No se pudo guardar $name"; skipped=$((skipped+1)); fi
    else warn "No se pudo descargar $name (URL inaccesible o repositorio no disponible)"; skipped=$((skipped+1)); fi
    rm -rf -- "$stage"
  done
  printf '\n'; ok "Catálogo finalizado: $count instalado(s)/descargado(s), $skipped omitido(s)."
  info "Detalle de errores: $LOG_FILE"
}

install_tool() {
  local name="$1" url="${REPOS[$1]:-}" pkg dest stage ans
  [[ -n "$name" ]] || { err 'No se especificó herramienta'; return 2; }
  if pkg=$(apt_package_for "$name") && command_exists apt-get; then
    if command_for_tool "$name" >/dev/null 2>&1; then ok "$name ya está disponible en PATH."; return 0; fi
    printf '%sInstalar %s mediante APT? [S/n]: %s' "$C_ORANGE" "$pkg" "$C_RESET"; IFS= read -r ans || ans=n
    [[ "$ans" =~ ^([sS]|[sS][iI]|[yY]|[yY][eE][sS])?$ ]] || return 0
    apt_cmd update && DEBIAN_FRONTEND=noninteractive apt_cmd install -y -- "$pkg" && { ok "$name instalado vía APT"; return 0; }
    err "APT no pudo instalar $pkg. Revisa los repositorios de tu distribución."; return 1
  fi
  [[ -n "$url" ]] || { err "No hay URL configurada para $name; consulta la web oficial del proyecto."; return 1; }
  if [[ "$url" == *'/topics/'* || "$url" == *'/users/'* || "$url" == *'/orgs/'* || "$url" == https://github.com/*/ ]]; then err "La URL configurada para $name no es un repositorio clonable: $url"; return 1; fi
  if [[ "$name" == 'Cobalt-Strike' || "$name" == 'Nessus' || "$name" == 'Burp-Suite' || "$name" == 'Android-Studio' ]]; then warn "$name puede requerir descarga/licencia/instalador oficial; no se clona como repositorio genérico."; return 1; fi
  command_exists git || { err 'Falta Git. Ejecuta de nuevo el arranque y acepta instalar dependencias.'; return 1; }
  dest="$TOOLS_DIR/$name"
  if [[ -d "$dest/.git" || -f "$dest/.sokix-installed" ]]; then ok "$name ya está descargada en $dest"; return 0; fi
  if [[ -e "$dest" ]]; then err "Existe $dest pero no es una instalación gestionada por SOKIX; no la sobrescribo."; return 1; fi
  printf '%sVas a descargar código de terceros:\n  %s\nRevísalo antes de ejecutarlo. ¿Continuar? [s/N]: %s' "$C_ORANGE" "$url" "$C_RESET"
  IFS= read -r ans || ans=n; [[ "$ans" =~ ^([sS]|[sS][iI])$ ]] || { info 'Descarga cancelada.'; return 0; }
  stage=$(mktemp -d "$TOOLS_DIR/.stage.XXXXXX") || return 1
  if ! git clone --depth 1 -- "$url" "$stage/repo" >> "$LOG_FILE" 2>&1; then rm -rf -- "$stage"; err "Falló la descarga. Revisa el registro: $LOG_FILE"; return 1; fi
  # No ejecutar hooks de instalación ni instalar requirements de terceros de forma automática.
  # Se registra su presencia para que el usuario pueda revisar las dependencias primero.
  [[ -f "$stage/repo/requirements.txt" ]] && log "$name incluye requirements.txt; requiere revisión e instalación guiada."
  printf '%s\n' "$url" > "$stage/repo/.sokix-source"
  : > "$stage/repo/.sokix-installed"
  mv -- "$stage/repo" "$dest" || { rm -rf -- "$stage"; err 'No se pudo guardar la herramienta.'; return 1; }
  rm -rf -- "$stage"; ok "$name descargada. SOKIX no la ejecuta automáticamente."; return 0
}

launch_tool() {
  local name="$1" cmd="" dir="$TOOLS_DIR/$1" choice file candidate found=0
  if cmd=$(command_for_tool "$name" 2>/dev/null); then
    printf '\n%sHerramienta detectada en el sistema:%s %s\n' "$C_GREEN" "$C_RESET" "$cmd"
    case "$name" in
      XSStrike)
        local xs_script="$TOOLS_DIR/XSStrike/xsstrike.py"
        if [[ -f "$xs_script" ]]; then "$cmd" "$xs_script" --help; else warn 'No se encontró xsstrike.py en la instalación local.'; fi
        ;;
      Nmap|SQLMap|Nikto|Gobuster|Hydra|Hashcat|John-the-Ripper|Aircrack-ng|Cewl|ProxyChains|APKTool|Dex2Jar|WPScan|Nuclei|Subfinder|Amass|Dirsearch|Impacket|Metasploit-Framework|Bettercap)
        printf '%sSe iniciará en modo de ayuda/uso para evitar acciones contra objetivos sin especificar.%s\n' "$C_DIM" "$C_RESET"
        case "$name" in SQLMap) "$cmd" --help;; Metasploit-Framework) "$cmd" -h;; *) "$cmd" --help 2>&1 || "$cmd" -h 2>&1 || true;; esac
        ;;
      Wireshark) "$cmd" >/dev/null 2>&1 & info 'Wireshark iniciado en segundo plano.';;
      *) "$cmd" --help 2>&1 || "$cmd" -h 2>&1 || true;;
    esac
    log "LAUNCH system $name ($cmd)"
    return 0
  fi
  if [[ ! -d "$dir" ]]; then warn "$name no está instalado ni descargado. Usa la opción 1 para instalarlo."; return 1; fi
  printf '\n%sPROYECTO LOCAL%s: %s\n' "$C_PINK" "$C_RESET" "$dir"
  if [[ -f "$dir/README.md" ]]; then
    printf '\n%sResumen de instrucciones (README):%s\n' "$C_CYAN" "$C_RESET"
    sed -n '1,45p' "$dir/README.md"
  fi
  local candidates=()
  printf '\n%sPuntos de entrada detectados:%s\n' "$C_CYAN" "$C_RESET"
  for file in "$dir"/*.py "$dir"/*.sh "$dir"/*.pl "$dir"/*.rb "$dir"/*/main.py "$dir"/*/cli.py "$dir"/bin/*; do
    [[ -f "$file" && ( -x "$file" || "$file" == *.py || "$file" == *.sh || "$file" == *.pl || "$file" == *.rb ) ]] || continue
    # Nunca ejecutar instaladores, scripts de reparación o setup como entrypoint.
    local base_name="${file##*/}"; base_name="${base_name,,}"; case "$base_name" in install.sh|fix.sh|setup.sh|uninstall.sh|build.sh|configure) continue;; esac
    candidate="${file#"$dir"/}"
    [[ " ${candidates[*]} " == *" $candidate "* ]] && continue
    candidates+=("$candidate")
    printf '  %s\n' "$candidate"; found=1
  done
  if (( ! found )); then warn 'No se detectó un punto de entrada claro. Revisa el README y el proyecto manualmente.'; return 1; fi
  if ((${#candidates[@]} == 1)); then
    candidate="${candidates[0]}"
    info "Punto de entrada único detectado automáticamente: $candidate"
  else
    printf '\n%sIntroduce la ruta relativa del punto de entrada que quieres ejecutar (Intro cancela): %s' "$C_ORANGE" "$C_RESET"
    IFS= read -r candidate || return 1
    [[ -n "$candidate" ]] || { info 'Ejecución cancelada.'; return 0; }
    local valid=0 c; for c in "${candidates[@]}"; do [[ "$candidate" == "$c" ]] && valid=1; done
    (( valid )) || { err 'Elige una de las rutas mostradas.'; return 1; }
  fi
  [[ "$candidate" != /* && "$candidate" != *'..'* && -f "$dir/$candidate" ]] || { err 'Ruta no válida.'; return 1; }
  case "${candidate,,}" in install.sh|*/install.sh|fix.sh|*/fix.sh|setup.sh|*/setup.sh|uninstall.sh|*/uninstall.sh|build.sh|*/build.sh) err 'Los instaladores auxiliares no se ejecutan como herramienta principal.'; return 1;; esac
  printf '\n%sVas a ejecutar código del repositorio local:%s\n  %s\n' "$C_ORANGE" "$C_RESET" "$dir/$candidate"
  warn 'Ejecuta únicamente código que hayas revisado y en sistemas/laboratorios para los que tengas autorización.'
  printf '¿Confirmas la ejecución? [s/N]: '; IFS= read -r choice || choice=n
  [[ "$choice" =~ ^([sS]|[sS][iI])$ ]] || { info 'Ejecución cancelada.'; return 0; }
  case "$candidate" in *.py) command_exists python3 || { err 'Falta Python 3.'; return 1; }; (cd "$dir" && python3 "$candidate");; *.sh) (cd "$dir" && bash "$candidate");; *.pl) command_exists perl || return 1; (cd "$dir" && perl "$candidate");; *.rb) command_exists ruby || return 1; (cd "$dir" && ruby "$candidate");; *) (cd "$dir" && "./$candidate");; esac
  log "LAUNCH local $name/$candidate"
}

show_tool_actions() {
  local n name action
  n="${1:-}"
  if [[ -z "$n" ]]; then printf 'Número de herramienta (1–74): '; IFS= read -r n || return; fi
  case "$n" in
    56) printf '\nConfiguración: %s/config\nLogs: %s\nHerramientas: %s\n' "$ROOT" "$LOG_FILE" "$TOOLS_DIR"; press_enter; return;;
    57) update_repos; press_enter; return;;
    58|q|Q) exit 0;;
  esac
  [[ "$n" =~ ^[0-9]+$ ]] || { warn 'Número no válido.'; press_enter; return; }
  name=${TOOLS[$n]:-}
  [[ -n "$name" ]] || { warn 'Número no válido.'; press_enter; return; }
  while true; do
    printf '\n%s╭─ %02d · %s%s\n' "$C_PINK" "$n" "$name" "$C_RESET"
    printf '  %s[1]%s Instalar / descargar\n  %s[2]%s EJECUTAR / abrir herramienta\n  %s[3]%s Ver README e instrucciones\n  %s[4]%s Abrir carpeta en el gestor de archivos\n  %s[5]%s Volver\n' "$C_CYAN" "$C_RESET" "$C_GREEN" "$C_RESET" "$C_CYAN" "$C_RESET" "$C_CYAN" "$C_RESET" "$C_DIM" "$C_RESET"
    printf 'Acción: '; IFS= read -r action || return
    case "$action" in
      1) install_tool "$name";;
      2) launch_tool "$name"; press_enter;;
      3) if [[ -f "$TOOLS_DIR/$name/README.md" ]]; then less -FRX "$TOOLS_DIR/$name/README.md" 2>/dev/null || sed -n '1,180p' "$TOOLS_DIR/$name/README.md"; elif [[ -d "$TOOLS_DIR/$name" ]]; then warn 'No hay README.md; revisa la carpeta.'; else warn 'La herramienta aún no está descargada.'; fi; press_enter;;
      4) if [[ -d "$TOOLS_DIR/$name" ]]; then if command_exists xdg-open; then xdg-open "$TOOLS_DIR/$name" >/dev/null 2>&1 & elif command_exists thunar; then thunar "$TOOLS_DIR/$name" >/dev/null 2>&1 & else printf 'Carpeta: %s\n' "$TOOLS_DIR/$name"; fi; else warn 'La herramienta aún no está descargada.'; fi; press_enter;;
      5|q|Q|'') return;;
      *) warn 'Acción no válida.';;
    esac
  done
}

update_repos() {
  local d count=0
  info 'Actualizando solo repositorios Git gestionados por SOKIX…'
  for d in "$TOOLS_DIR"/*; do
    [[ -d "$d/.git" ]] || continue
    printf '  %s → ' "${d##*/}"
    if git -C "$d" pull --ff-only >> "$LOG_FILE" 2>&1; then printf '%sOK%s\n' "$C_GREEN" "$C_RESET"; else printf '%sNO ACTUALIZADO%s\n' "$C_ORANGE" "$C_RESET"; fi
    count=$((count+1))
  done
  ok "Revisión completada: $count repositorios. Consulta $LOG_FILE para detalles."
}

diagnostics() {
  show_splash
  printf '%sDIAGNÓSTICO DEL ENTORNO%s\n' "$C_PINK" "$C_RESET"; line
  for c in git curl wget python3 pipx ruby perl java gcc make jq; do if command_exists "$c"; then printf '  %s[ OK ]%s %-12s %s\n' "$C_GREEN" "$C_RESET" "$c" "$(command -v "$c")"; else printf '  %s[ -- ]%s %s\n' "$C_ORANGE" "$C_RESET" "$c"; fi; done
  printf '\n  OS: %s\n  Kernel: %s\n  Arquitectura: %s\n  Uptime: %s\n  Log: %s\n' "$(. /etc/os-release 2>/dev/null; echo "${PRETTY_NAME:-Linux}")" "$(uname -r)" "$(uname -m)" "$(uptime -p 2>/dev/null || echo N/D)" "$LOG_FILE"
  press_enter
}

backup_logs() { local dest="$REPORT_DIR/sokix-logs-$(date +%Y%m%d-%H%M%S).tar.gz"; if tar -czf "$dest" -C "$LOG_DIR" .; then ok "Logs guardados en $dest"; else err 'No se pudo crear el backup.'; fi; press_enter; }

main() {
  bootstrap
  while true; do
    show_header
    printf '\n%sNúmero de herramienta (1–74), categoría (O/W/P/N/E/C/G/M) o acción [S/D/I/A/U/B/Q]: %s' "$C_CYAN" "$C_RESET"
    local choice; IFS= read -r choice || break
    case "$choice" in
      o|O) show_category 1 ;; w|W) show_category 2 ;; p|P) show_category 3 ;; n|N) show_category 4 ;; e|E) show_category 5 ;; c|C) show_category 6 ;; g|G) show_category 7 ;; m|M) show_category 8 ;;
      i|I) show_tool_actions ;;
      a|A) install_all_catalog; press_enter;;
      s|S) search_tools ;;
      d|D) diagnostics ;;
      b|B) backup_logs ;;
      u|U) update_repos; press_enter ;;
      q|Q|salir|exit|58) break ;;
      56) printf '\nConfiguración: %s/config\nLogs: %s\nHerramientas: %s\n' "$ROOT" "$LOG_FILE" "$TOOLS_DIR"; press_enter ;;
      57) update_repos; press_enter ;;
      *) if [[ "$choice" =~ ^([1-9]|[1-4][0-9]|5[0-5]|5[9]|6[0-9]|7[0-4])$ ]]; then show_tool_actions "$choice"; else warn 'Opción no válida.'; sleep 0.35; fi ;;
    esac
  done
  printf '\n%sSOKIX cerrado. Registro: %s%s\n' "$C_CYAN" "$LOG_FILE" "$C_RESET"
}

main "$@"
