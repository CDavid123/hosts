verifica_ip() {
    local nume=$1 ip=$2 dns=$3
    nslookup "$nume" "$dns" 2>/dev/null | awk '/^Address: / {print $2}' | grep -qxF "$ip"
}

DNS=${1:-8.8.8.8}

grep -E '^[0-9]+\.' /etc/hosts | while read -r ip nume _; do
    if verifica_ip "$nume" "$ip" "$DNS"; then
        echo "$nume -> $ip: OK"
    else
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
