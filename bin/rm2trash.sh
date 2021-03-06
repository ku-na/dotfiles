#!/bin/zsh
trash=$HOME/.trash

if [ ! -d $trash ]
then
	mkdir -p $trash
fi
for i
do
	if [ -e $trash/$i ]; then
		DATE=`date "+%Y%m%d%H%M%S"`
		cp -a $i $trash/${i}_${DATE}
		/bin/rm $i -rf
	else
		cp -a $i $trash
		/bin/rm $i -rf
	fi
done
