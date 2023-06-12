FROM debian:buster

RUN apt update -y
RUN apt install php-fpm php-mysql curl -y

COPY ./tools/script.sh /
COPY ./conf/wp-config.php /

CMD [ "/script.sh" ]