#!/bin/bash
cd `dirname $0`
lian=`ps axu | grep  music_lian | grep -v grep | wc -l`
if [ ${lian} == 0 ];then
echo "正在获取网络播放信息，请稍等..."
./mp3.py  >> ./music.txt &
nohup ./music_lian.sh &
sleep 5
clear
fi

while true;do 
echo -e "\n==树莓派网络音乐程序=="
echo -e "  1、切换歌曲\n  2、调整音量\n  3、播放音乐\n  4、终止播放\n  5、后台运行\n  6、检查更新\n"
read -p "请输入您的操作：" number
echo -e  "\n=======开始执行操作=======\n"
case $number in 
"1")
./next_mp3.sh
sleep 2
;;
"2")
./yin.sh
;;
"3")
mp3_num=`ps aux| grep mp3.sh | grep -v grep | wc -l`
if [ $mp3_num == 0 ];then
sudo nohup ./mp3.sh &> /dev/null &
else
echo "正在播放，请勿重复执行播放..."
fi
sleep 2
;;
"4")
sudo ./kill_all_mp3.sh
music_lian_number=`ps axu | grep music_lian.sh | grep -v grep | awk '{print $2}'`
sudo kill -9 ${music_lian_number}
echo "正在退出播放器..."
exit 0
;;
"5")
echo "后台运行中..."
exit 0
;;
"6")
echo "检查程序是否有更新..."
git pull
exit 0
;;
*)
echo "异常操作..."
sleep 2
;;
esac
clear
done

