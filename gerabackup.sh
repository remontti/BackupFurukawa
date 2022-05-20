#!/bin/sh
#
DIR='/root/scripts/BackupFurukawa'
cd ${DIR}
DATABKP=`date +%Y-%m-%d`
for var in `cat ${DIR}/OLTs`;do        
      IP=`echo $var | cut -d , -f 1`
      USER=`echo $var | cut -d , -f 2`
      PASS=`echo $var | cut -d , -f 3`
      PORTA=`echo $var | cut -d , -f 4`
      IDENTIFICACAO=`echo $var | cut -d , -f 5` 

	/root/scripts/BackupFurukawa/backup-fkw.py ${IP} ${USER} ${PASS} ${PORTA} ${DATABKP}_${IDENTIFICACAO}
	mv *.txt /home/backups/oltfurukawa/
	sleep 1
done