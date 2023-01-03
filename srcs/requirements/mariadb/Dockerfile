FROM debian:stable

RUN apt-get update; \
	apt-get upgrade -y; \
	apt-get install -y mariadb-server;

RUN mkdir -p /var/run/mysqld; \
	chmod 777 /var/run/mysqld /var/lib/mysql; \
	{	echo '[mysqld]'; \
		echo 'skip-networking=0'; \
		echo 'bind-address=0.0.0.0'; \
		echo 'skip-host-cache'; \
		echo 'skip-name-resolve'; \
	} > /etc/my.cnf;


COPY tools/create_db.sh /usr/bin/create_db.sh
RUN chmod 777 /usr/bin/create_db.sh
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql


USER mysql

EXPOSE 3306
ENTRYPOINT [ "create_db.sh" ]
CMD [ "mariadbd" ]
