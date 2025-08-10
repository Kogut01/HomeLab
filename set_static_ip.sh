#!/bin/bash

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
echo "              ╔═════════════════════════════════════════════════════════════════════╗              "
echo "              ║          Witaj w skrypcie ustawiania statycznego adresu IP.         ║              "
echo "              ║    Ten skrypt ustawi statyczny adres IP dla twojej Raspberry PI.    ║              "
echo "              ╚═════════════════════════════════════════════════════════════════════╝              "

if [ -n "$SSH_CLIENT" ]; then
    echo "                                                                                                    "
    echo "           ╔════════════════════════════════════════════════════════════════════════════╗           "
    echo "           ║    Uwaga: Jesteś połączony przez SSH. Zmiana IP może zerwać połączenie.    ║           "
    echo "           ╚════════════════════════════════════════════════════════════════════════════╝           "
fi

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                 Oto dostępne interfejsy sieciowe:                                 "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
sudo nmcli -p connection show

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                   Podaj nazwę połączenia sieciowego (np. 'Wired connection 1'),                   "
echo "                          dla którego chcesz ustawić statyczny adres IP:                           "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
read interface

if ! sudo nmcli connection show "$interface" &> /dev/null; then
    echo "                                                                                                   "
    echo "                 ╔═══════════════════════════════════════════════════════════════╗                 "
    echo "                            Błąd: Połączenie '$interface' nie istnieje.                            "
    echo "                 ╚═══════════════════════════════════════════════════════════════╝                 "
    echo "                                                                                                   "
    exit 1
fi

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                Podaj statyczny adres IP, który chcesz ustawić (np. 192.168.1.100):                "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
read static_ip

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                   Podaj maskę podsieci (np. 24):                                  "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
read subnet_mask

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "              Podaj bramę domyślną, zwykle jest to adres IP routera (np. 192.168.1.1):             "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
read gateway

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "             Podaj adres(y) serwera DNS (oddzielone przecinkiem, np. 8.8.8.8,8.8.4.4),             "
echo "               lub możesz ustawić jako adres DNS adres IP routera (np. 192.168.1.1):               "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
read dns_servers

sudo nmcli c mod "$interface" ipv4.addresses $static_ip/$subnet_mask ipv4.method manual
sudo nmcli con mod "$interface" ipv4.gateway $gateway
sudo nmcli con mod "$interface" ipv4.dns $dns_servers
sudo nmcli c down "$interface" && sudo nmcli c up "$interface"

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                   Statyczny adres IP został ustawiony dla interfejsu $interface.                  "
echo "                            Aktualne ustawienia interfejsu $interface:                             "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
nmcli -p connection show "$interface"

echo "                                                                                                   "
echo "           ╔═══════════════════════════════════════════════════════════════════════════╗           "
echo "           ║          Skrypt zakończony. Sprawdź, czy ustawienia są poprawne.          ║           "
echo "           ╚═══════════════════════════════════════════════════════════════════════════╝           "
echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
