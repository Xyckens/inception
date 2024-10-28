FROM debian:bullseye

EXPOSE 3306

RUN apt update -y && apt install -y mariadb-server

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/mdbscript.sh /bin/

RUN     chmod +x /bin/mdbscript.sh

CMD		["mdbscript.sh", "mysqld_safe"]