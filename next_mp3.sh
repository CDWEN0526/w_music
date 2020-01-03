#!/bin/bash
num=`ps axu | grep mplayer | grep -v grep | awk '{print $2}'`
sudo kill -9 ${num}
echo "切换下一首。。。"
