#!/usr/bin/env bash

if [ -z "$(ls -A "${WEBROOT}")" ]; then
	echo -e "${g}●${w} Opening a shell. Install your project as you would normally inside of $WEBROOT{reset}"
	cd "${WEBROOT}" || exit 1
  source /static/launch/custom.sh
else
	echo -e "${y}●${w} Remove all files from ${WEBROOT} if you want to run a clean installation of ${SOFTWARE}${reset}"
fi
echo -e "$MESSAGE09"
echo "$ pnpm start"
PORT=$SERVER_PORT pnpm start

