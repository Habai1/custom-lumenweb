

mkdir -p /tmp/php/sessions /tmp/php/tmp
if [ -z "$(ls /home/container/webroot/index* 2>/dev/null)" ]; then
	echo "Welcome to LumenWEB" > "/home/container/webroot/index.html"
fi
VERSION="${SOFTWARE//php /}"
echo -e " ${g}●${w} Started NGINX with PHP ${VERSION}.${reset}"
eval "php-fpm${VERSION} -c /tmp/php --fpm-config /home/container/config/php-fpm.conf --daemonize"
sed -i "s/listen[[:space:]]*[0-9]\+;/listen ${SERVER_PORT};/g" /home/container/config/nginx.conf
sed -i 's|root /home/container[^;]*;|root '"$WEBROOT"';|' /home/container/config/nginx.conf
eval "nginx -c /home/container/config/nginx.conf"
tail -f /dev/null