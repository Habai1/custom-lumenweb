#!/usr/bin/env bash
# shellcheck disable=SC2154

CLOUDFLARED="/home/container/.bin/cloudflared"

if [ ! -f "$CLOUDFLARED" ]; then
    ARCH=$(uname -m)

    if [ "$ARCH" = "x86_64" ]; then
        URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64"
    elif [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
        URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64"
    else
        echo -e " ${r}●${w} Unknown architecture."
        exit 1
    fi

    echo -e " ${g}●${w} Installing cloudflared to ${CLOUDFLARED}"

    curl -L "$URL" -o "$CLOUDFLARED" >>/home/container/logs/cloudflared.log 2>&1
    chmod +x "$CLOUDFLARED" >>/home/container/logs/cloudflared.log 2>&1
fi


if [ ! -f "/home/container/.cloudflared/cert.pem" ]; then
		echo -e " ${g}●${w} Please open the following URL and log in with your Cloudflare account:"
		"$CLOUDFLARED" login 2>&1 | grep "https://dash.cloudflare.com/argotunnel"
		echo -e "$reset"

fi

TUNNEL_NAME="LumenWEB-$P_SERVER_UUID"

id=$("$CLOUDFLARED" tunnel list --output json | jq -r --arg name "$TUNNEL_NAME" '.[] | select(.name==$name) | .id')

if [ -z "$id" ]; then
	echo -e " ${g}●${w} Creating the Cloudflare Tunnel..."
	"$CLOUDFLARED" tunnel create "$TUNNEL_NAME" >>/home/container/logs/tmp.log 2>&1
	id=$("$CLOUDFLARED" tunnel list --output json | jq -r --arg name "$TUNNEL_NAME" '.[] | select(.name==$name) | .id')

	if [ -z "$id" ]; then
		echo -e " ${g}●${w} An error occurred while creating the tunnel. (Full dump:)"
		cat /home/container/logs/tmp.log
		exit 1
	fi
fi

if [ ! -f "/home/container/.cloudflared/$id.json" ]; then
	"$CLOUDFLARED" tunnel token --cred-file "/home/container/.cloudflared/$id.json" "$TUNNEL_NAME"
fi

echo -e " ${g}●${w} Running the Cloudflare Tunnel..."
"$CLOUDFLARED" tunnel --url http://localhost:"$SERVER_PORT" run "$id" >>/home/container/logs/cloudflared.log 2>&1 &

echo -e " ${g}●${w} Make sure a${y} proxied${w} CNAME record points to $id.cfargotunnel.com for all domains.${reset}"

# shellcheck disable=SC2153
IFS=',' read -r -a domain_list <<<"$DOMAIN"
domains=()
echo -e " ${y}●${w} Automatically trying to route the DNS records.${reset}"
for domain in "${domain_list[@]}"; do
	if [ -n "$domain" ]; then
		domains+=("$domain")
		"$CLOUDFLARED" tunnel route dns -f "LumenWEB-$P_SERVER_UUID" "$domain" >>/home/container/logs/cloudflared.log 2>&1
	fi
done
