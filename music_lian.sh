#!/bin/bash
while true;do
./mp3.py  >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
./mp3_1.py >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
./mp3_2.py >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
./mp3_3.py >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
./mp3_4.py >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
./mp3_5.py >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
./mp3_12.py >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
./mp3_14.py >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
done
