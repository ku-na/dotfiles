#!/bin/sh
# log of backup
LOG=/home/kuroiwa/epson-156/Data/backup_log
echo "===== BACKUP STARTED `date +%Y/%m/%d/%H:%M:%S` =====" >> $LOG
# where to backup
PARTITION=/dev/sdb2
HOME_DIR=/home
HOME_USR=`ls $HOME_DIR`
echo $HOME_DIR
echo $HOME_USR
HOME_USR=kuroiwa

for user in $HOME_USR; do
	tar cvjf /tmp/backup_$user_`date +%y%m%dH%M`.tar.bz2 $HOME_DIR/$user/ >> $LOG
	cd /tmp
	echo "--- Backup File ---" >> $LOG
	ls backup_* >> $LOG
	mv backup_$user_* /home/kuroiwa/share/epson-156/Data
	/bin/rm -f *.tar.bz2 >> $LOG
	echo "-------------------" >> $LOG
	echo `date` >> $LOG
	echo "-------------------" >> $LOG
done
