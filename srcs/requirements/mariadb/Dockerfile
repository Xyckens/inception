FROM debian:buster

RUN sudo apt update -y && sudo apt install -y mariadb

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /tmp/
CMD [ "/script.sh" ]