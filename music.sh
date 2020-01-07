#!/bin/bash
cd `dirname $0`
lian=`ps axu | grep  music_lian | grep -v grep | wc -l`
clear
if [ ${lian} == 0 ];then
echo -e "请把耳机，或音响，插入树莓派上.\n正在获取网络播放信息，请稍等..."
./mp3_url.py  > ./music.txt &
nohup ./music_lian.sh 2> /dev/null &
sleep 5
clear
fi
testing=1
while true;do
echo -e " " 
echo -e "\033[31m ===树莓派网络音乐程序=== \033[0m"
echo -e "\033[34m     1、 切换歌曲\n     2、 调整音量\n     3、 播放音乐\n     4、 电影下载\n     5、 终止播放\n     6、 后台运行\n     7、 更新程序\n \033[0m"

if [[ $testing == 1 ]];then
git pull >/dev/null 2>&1
if [[ $? == "1" ]];then
echo -e "\033[31m 您好，发现有更新，输入\"7\"进行更新程序。 \033[0m"
fi
testing=0
fi

echo -e "\033[36m    请输入您的操作：\c \033[0m"
read  number
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
echo "请插入耳机，或音响到树莓派上\n由于网络原因，请耐心等待加载..."
sudo nohup ./mp3.sh &
else
echo "正在播放，请勿重复执行播放..."
fi
sleep 5
;;
"4")
echo "准备进入电影下载程序，请按照指示输入..."
sleep 2
clear
./dy.sh
;;
"5")
sudo ./kill_all_mp3.sh
music_lian_number=`ps axu | grep music_lian.sh | grep -v grep | awk '{print $2}'`
sudo kill -9 ${music_lian_number} 
echo "正在退出播放器..."
exit 0
;;
"6")
echo "后台运行中..."
exit 0
;;
"7")
echo "检查程序是否有更新..."
git fetch --all
git reset --hard origin/master && sudo chmod +x ./* -R
exit 0
;;
*)
echo "异常操作..."
sleep 1
;;
esac
clear
done

