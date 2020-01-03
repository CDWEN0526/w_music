#!/bin/bash
while true;do
./mp3.py  >> ./music.txt
 sleep 240
 rm -rf ./music.txt
./mp3_1.py >> ./music.txt
 sleep 240
 rm -rf ./music.txt
./mp3_2.py >> ./music.txt
 sleep 240
 rm -rf ./music.txt
./mp3_3.py >> ./music.txt
 sleep 240
 rm -rf ./music.txt
./mp3_4.py >> ./music.txt
 sleep 240
 rm -rf ./music.txt
./mp3_5.py >> ./music.txt
 sleep 240
 rm -rf ./music.txt
./mp3_12.py >> ./music.txt
 sleep 240
 rm -rf ./music.txt
./mp3_14.py >> ./music.txt
 sleep 240
 rm -rf ./music.txt
done
