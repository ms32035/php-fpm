FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -yqq dist-upgrade && \
    apt-get -yqq install php-fpm php-redis php-xml php-json php-mysql php-curl php-imagick less sudo wget && \
    wget -P /srv/ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    sed -i -- 's|listen = /run/php/php8.3-fpm.sock|listen = 0.0.0.0:9000|g' /etc/php/8.3/fpm/pool.d/www.conf && \
    sed -i -- 's|upload_max_filesize = 2M|upload_max_filesize = 10M|g' /etc/php/8.3/fpm/php.ini && \
    sed -i -- 's|post_max_size = 8M|post_max_size = 20M|g' /etc/php/8.3/fpm/php.ini && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Set disable_coredump false" >> /etc/sudo.conf
	
EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.3","-F"]
