<div align="center">
<img src="assets/logo.png" width="180">

🛡️ SOKIX Toolkit v12

Professional Ethical Hacking Environment for Kali Linux

Una plataforma moderna para Pentesting, Red Team, OSINT, Análisis de Vulnerabilidades y Automatización desarrollada exclusivamente para Kali Linux.

<p>
</p>
<img src="assets/demo.gif" width="900">
</div>

⸻

⚡ ¿Qué es SOKIX?

SOKIX Toolkit reúne en un único entorno las herramientas más utilizadas durante una auditoría de seguridad, organizándolas mediante una arquitectura modular y una interfaz sencilla para reducir el tiempo de preparación y mejorar el flujo de trabajo.

Está orientado a:

* 👨‍💻 Pentesters
* 🔴 Equipos Red Team
* 🎓 Estudiantes de Ciberseguridad
* 🛡️ Auditores de Seguridad
* 🔬 Investigadores

⸻

✨ Características

	
🔍 OSINT	Inteligencia de fuentes abiertas
🌐 Web	Auditoría de aplicaciones web
📡 Network	Descubrimiento y análisis de redes
🔐 Passwords	Auditoría de credenciales
📱 Mobile	Seguridad Android
💾 Forensics	Análisis forense
📊 Reports	Informes automáticos
⚙️ Updates	Actualizaciones automáticas
📂 Workspace	Organización por proyectos
🧩 Modules	Sistema modular

⸻

🖥️ Vista General

                  ┌──────────────────────────────┐
                  │        SOKIX Toolkit         │
                  └──────────────┬───────────────┘
                                 │
        ┌───────────────┬────────┼────────┬───────────────┐
        │               │        │        │               │
      OSINT          WEB      NETWORK   MOBILE      FORENSICS
        │               │        │        │               │
        └───────────────┴────────┼────────┴───────────────┘
                                 │
                          REPORT GENERATOR
                                 │
                          HTML • JSON • TXT

⸻

📂 Estructura

SOKIX/
│
├── assets/
├── config/
├── docs/
├── logs/
├── modules/
│   ├── osint/
│   ├── web/
│   ├── network/
│   ├── passwords/
│   ├── mobile/
│   ├── forensics/
│   └── reporting/
│
├── reports/
├── tools/
├── install.sh
├── update.sh
└── sokix

⸻

🚀 Instalación

sudo apt update && sudo apt full-upgrade -y
git clone https://github.com/sokix/toolkit.git
cd toolkit
chmod +x install.sh
./install.sh

⸻

▶️ Uso

# Iniciar
./sokix
# Ayuda
./sokix --help
# Actualizar
./sokix --update
# Diagnóstico
./sokix --diagnostic
# Informe
./sokix --report

⸻

📊 Información

Característica	Estado
Plataforma	✅ Kali Linux
Arquitectura	✅ Modular
Actualizaciones	✅ Automáticas
Informes	✅ HTML / JSON
Configuración	✅ Centralizada
Plugins	🚧 En desarrollo

⸻

🗺️ Roadmap

* ✅ Toolkit modular
* ✅ Sistema de informes
* ✅ Instalador automático
* ✅ Actualizador
* 🚧 Sistema de plugins
* 🚧 Dashboard Web
* 🚧 Docker
* 🚧 API REST
* 🚧 Gestión de Workspaces

⸻

⚠️ Uso Responsable

Este proyecto ha sido desarrollado para:

* Auditorías autorizadas.
* Pentesting profesional.
* Formación.
* Investigación en ciberseguridad.

No utilices SOKIX Toolkit contra sistemas para los que no dispongas de autorización.

⸻

<div align="center">

⭐ SOKIX Toolkit v12

One Toolkit. Multiple Security Workflows.

Si este proyecto te resulta útil, dale una ⭐ al repositorio y contribuye a su desarrollo.

</div>