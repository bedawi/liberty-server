#!/bin/bash
#
# Variables
#
NC_CONTAINER="nextcloud-app" # Name of your nextcloud container 
DB_CONTAINER="cloud-db" # Name of your database container
DB_BACKUP_PATH="`dirname $0`" # Change this if the backups are to be stored in another folder. 
BACKUP_TIMESTAMP=`date +%y-%m-%d-%H%M%N`
#
# Let's start
#
echo "Running Database Backup..."
#
# First: Sending Nextcloud to maintenance mode
#
docker exec --user www-data ${NC_CONTAINER} php occ maintenance:mode --on
#
# Next: creating database dump (backup)
#
echo "Exporting Database to ${DB_BACKUP_PATH}/${BACKUP_TIMESTAMP}-database_dump.sql..."
docker exec -it ${DB_CONTAINER} sh -c 'exec mysqldump -h localhost -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE}' > ${DB_BACKUP_PATH}/${BACKUP_TIMESTAMP}-database_dump.sql
#
# Last: Ending Nextcloud maintenance mode
#
docker exec --user www-data ${NC_CONTAINER} php occ maintenance:mode --off
echo "All done."