🛡️ SOKIX Toolkit v12

<p align="center">
  <img src="assets/banner.png" alt="SOKIX Toolkit Banner" width="100%">
</p>
<p align="center">
  <strong>Entorno profesional de hacking ético para Kali Linux</strong>
</p>
<p align="center">
</p>

⸻

📖 Descripción

SOKIX Toolkit es un entorno modular de hacking ético diseñado exclusivamente para Kali Linux. Reúne en una única interfaz una colección de herramientas para auditorías de seguridad, análisis de vulnerabilidades, reconocimiento, pruebas de penetración y generación de informes.

Su objetivo es simplificar el trabajo diario de pentesters, investigadores y estudiantes de ciberseguridad mediante un sistema organizado, rápido y fácil de mantener.

⸻

✨ Características

* 🔍 Reconocimiento y OSINT
* 🌐 Auditoría de aplicaciones web
* 📡 Escaneo y análisis de redes
* 🔐 Auditoría de contraseñas
* 📱 Seguridad móvil
* 💾 Forensia digital
* 📊 Generación automática de informes
* ⚙️ Instalación y actualización automática
* 📦 Gestión centralizada de herramientas
* 🧩 Arquitectura modular

⸻

📂 Estructura del Proyecto

SOKIX/
├── assets/
├── config/
├── docs/
├── logs/
├── modules/
│   ├── osint/
│   ├── web/
│   ├── network/
│   ├── password/
│   ├── mobile/
│   ├── forensics/
│   └── reporting/
├── reports/
├── tools/
├── install.sh
├── update.sh
└── sokix

⸻

💻 Requisitos

Recurso	Recomendado
Sistema Operativo	Kali Linux (Rolling)
RAM	8 GB mínimo (16 GB recomendado)
CPU	4 núcleos o superior
Almacenamiento	50 GB libres
Python	3.11 o superior
Git	Última versión

Dependencias

* Python 3
* Git
* Curl
* Wget
* Pip
* Make
* GCC

⸻

🚀 Instalación

Actualizar el sistema:

sudo apt update && sudo apt full-upgrade -y

Clonar el repositorio:

git clone https://github.com/sokix/toolkit.git

Entrar al directorio:

cd toolkit

Dar permisos:

chmod +x install.sh

Instalar:

./install.sh

⸻

▶️ Uso

Iniciar SOKIX:

./sokix

Mostrar ayuda:

./sokix --help

Actualizar módulos:

./sokix --update

Diagnóstico:

./sokix --diagnostic

Limpiar archivos temporales:

./sokix --clean

Generar informe:

./sokix --report

⸻

📦 Módulos

Módulo	Descripción
OSINT	Inteligencia de fuentes abiertas
Web	Auditoría de aplicaciones web
Network	Escaneo y enumeración de redes
Password	Auditoría y gestión de contraseñas
Mobile	Seguridad Android
Forensics	Análisis forense
Reporting	Informes automáticos

⸻

🔄 Actualización

Actualizar el toolkit:

./update.sh

O desde el propio programa:

./sokix --update

⸻

📊 Informes

Los informes generados se almacenan automáticamente en:

reports/

Incluyen:

* Resumen de la auditoría
* Herramientas utilizadas
* Resultados obtenidos
* Fecha y hora
* Estadísticas generales

⸻

🗺️ Roadmap

* ✅ Arquitectura modular
* ✅ Actualizaciones automáticas
* ✅ Sistema de informes
* ✅ Compatibilidad con Kali Linux
* 🔄 Sistema de plugins
* 🔄 Dashboard web
* 🔄 API REST
* 🔄 Integración con Docker
* 🔄 Gestión de perfiles

⸻

🤝 Contribuciones

Las contribuciones son bienvenidas.

1. Haz un Fork.
2. Crea una rama.

git checkout -b feature/nueva-funcion

3. Realiza tus cambios.
4. Haz un Commit.

git commit -m "Añadir nueva funcionalidad"

5. Sube los cambios.

git push origin feature/nueva-funcion

6. Abre un Pull Request.

⸻

📜 Licencia

Este proyecto está distribuido bajo la licencia MIT.

Consulta el archivo LICENSE para más información.

⸻

⚠️ Aviso Legal

SOKIX Toolkit ha sido desarrollado exclusivamente para:

* Auditorías de seguridad autorizadas.
* Pruebas de penetración.
* Investigación en ciberseguridad.
* Formación y aprendizaje.

Queda prohibido el uso del software para actividades no autorizadas o contrarias a la legislación vigente. El autor y los colaboradores no se responsabilizan del uso indebido del proyecto.

⸻

⭐ Apoya el Proyecto

Si SOKIX Toolkit te resulta útil:

* ⭐ Dale una estrella al repositorio.
* 🐛 Reporta errores.
* 💡 Propón nuevas funciones.
* 🤝 Contribuye al desarrollo.

⸻

<p align="center">

SOKIX Toolkit v12

Professional Ethical Hacking Environment for Kali Linux

Desarrollado para la comunidad de ciberseguridad.

</p>