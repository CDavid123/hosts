cat /etc/hosts | while read ip nume
do
	case "$ip" in
		""|\#*) continue ;;
	esac
	rezultat=$(nslookup "$nume" 2>/dev/null | grep "Address:" | tail -n 1 | awk '{print $2}')
	if [ -n "$rezultat" ] && [ "$rezultat" != "$ip" ]; then
		echo "Bogus IP for $nume in /etc/hosts!"
	fi
done
