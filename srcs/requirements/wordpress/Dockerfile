FROM debian:bullseye

EXPOSE  9000

RUN     apt update -y
RUN     apt install php7.4-fpm php7.4-mysql curl wget tar -y

COPY	conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN	wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp

RUN     mkdir -p /run/php/ /var/run/php/ /var/www/html/ \
        && chown -R www-data:www-data /var/www/html/

COPY    ./conf/wp-config.php /var/www/html/
COPY    ./tools/wpscript.sh /bin/

RUN     chmod +x /bin/wpscript.sh

CMD ["wpscript.sh", "php-fpm7.4", "--nodaemonize"]