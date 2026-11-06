#!/usr/bin/env bash

box() {
	local width=65
	printf "╭"
	printf '─%.0s' $(seq 1 $width)
	printf "╮\n"
	printf "│ %-*s │\n" $((width - 2)) "$MESSAGE04"
	for domain in "${@:2}"; do
		printf "│  ${b}●${reset} %-*s │\n" 60 "https://${domain:0:52}${domain:53+0:3}"
	done
	printf "│  ${b}●${reset} %-*s │\n" 60 "http://$1:${SERVER_PORT}"
	printf "╰"
	printf '─%.0s' $(seq 1 $width)
	printf "╯\n"
}

set_java_version() {
	local ver="$1"
	local arch
	arch=$(dpkg --print-architecture 2>/dev/null || uname -m)
	if [ "$arch" = "x86_64" ]; then
		arch="amd64"
	elif [ "$arch" = "aarch64" ]; then
		arch="arm64"
	fi

	local jvm_dir=""
	for dir in \
		"/usr/lib/jvm/java-${ver}-openjdk-${arch}" \
		"/usr/lib/jvm/java-${ver}-openjdk" \
		"/usr/lib/jvm/java-1.${ver}.0-openjdk-${arch}" \
		"/usr/lib/jvm/java-${ver}-openjdk-"* \
		"/usr/lib/jvm/jdk-${ver}"*; do
		if [ -d "$dir" ] && [ -x "$dir/bin/java" ]; then
			jvm_dir="$dir"
			break
		fi
	done

	if [ -n "$jvm_dir" ]; then
		export JAVA_HOME="$jvm_dir"
		export PATH="$JAVA_HOME/bin:$PATH"
		return 0
	fi
	return 1
}

