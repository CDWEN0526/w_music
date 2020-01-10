#!/bin/bash
a=`pwd`
while true;do
if [[ `ls ./music_file | wc -l` -le 2 ]];then
./mp3.py "${a}/music_file"
fi
sleep 5
if [[ `ls ./music_file | wc -l` -le 2 ]];then
./mp3_1.py "${a}/music_file"
fi
sleep 5
if [[ `ls ./music_file | wc -l` -le 2 ]];then
./mp3_2.py "${a}/music_file"
fi
sleep 5
if [[ `ls ./music_file | wc -l` -le 2 ]];then
./mp3_3.py "${a}/music_file"
fi
sleep 5
if [[ `ls ./music_file | wc -l` -le 2 ]];then
./mp3_4.py "${a}/music_file"
fi
sleep 5
if [[ `ls ./music_file | wc -l` -le 2 ]];then
./mp3_8.py "${a}/music_file"
fi
sleep 5
done
