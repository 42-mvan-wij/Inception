FROM debian:stable

RUN apt-get update; \
	apt-get upgrade -y; \
	apt-get install -y mariadb-server;

RUN mkdir -p /var/run/mysqld; \
	chmod 777 /var/run/mysqld /var/lib/mysql;

RUN sed 's/bind-address .*/bind-address = mariadb/' -i /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/create_db.sh /usr/bin/create_db.sh
RUN chmod 777 /usr/bin/create_db.sh
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

ENV HEALTHCHECK_FILE=/usr/health

HEALTHCHECK --interval=1s --retries=20 \
	CMD test -e "$HEALTHCHECK_FILE"

EXPOSE 3306
ENTRYPOINT [ "create_db.sh" ]
CMD [ "mariadbd" ]
