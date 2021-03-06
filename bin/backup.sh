#!/bin/sh

echo "=================================="
echo "BACKUP STARTED:`date +%Y/%m/%d\ %H:%M:%S`"

users=(`ls /home/`)
today=`date +%Y%m%d`
ex_file_rar="/home/kuroiwa/.backup_ex_rar"
ex_file_tar="/home/kuroiwa/.backup_ex_tar"
ex_file_tar_sys="/home/kuroiwa/.backup_ex_tar_sys"
backup_home="/home/kuroiwa/share/cmst01/backup"
bogus="$backup_home/bogus"

# # rar
# cmd_compress="rar"
# opt_compress="a -r -ol -x@${ex_file_rar}"
# ext="rar"

# tar
cmd_compress="tar"
opt1_compress="cfjv"
opt2_compress="--exclude-from=${ex_file_tar}"
opt3_compress="--exclude-from=${ex_file_tar_sys}"
ext="tar.bz2"

echo "mkdir $bogus"
mkdir $bogus
echo "mv ${backup_home}/*.{${ext},log} ${bogus}/"
mv ${backup_home}/*.{${ext},log} ${bogus}/
#
# echo "compressing [/]..."
# $cmd_compress $opt1_compress ${backup_home}/${today}_system.${ext} ${opt3_compress} / > ${backup_home}/${today}_system.log
#
echo "compressing [/home]..."
cd /home
for user in $users; do
	echo "compressing [/home/${user}]'s home..."
	echo "$cmd_compress $opt1_compress ${backup_home}/${today}_${user}.${ext} $opt2_compress $user > ${backup_home}/${today}_${user}.log"
	$cmd_compress $opt1_compress ${backup_home}/${today}_${user}.${ext} $opt2_compress $user > ${backup_home}/${today}_${user}.log
done
#
echo "compressing [epson-156]..."
cd /home/kuroiwa/share/
$cmd_compress $opt1_compress ${backup_home}/${today}_epson-156.${ext} $opt2_compress epson-156 > ${backup_home}/${today}_epson-156.log
#
echo "/bin/rm -rf $bogus"
/bin/rm -rf $bogus

echo "BACKUP ENDED:`date +%Y/%m/%d\ %H:%M:%S`"
