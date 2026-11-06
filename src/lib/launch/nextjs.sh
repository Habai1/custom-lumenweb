#!/usr/bin/env bash

if [ -z "$(ls -A "${WEBROOT}")" ]; then
	echo -e "$MESSAGE07"
	source /static/launch/custom.sh
else
	echo -e " ${y}●${w} Remove all files from ${WEBROOT} if you want to run a clean installation of ${SOFTWARE}${reset}"
fi
echo -e "$MESSAGE09"
echo "$ npx --yes next dev ${WEBROOT} -p ${SERVER_PORT} -H 0.0.0.0"
npx --yes next dev "${WEBROOT}" -p "${SERVER_PORT}" -H "0.0.0.0"

