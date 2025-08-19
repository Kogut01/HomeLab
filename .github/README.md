# HomeLab

Nowoczesny, prosty do uruchomienia zestaw usług self‑hosted dla mojej Raspberry Pi: Portainer, Pi‑hole, Dashy, Glances, Mealie oraz Stremio. Każda usługa ma własny katalog z plikiem `docker-compose.yml` i współdzieli wspólny plik konfiguracji `.env`.

### ↳ Struktura repozytorium

<div align="center">

| Linki | Opis |
| :--- | :---: |
| 🚀 [`Dashy`](../dashy/docker-compose.yml) | dashboard - [Lissy93/Dashy](https://github.com/Lissy93/dashy). |
| 📊 [`Glances`](../glances/docker-compose.yml) | monitoring systemu (Glances). |
| 🍔 [`Mealie`](../mealie/docker-compose.yml) | menedżer przepisów (Mealie). |
| 🍓 [`Pi-hole`](../pihole/docker-compose.yml) | Pi‑hole z udawaną maliną na ikonce. |
| ⚓️ [`Portainer`](../portainer/docker-compose.yml) | Portainer CE. |
| 🎬 [`Stremio`](../stremio/docker-compose.yml) | Stremio server. |
| 🪨 [`.env`](../.env_example) | Przykład zmiennych środowiskowych. | 
| ⌨️ [`Static_ip`](../set_static_ip.sh) | Skrypt ustawiania statycznego IP. |
| 🚌 [`Auto_ip`](../set_auto_ip.sh) | Skrypt ustawiania DHCP. |

| | |
| :--- | :---: |
| 📜 [`Licencja`](../LICENSE) | Licencja MIT |

</div>


## Wymagania
- Docker i Docker Compose
- System Linux (np. Raspberry Pi OS)
- Dostęp do powłoki na hoście (SSH lub lokalnie)

## Konfiguracja środowiska
1. Sklonuj repo:
   ```sh
   git clone https://github.com/Kogut01/HomeLab.git
   cd HomeLab
   ```
2. Skopiuj i uzupełnij zmienne środowiskowe:
   ```sh
   cp .env_example .env
   # Edytuj .env i ustaw m.in. TZ, RASPBERRY_IP, hasła itp.
   ```
3. Opcjonalnie ustaw IP:
   - Statyczne:  
     ```sh
     sudo chmod a+w ./set_static_ip.sh
     ./set_static_ip.sh
     ```
   - Automatyczne (DHCP):  
     ```sh
     sudo chmod a+w ./set_auto_ip.sh
     ./set_auto_ip.sh
     ```

## Uruchamianie usług
Masz dwie opcje przekazywania pliku `.env` do Docker Compose:

1. Eksport ścieżki do `.env` (Twoja notatka – zachowane):
    - export COMPOSE_ENV_FILES=(ścieżka do twojego .env) - robimy to po to aby nie musieć za każdym razem wpisywać długeij komendy docker compose z --env-file i ścieżka.
    - Przykład:
        ```sh
        export COMPOSE_ENV_FILES="$PWD/.env"
        ```
2. Albo jawnie przez `--env-file` (w każdym katalogu usługi):
    ```sh
    docker compose --env-file ../.env up -d
    ```

## Uruchamianie pojedynczych usług (przykłady):
```sh
# Dashy
cd dashy && docker compose up -d

# Portainer
cd portainer && docker compose up -d

# Pi-hole
cd pihole && docker compose up -d

# Glances
cd glances && docker compose up -d

# Mealie
cd mealie && docker compose up -d

# Stremio
cd stremio && docker compose up -d
```

## Aktualizacja, logi, serwis
```sh
# Aktualizacja obrazów i restart
docker compose pull && docker compose up -d

# Logi kontenera w danym katalogu usługi
docker compose logs -f

# Restart/Stop
docker compose restart
docker compose down
```


## Bezpieczeństwo
- Nie umieszczaj prawdziwych haseł/sekretów w repo publicznym. Używaj `.env` lokalnie.
- Rozważ zmianę domyślnych haseł, używaj HTTPS (NPM) oraz regularnie aktualizuj obrazy.

## Pihole blocklist
- https://cert.pl/posts/2020/03/ostrzezenia_phishing/
- https://firebog.net/