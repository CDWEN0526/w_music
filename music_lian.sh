#!/bin/bash
while true;do
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
./mp3_8.py >> ./music_two.txt
mv ./music_two.txt ./music.txt
 sleep 240
done
