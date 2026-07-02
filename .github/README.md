<div align="center">

# 🏠 HomeLab

**Modularny stos usług self‑hosted na Raspberry Pi, zarządzany przez Docker Compose.**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../LICENSE)
[![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)](https://docs.docker.com/compose/)
[![Platform](https://img.shields.io/badge/Platform-Raspberry%20Pi-c51a4a?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)

Każda usługa posiada własny katalog z plikiem `docker-compose.yml`.  
Wszystkie współdzielą wspólny plik konfiguracji [`.env`](../.env_example).

</div>

## 📋 Spis treści

- [Usługi](#-usługi)
- [Wymagania](#-wymagania)
- [Szybki start](#-szybki-start)
- [Konfiguracja sieci](#-konfiguracja-sieci)
- [Zarządzanie usługami](#-zarządzanie-usługami)
- [Struktura repozytorium](#-struktura-repozytorium)
- [Licencja](#-licencja)

<br>

## 🧩 Usługi

<div align="center">

| Usługa | Obraz | Opis |
| :--- | :---: | :---: |
| 🛡️ [Adguard Home](../adguard/docker-compose.yml) | `AdguardTeam/AdGuardHome` | Blokowanie reklam (DNS) |
| 🚀 [Dashy](../dashy/docker-compose.yml) | `lissy93/dashy` | Dashboard domowy |
| 📁 [FileBrowser](../filebrowser/docker-compose.yml) | `filebrowser/filebrowser` | Menedżer plików (web UI) |
| 🏠 [Home Assistant](../home-assistant/docker-compose.yml) | `Home Assistant` | Automatyka domowa |
| 🍔 [Mealie](../mealie/docker-compose.yml) | `mealie-recipes/mealie` | Przepisy i planowanie posiłków |
| 🔗 [Mosquitto](../mqtt/docker-compose.yml) | `eclipse-mosquitto/mosquito` | Broker MQTT |
| 🕸️ [Nginx Proxy](../nginx-proxy/docker-compose.yml) | `NginxProxyManager/nginx-proxy-manager` | Reverse proxy i certyfikaty SSL |
| 📡 [Zigbee2MQTT](../zigbee2mqtt/docker-compose.yml) | `koenkk/zigbee2mqtt` | Most Zigbee → MQTT |

</div>

<br>

## ✅ Wymagania

<div align="center">

| Komponent | Minimum |
| :--- | :--- |
| System operacyjny | Linux (Raspberry Pi OS, Debian, Ubuntu) |
| Docker | `>= 24.0` |
| Docker Compose | `>= 2.20` (plugin V2) |
| Dostęp | SSH lub terminal lokalny |

</div>

<br>

## 🚀 Szybki start

### 1. Klonowanie repozytorium

```sh
git clone https://github.com/Kogut01/HomeLab.git
cd HomeLab
```

### 2. Konfiguracja zmiennych środowiskowych

```sh
cp .env_example .env
```

Edytuj `.env` i uzupełnij wymagane wartości — strefę czasową, IP hosta, porty oraz hasła:

```dotenv
TZ=Europe/Warsaw
DASHY_PORT=
MEALIE_PORT=
FILEBROWSER_PORT=
# ...
```

### 3. Uruchomienie usług

Aby uniknąć powtarzania `--env-file` przy każdym poleceniu, wyeksportuj ścieżkę globalnie:

```sh
export COMPOSE_ENV_FILES="$PWD/.env"
```

Następnie uruchom wybraną usługę:

```sh
cd dashy && docker compose up -d
```

Lub podaj plik `.env` jawnie:

```sh
cd dashy && docker compose --env-file ../.env up -d
```

<br>

## 🌐 Konfiguracja sieci

Repozytorium zawiera skrypty pomocnicze do zarządzania adresem IP hosta:

| Skrypt | Opis |
| :--- | :--- |
| [`set_static_ip.sh`](../set_static_ip.sh) | Ustaw statyczny adres IP |
| [`set_auto_ip.sh`](../set_auto_ip.sh) | Przywróć automatyczne DHCP |

```sh
# Statyczny IP
sudo bash ./set_static_ip.sh

# Powrót do DHCP
sudo bash ./set_auto_ip.sh
```

<br>

## 🔧 Zarządzanie usługami

Wszystkie polecenia wykonywane są z katalogu danej usługi (np. `cd dashy/`).

```sh
# ▶ Uruchomienie
docker compose up -d

# 🔄 Aktualizacja obrazów + restart
docker compose pull && docker compose up -d

# 📋 Podgląd logów (na żywo)
docker compose logs -f

# ♻️ Restart
docker compose restart

# ⏹ Zatrzymanie i usunięcie kontenerów
docker compose down
```

<br>

## 📂 Struktura repozytorium

```
HomeLab/
├── .env_example                        # 📜 Szablon zmiennych środowiskowych
├── .github/                            # ⚙️ CI/CD, Dependabot, konfiguracja GitHub
│   ├── workflows/
│   └── dependabot.yml
├── adguard/                            # 🛡️ DNS ad‑blocker
│   └── docker-compose.yml
├── dashy/                              # 🚀 Dashboard
│   ├── docker-compose.yml
│   └── config/
│       └── conf-example.yml            # ⚙️ Przykładowa konfiguracja Dashy
├── filebrowser/                        # 📁 Menedżer plików
│   └── docker-compose.yml
├── home-assistant/                     # 🏠 Automatyka domowa
│   └── docker-compose.yml
├── mealie/                             # 🍔 Przepisy kulinarne
│   └── docker-compose.yml
├── mqtt/                               # 🔗 Broker MQTT (Mosquitto)
│   └── docker-compose.yml
├── nginx-proxy/                        # 🕸️ Reverse proxy
│   └── docker-compose.yml
├── zigbee2mqtt/                        # 📡 Most Zigbee → MQTT
│   ├── docker-compose.yml
│   └── config/
│       └── conf-example.yml            # ⚙️ Przykładowa konfiguracja
├── set_static_ip.sh                    # ⌨️ Ustawienie statycznego IP
├── set_auto_ip.sh                      # 🚌 Powrót do DHCP
└── LICENSE                             # 📜 Licencja MIT
```

<br>

## 📜 Licencja

<div align="center">

Projekt jest udostępniany na licencji [MIT](../LICENSE).

Copyright © 2025 [Kogut01](https://github.com/Kogut01)

</div>
