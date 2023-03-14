#!/bin/bash
source .env

# Create TEMP Folder for backups
foldername=$(date +%Y-%m-%d_%H%M%S)
mkdir -p $BACKUP_TMP/${BACKUP_NAME}_${foldername}
echo "Created backup folder ${BACKUP_TMP}/${BACKUP_NAME}_${foldername}"

# Dump database to sql file
echo "Dumping Database"
mysqldump -u${BACKUP_DATABASE_USER} -p${BACKUP_DATABASE_PASS} -h $BACKUP_DATABASE_IP $BACKUP_DATABASE_NAME > $BACKUP_TMP/${BACKUP_NAME}_${foldername}/$BACKUP_DATABASE_NAME.sql

# Archive Files
echo "Archiving..."
tar -czf $BACKUP_FOLDER/${BACKUP_NAME}_${foldername}.tar.gz -C $BACKUP_TMP/${BACKUP_NAME}_${foldername} .

echo "Deleting TEMP Folder"
rm -rf $BACKUP_TMP/${BACKUP_NAME}_${foldername} 

echo "Done!!!"