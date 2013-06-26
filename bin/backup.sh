#!/bin/sh

users=`ls /home/`
today=`date +%Y%m%d`
ex_file_rar="/home/kuroiwa/.backup_ex_rar"
ex_file_tar="/home/kuroiwa/.backup_ex_tar"
backup_home="/home/kuroiwa/share/cmst01/backup"
bogus="$backup_home/bogus"

# # rar
# cmd_compress="rar"
# opt_compress="a -r -ol -x@${ex_file_rar}"

# tar
cmd_compress="tar"
opt_compress="cfj -X ${ex_file_tar}"
ext="tar.bz2"

echo "mkdir $bogus"
mkdir $bogus
echo "mv ${backup_home}/*.{${ext},log} ${bogus}/"
mv ${backup_home}/*.{${ext},log} ${bogus}/
#
cd /home
for user in $users; do
	echo "compressing [${user}]'s home..."
	$cmd_compress $opt_compress ${backup_home}/${today}_${user}.${ext} $user/ > ${backup_home}/${today}_${user}.log
done
#
echo "compressing [epson-156]..."
$cmd_compress $opt_compress ${backup_home}/${today}_epson-156.${ext} kuroiwa/share/epson-156/ > ${backup_home}/${today}_epson-156.log
#
echo "/bin/rm -rf $bogus"
/bin/rm -rf $bogus
