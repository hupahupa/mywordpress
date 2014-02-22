#!/bin/sh

export DB_HOST=
export DB_NAME=mywordpress
export DB_USER=
export DB_PASS=secret

#export PGDATABASE=$DATABASE
#export PGHOST=$DB_HOST
#export PGUSER=$DB_USER
#export PGPASSWORD=$DB_PASS

alias domysql='mysql -h $DB_HOST -u $DB_USER -p${DB_PASS} $DB_NAME'
