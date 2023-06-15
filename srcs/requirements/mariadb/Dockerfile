FROM debian:buster

RUN apt update -y && apt install -y mariadb-server

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/mdbscript.sh /tmp/

CMD [ "/bin/bash", "/tmp/mdbscript.sh" ]