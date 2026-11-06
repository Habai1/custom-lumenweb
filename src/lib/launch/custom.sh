#!/usr/bin/env bash
unset PUBLIC_IP WEBROOT CHECK PROXY BANNER DOMAIN DOMAIN_MODE SOFTWARE SERVER_PORT PHP_VERSION
if [[ -n "$CUSTOM_COMMAND" ]]; then
	eval "$CUSTOM_COMMAND"
else
	width=65
	printf "╭"
	printf '─%.0s' $(seq 1 $width)
	printf "╮\n"
	printf "│ %-*s │\n" "$((width - 2))" "Welcome to the LumenWEB shell."
	printf "│ %-*s │\n" "$((width - 2))" "Available commands:"
	printf "│ ${b}●${reset} %-*s │\n" "$((width - 4))" "Node.js: node, npm, pnpm, yarn, bun"
	printf "│ ${b}●${reset} %-*s │\n" "$((width - 4))" "Web servers: nginx, php-fpm"
	printf "│ ${b}●${reset} %-*s │\n" "$((width - 4))" "Java: java, javac, jar (JDK ${SELECTED_JAVA_VER:-21/25})"
	printf "│ ${b}●${reset} %-*s │\n" "$((width - 4))" "Other: python"
	printf "╰"
	printf '─%.0s' $(seq 1 $width)
	printf "╯\n"
	PS1='\[\e[0m\]\[\e[37;1m\]\n> \[\e[0m\]'
	while true; do
		read -r -p "server@lumenweb:~$(pwd)# "$'\n' command
		if ! command -v "${command%% *}" &>/dev/null; then
			echo "Command '${command}' not found."
		else
			case "$command" in
			"exit") break ;;
			*) eval "$command" ;;
			esac
		fi
	done
fi