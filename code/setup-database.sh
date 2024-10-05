#!/bin/bash

echo "Waiting $DBHOST to launch on 3306..."

while ! nc -z $DBHOST 3306; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done

# Some sleep sometimes the sql is slow a
echo "Mysql is ready!"
sleep 2


# Check if the Database exists and if not create it
RESULT=`mysqlshow --user=$ROOT -h $DBHOST --password=$ROOTPASS $DEST_DB| grep -v Wildcard | grep -o $DEST_DB`
if [ "$RESULT" != "$DEST_DB" ]; then
    echo "Database dont exists creating..."
    mysql --user=$ROOT -h $DBHOST --password=$ROOTPASS -e "CREATE DATABASE $DEST_DB;"
    echo "Creating users .."
    mysql --user=$ROOT -h $DBHOST --password=$ROOTPASS -e "CREATE USER '$DEST_DBUSER'@'%' IDENTIFIED BY '$DEST_DBPASS';"
    mysql --user=$ROOT -h $DBHOST --password=$ROOTPASS -e "GRANT ALL PRIVILEGES ON $DEST_DB.* TO '$DEST_DBUSER'@'%';"
    if [ "true" == "$SEED_DB" ]; then
        echo "Seeding database ... "
        echo "Downloading source data"
        wget -v $SEED_SOURCE -O /tmp/source.sql
        echo "Adding data to the new Database this may take some time "
        mysql --user=$ROOT -h $DBHOST --password=$ROOTPASS $DEST_DB < /tmp/source.sql
        echo "All Done exit"

    fi
else
    echo "Database is already setup nothing to do exit..."
fi

