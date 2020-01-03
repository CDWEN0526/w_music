#!/bin/bash
number=`ps axu | grep mplayer | grep -v grep | awk '{print $2}'`
for i in `ps aux | grep mp3.sh|grep -v grep|grep -v kill_all_mp3.sh | awk '{print $2}'`;do
	sudo kill -9 $i &> /dev/null
done
sudo kill -9 ${number} &> /dev/null

