#!/bin/sh

if [ -f "$HEALTHCHECK_FILE" ]; then
	echo "Healthchech file already exists, removing it"
	rm "$HEALTHCHECK_FILE"
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing mysql database"
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql
fi

if [ ! -d "/var/lib/mysql/$MARIADB_DATABASE" ]; then

	echo "Initializing $MARIDB_DATABASE database"

	service mariadb start

	{
		echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;"
		echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"
		echo "FLUSH PRIVILEGES;"
		echo "GRANT ALL ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"
		echo "FLUSH PRIVILEGES;"
	} | mariadb

	# Wait until all queries are done (requires 64 queries)
	queries=64
	while [ "$(mysqladmin status | grep -o "Questions: [0-9]*")" != "Questions: $queries" ]; do queries=$(($queries + 1)); done

	service mariadb stop

	echo "Initialized database"

else
	echo "Database already initialized"
fi

touch "$HEALTHCHECK_FILE"

echo "Running [$@]"
exec "$@"
