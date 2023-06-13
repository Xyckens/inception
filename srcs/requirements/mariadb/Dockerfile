FROM debian:buster

RUN apt update -y && apt install -y mariadb-server

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /tmp/

CMD [ "/script.sh" ]