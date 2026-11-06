#!/usr/bin/env bash

# shellcheck disable=SC2034
b="\033[38;5;38m"
y="\x1b[33m"
g="\x1b[32m"
w="\x1b[37m"
r="\x1b[31m"
reset="\x1b[0m"

INVALID_WEBROOT_PATH="${r}●${w} Invalid webroot path${reset}"

MESSAGE01=" ${g}●${w} Checking the current installation.${reset}"
MESSAGE02=" ${g}●${w} Creating the reverse proxy.${reset}"
MESSAGE03=" ${r}●${w} Unable to reach our servers. Check your network connection or try again later.${reset}"
MESSAGE04=" Your server is running at:"
MESSAGE05=" ${g}●${w} Started NGINX with PHP ${VERSION}.${reset}"
MESSAGE06=" ${g}●${w} Started the Python HTTP server${reset}"
MESSAGE07=" ${g}●${w} Opening a shell. Install your project as you would normally inside of $WEBROOT${reset}"
MESSAGE08=" ${y}●${w} Remove all files from ${WEBROOT} if you want to run a clean installation of ${SOFTWARE}${reset}"
MESSAGE09=" ${g}●${w} Starting the ${SOFTWARE} server.${reset}"
MESSAGE10=" ${g}●${w} Initializing an ${SOFTWARE} project.${reset}"
MESSAGE12=" ${g}●${w} Started NGINX with PHP 8.4.${reset}"
MESSAGE13=" ${g}●${w} Started the Dotnet ${VERSION} server${reset}"
MESSAGE14=" ${g}●${w} Started the Java ${JAVA_VERSION} server.${reset}"
MESSAGE15=" ${r}●${w} Unknown software type.${reset}"
