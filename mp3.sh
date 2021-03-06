#!/bin/bash
dir='music_file'
number=`ls ./${dir} | wc -l`
comm=`which mplayer 2> /dev/null`
if [[ $comm == "" ]];then
  sudo apt-get install mplayer
else
while true;do
	num=$(($RANDOM%${number}))
	mp3=`ls ./${dir} | sort -n | sed -n "${num}p"`
	if [[ -n $mp3 ]];then
    mplayer ./${dir}/${mp3}
	rm -rf ./${dir}/${mp3}
	fi
done
fi		           
