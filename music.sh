#!/bin/bash
cd `dirname $0`
lian=`ps axu | grep  music_lian | grep -v grep | wc -l`
clear
if [ ${lian} == 0 ];then
echo "正在获取网络播放信息，请稍等..."
./mp3.py  >> ./music.txt &
nohup ./music_lian.sh &
sleep 5
clear
fi

while true;do
echo -e " " 
echo -e "\033[31m ===树莓派网络音乐程序=== \033[0m"
echo -e "\033[34m     1、 切换歌曲\n     2、 调整音量\n     3、 播放音乐\n     4、 终止播放\n     5、 后台运行\n     6、 检查更新\n \033[0m"
gengxin=`git pull >/dev/null 2>&1`
if [[ $gengxin == "1" ]];then
echo -e "\033[31m 有更新，输入6进行更新程序 \033[0m"
fi
echo -e "\033[36m 请输入您的操作：\c \033[0m"
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
echo "由于网络原因，请耐心等待加载..."
sudo nohup ./mp3.sh &> /dev/null &
else
echo "正在播放，请勿重复执行播放..."
fi
sleep 5
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

