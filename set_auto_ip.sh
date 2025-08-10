#!/bin/bash

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                                                                                                   "
echo "              ╔═════════════════════════════════════════════════════════════════════╗              "
echo "              ║        Witaj w skrypcie ustawiania automatycznego adresu IP.        ║              "
echo "              ║   Ten skrypt ustawi automatyczny adres IP dla twojej Raspberry PI.  ║              "
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

sudo nmcli con modify "$interface" ipv4.method auto
sudo nmcli c down "$interface" && sudo nmcli c up "$interface"

echo "                                                                                                   "
echo "───────────────────────────────────────────────────────────────────────────────────────────────────"
echo "                 Automatyczny adres IP został ustawiony dla interfejsu $interface.                 "
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
echo "  
