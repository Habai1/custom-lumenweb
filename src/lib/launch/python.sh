#!/usr/bin/env bash

echo -e "$MESSAGE06"
echo "$ python3 -m http.server ${SERVER_PORT}"
python3 -m http.server "${SERVER_PORT}"

