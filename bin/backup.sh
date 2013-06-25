#!/bin/sh

users=`ls /home/`
today=`date +%Y%m%d`
ex_file="/home/kuroiwa/.backup_ex"
backup_home="/home/kuroiwa/share/cmst01/backup"
bogus="$backup_home/bogus"

cmd_compress="rar"
opt_compress="a -r -ol -x@${ex_file}"

echo "mkdir $bogus"
mkdir $bogus
echo "mv ${backup_home}/*.{rar,log} ${bogus}/"
mv ${backup_home}/*.{rar,log} ${bogus}/
#
cd /home
for user in $users; do
	echo "compressing [${user}]'s home..."
	$cmd_compress $opt_compress ${backup_home}/${today}_${user}.rar $user/ > ${backup_home}/${today}_${user}.log
done
#
echo "compressing [epson-156]..."
$cmd_compress $opt_compress ${backup_home}/${today}_epson-156.rar kuroiwa/share/epson-156/ > ${backup_home}/${today}_epson-156.log
#
echo "/bin/rm -rf $bogus"
/bin/rm -rf $bogus
