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
		cp $i $trash/${i}_${DATE}
		/bin/rm $i
	else
		cp $i $trash
		/bin/rm $i
	fi
done
