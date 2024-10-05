# init

Small docker that will setup and seed a sql server from evv.
Perfect when setting up new app ore service.
Simple deploy with the service and add the source of the sql to use.


## Config
all config is done by env to work in a k8s cluster ore docker compose.

```
    environment:
      DEST_DBPASS: moodle #the new db username
      DEST_DBUSER: moodle # the new db password
      DEST_DB: moodle # the new database
      DBHOST: mysql  # the mysql server
      ROOT: root # the admin account
      ROOTPASS: password # the admin password
      SEED_DB: true  # if we should add data ore one setup the database and user 
      SEED_SOURCE: https://storage.googleapis.com/elino-public-assets/sql/moodle/uggla_seed.sql # public file to download and add to the db

```



