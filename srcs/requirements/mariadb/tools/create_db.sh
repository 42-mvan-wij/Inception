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

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

	echo "Initializing $MARIDB_DATABASE database"

	{
		echo "FLUSH PRIVILEGES;" # load grant tables
		echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
		echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED VIA mysql_native_password USING PASSWORD('$DB_ROOT_PASSWORD') WITH GRANT OPTION;"
		echo "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
		echo "FLUSH PRIVILEGES;" # reload grant tables
	} | mariadbd --bootstrap

	echo "Initialized database"

else
	echo "Database already initialized"
fi

touch "$HEALTHCHECK_FILE"

echo "Running [$@]"
exec "$@"
