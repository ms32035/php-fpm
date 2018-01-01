FROM ubuntu:zesty

RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install php-fpm php-redis php-xml php-json php-mysql php-curl less sudo wget && \
    wget -P /srv/ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    mkdir /run/php && \
    sed -i -- 's|listen = /run/php/php7.0-fpm.sock|listen = 0.0.0.0:9000|g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -- 's|upload_max_filesize = 2M|upload_max_filesize = 10M|g' /etc/php/7.0/fpm/php.ini
	
EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.0","-F"]
