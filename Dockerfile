FROM ubuntu:zesty

RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y install supervisor php-fpm php-redis php-xml php-json php-mysql less sudo wget && \
    wget -P /srv/ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    mkdir /run/php && \
    sed -i -- 's|listen = /run/php/php7.0-fpm.sock|listen = 0.0.0.0:9000|g' /etc/php/7.0/fpm/pool.d/www.conf
	
EXPOSE 9000
COPY php-fpm.conf /etc/supervisor/conf.d/

#RUN service php7.0-fpm start
CMD ["/usr/bin/supervisord"]
