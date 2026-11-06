#!/bin/bash

# LumenWEB by the Lumen Development team.
# Welcome to the main file of the LumenWEB pterodactyl egg.
# This project is hosted at https://github.com/LumenDevelopment/LumenWEB.

source /static/helper.sh
source /static/lang.sh
# I will ensure that the WEBROOT variable is pointing to a path, that is inside the /home/container directory and that is interfering with the config/ dir.
if [[ ! "$WEBROOT" =~ ^/home/container($|/) ]] || [[ "$WEBROOT" =~ ^/home/container/config($|/) ]]; then

	echo -e "$INVALID_WEBROOT_PATH${reset}"
	exit 1
else
	mkdir -p "$WEBROOT"
	HOME="/home/container"
	cd "$WEBROOT" || exit 1
fi

SOFTWARE_LOWER="$(echo "$SOFTWARE" | tr '[:upper:]' '[:lower:]')"

# Make sure that the egg isn't modified and the user has selected a valid software.
VALID_SOFTWARES=" php 8.4 php 8.3 php 8.2 php 8.1 php 8.0 php 7.4 python vercel/serve astro nextjs react custom java java 21 java 25 "
if [[ ! "$VALID_SOFTWARES" =~ " ${SOFTWARE_LOWER} " ]]; then
	echo -e " ${r}●${w} Unknown software type: $SOFTWARE. Make sure the egg is up-to-date${reset}"
	exit 1
fi
# Basically, if a CUSTOM_COMMAND is provided, we will always use custom
[[ -n "$CUSTOM_COMMAND" && "$SOFTWARE" != "custom" ]] && SOFTWARE="custom"

# Setup default Java environment (JDK 21 or 25)
SELECTED_JAVA_VER="${JAVA_VERSION:-21}"
if [[ "$SOFTWARE_LOWER" == *"25"* ]]; then
	SELECTED_JAVA_VER="25"
elif [[ "$SOFTWARE_LOWER" == *"21"* ]]; then
	SELECTED_JAVA_VER="21"
fi
set_java_version "$SELECTED_JAVA_VER"

# We need to have a public IP address, if the SERVER_IP (provided by pterodactyl) is a local address, fetch it from an API.
if [[ "$SERVER_IP" =~ ^127\. || "$SERVER_IP" =~ ^10\. || "$SERVER_IP" =~ ^192\.168\. || "$SERVER_IP" =~ ^172\.(1[6-9]|2[0-9]|3[0-1])\. ]]; then
  # FEEL FREE TO CHANGE THE URL TO SOMETHING ELSE!
  # Note that the -k option (-k, --insecure - Allow insecure server connections) so that it doesn't freak out because an expired cert.
	SERVER_IP=$(curl -k -s https://web.lumenvm.cloud/ip)
fi


if [[ -n "$OVERWRITE_IP" && "$OVERWRITE_IP" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
	valid=true
	for octet in $(echo "$OVERWRITE_IP" | tr '.' ' '); do
		[[ $octet -ge 0 && $octet -le 255 ]] || valid=false
	done
	[[ $valid == true ]] && SERVER_IP="$OVERWRITE_IP"
fi

mkdir -p /home/container/config/
mkdir -p /home/container/logs/
mkdir -p /home/container/.cloudflared/
mkdir -p /home/container/.bin/

cp -n -r /static/default/* /home/container/config/

echo "Starting LumenWEB"
clear

if [ -z "${OVERWRITE_BANNER}" ]; then
	echo -e "${b} __                      _ _ _ _____ _____"
	echo -e "${b}|  |   _ _ _____ ___ ___| | | |   __| __  |"
	echo -e "${b}|  |__| | |     | -_|   | | | |   __| __ -|"
	echo -e "${b}|_____|___|_|_|_|___|_|_|_____|_____|_____|${reset}"
else
	echo -e "${OVERWRITE_BANNER}"
fi

# Somehow, the next line fixed some issues inside of the pterodactyl console.
echo "   "

# default message: "Checking the current installation."
echo -e "$MESSAGE01"

if [ -n "$DOMAIN" ]; then
  source /static/cloudflared.sh || exit 1
fi

box "${SERVER_IP}" "${domains[@]}"

if [[ "$SOFTWARE" == php* ]]; then
  source /static/launch/php.sh

elif [[ "$SOFTWARE" == python* ]]; then
	source /static/launch/python.sh

elif [[ "$SOFTWARE_LOWER" == java* ]]; then
	source /static/launch/java.sh

elif [[ "$SOFTWARE" == NextJS ]]; then
	source /static/launch/nextjs.sh

elif [[ "$SOFTWARE" == React ]]; then
	source /static/launch/react.sh

elif [[ "$SOFTWARE" == Astro ]]; then
	source /static/launch/astro.sh

elif [[ "$SOFTWARE" == vercel/serve* ]]; then
	source /static/launch/serve.sh

elif [[ "$SOFTWARE" == "custom" ]]; then
	source /static/launch/custom.sh

else
	echo -e "$MESSAGE15"
	exit 1
fi
