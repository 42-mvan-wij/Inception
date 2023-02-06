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

	{
		echo "FLUSH PRIVILEGES;" # load grant tables
		echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;"
		echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"
		echo "GRANT ALL ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';"
		echo "FLUSH PRIVILEGES;" # reload grant tables
	} | mariadbd --bootstrap

	echo "Initialized database"

else
	echo "Database already initialized"
fi

touch "$HEALTHCHECK_FILE"

echo "Running [$@]"
exec "$@"
