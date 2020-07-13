#!/bin/bash

set -e && cd /MTProxy

secret=$1 domain=$2

[ $secret ] || { echo '[0][Initialize: entrypoint.sh] ERROR: Missing parameter <32ch-secret>...'; exit 0; }
[ $domain ] || domain=bing.com

wan_ip="$(curl -s -4 "https://digitalresistance.dog/myIp")"
lan_ip="$(busybox ip -4 route get 8.8.8.8 | grep '^8\.8\.8\.8\s' | grep -Po 'src\s+\d+\.\d+\.\d+\.\d+' | awk '{print $2}')"

echo [0][Initialize: entrypoint.sh] MTProxy client secret: ee${secret}$(echo -n $domain | busybox xxd -p)

curl -s https://core.telegram.org/getProxySecret -o proxy-secret
curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf

exec ./mtproto-proxy -u nobody -p 8888 -H 443 -S ${secret} --aes-pwd proxy-secret proxy-multi.conf -M 2 --domain ${domain} --allow-skip-dh --nat-info "$lan_ip:$wan_ip"

