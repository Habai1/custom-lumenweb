#!/usr/bin/env bash

echo -e "$MESSAGE09"
echo "$ serve -n -p ${SERVER_PORT} ${WEBROOT}"
serve -n -p "${SERVER_PORT}" "${WEBROOT}"

