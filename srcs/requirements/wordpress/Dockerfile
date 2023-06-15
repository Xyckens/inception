FROM debian:buster

RUN apt update -y
RUN apt install php-fpm php-mysql curl -y

COPY ./tools/wpscript.sh /
COPY ./conf/wp-config.php /

CMD [ "/bin/bash", "/wpscript.sh" ]