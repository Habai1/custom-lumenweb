#!/usr/bin/env bash

# Determine JDK version
JDK_VERSION="${JAVA_VERSION:-21}"
SOFTWARE_LOWER="$(echo "$SOFTWARE" | tr '[:upper:]' '[:lower:]')"

if [[ "$SOFTWARE_LOWER" == *"25"* ]]; then
	JDK_VERSION="25"
elif [[ "$SOFTWARE_LOWER" == *"21"* ]]; then
	JDK_VERSION="21"
fi

set_java_version "$JDK_VERSION"

cd "$WEBROOT" || exit 1

JAR_TO_RUN="${JARFILE:-app.jar}"

if [ ! -f "$JAR_TO_RUN" ]; then
	shopt -s nullglob
	jars=(*.jar)
	shopt -u nullglob

	if [ ${#jars[@]} -eq 1 ]; then
		echo -e " ${y}●${w} Specified JAR (${JAR_TO_RUN}) not found, but found ${jars[0]}. Using ${jars[0]}.${reset}"
		JAR_TO_RUN="${jars[0]}"
	elif [ ${#jars[@]} -gt 1 ]; then
		echo -e " ${y}●${w} Specified JAR (${JAR_TO_RUN}) not found and multiple .jar files found: ${jars[*]}${reset}"
		echo -e " ${y}●${w} Please specify the JARFILE environment variable.${reset}"
		source /static/launch/custom.sh
		exit 0
	else
		echo -e " ${y}●${w} No JAR file found in ${WEBROOT} (looked for ${JAR_TO_RUN}).${reset}"
		echo -e "$MESSAGE07"
		source /static/launch/custom.sh
		exit 0
	fi
fi

export PORT="${SERVER_PORT}"
export SERVER_PORT="${SERVER_PORT}"

echo -e " ${g}●${w} Starting Java application with JDK ${JDK_VERSION} on port ${SERVER_PORT}...${reset}"
echo "$ java ${JAVA_ARGS} -Dserver.port=${SERVER_PORT} -jar ${JAR_TO_RUN}"

# shellcheck disable=SC2086
exec java ${JAVA_ARGS} -Dserver.port="${SERVER_PORT}" -jar "${JAR_TO_RUN}"
