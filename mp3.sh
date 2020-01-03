#!/bin/bash
dir='music.txt'
number=`cat ./${dir} | wc -l`
comm=`which mplayer 2> /dev/null`
if [[ $comm == "" ]];then
  sudo apt-get install mplayer
else
while true;do
	num=$(($RANDOM%${number}))
	mp3=`cat ./${dir} | sort -n | sed -n "${num}p"`
	mplayer ${mp3}
done
fi		           
