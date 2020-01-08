#!/bin/bash
for i in `ps aux | grep mp3.sh|grep -v grep|grep -v kill_mplay_mp3.sh | awk '{print $2}'`;do
	sudo kill -9 $i
done
number=`ps axu | grep mplayer | grep -v grep | awk '{print $2}'`
sudo kill -9 ${number}


