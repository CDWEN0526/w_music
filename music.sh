#!/bin/bash
cd `dirname $0`
paths=`dirname $0`
lian=`ps axu | grep  music_lian | grep -v grep | wc -l`
clear
if [ ! -d "${paths}/music_file" ];then
mkdir ${paths}/music_file
fi
if [ ${lian} == 0 ];then
echo -e "请把耳机，或音响，插入树莓派上。\n正在获取网络播放信息，请稍等..."
music_file_ls=`ls ${paths}/music_file | wc -l`
if [ ${music_file_ls} == 0 ];then
./mp3_url.py "${paths}/music_file"
fi
nohup ./music_lian.sh  2> /dev/null &
nohup mplayer ./mp3play.mp3 2>/dev/null &
sleep 5
clear
fi
testing=1
#tianqi=`./tq.py`
while true;do
echo -e "\033[36m作者:CDWEN  更新时间：2020/1/15\033[0m" 
#echo -e "${tianqi}"
echo -e "\033[31m ===树莓派网络音乐程序=== \033[0m"
echo -e "\033[34m     0、 暂停开始\n     1、 切换歌曲\n     2、 调整音量\n     3、 播放音乐\n     4、 电影下载\n     5、 终止程序\n     6、 歌曲搜索\n     7、 后台运行\n     8、 更新程序\n \033[0m"

if [[ $testing == 1 ]];then
git pull >/dev/null 2>&1
if [[ $? == "1" ]];then
echo -e "\033[31m您好，发现有更新，输入\"8\"进行更新程序。 \033[0m"
fi
testing=0
fi

##
aria2c_num=`ps axu | grep aria2c | grep -v gre | wc -l`
if [[ ${aria2c_num} != 0 ]];then
	bai=`sudo cat  /home/pi/Videos/nohup.out | grep % | tail -n 1 | awk -F '(' '{print $2}' | awk -F ')' '{print $1}'`
	if [ ! -n ${bai} ];then
		bai="0%"
	fi
	echo -e "\033[35m    电影完成下载:${bai}\033[0m"
	echo -e "\033[35m    按回车刷新下载进度...\033[0m"
else
    mplay_info=`ps axu | grep mplayer | grep -v grep | wc -l`
	if [[ ${mplay_info} == 0 ]];then
	echo -e "\033[35m无下载项         播放暂停\033[0m"
	sudo rm -rf /home/pi/Videos/nohup.out
	else 
	echo -e "\033[35m无下载项         正在播放\033[0m"
	sudo rm -rf /home/pi/Videos/nohup.out
	fi
fi
###
echo -e "\033[36m    请输入您的操作：\c \033[0m"
read  number


echo -e  "\n=======开始执行操作=======\n"
case $number in 
"0")
number_mplayer=`ps axu | grep mplayer | grep -v grep`
jc_mplayer=`echo ${number_mplayer} | awk '{print $2}'`
info_mplayer=`echo ${number_mplayer} | awk '{print $8}'`
if [[ $info_mplayer == "S"* ]];then
sudo kill -STOP ${jc_mplayer}
echo "暂停播放"
else
sudo kill -CONT ${jc_mplayer}
echo "继续播放"
fi
sleep 2
;;
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
echo -e "请插入耳机，或音响到树莓派上。\n由于网络原因，请耐心等待加载..."
sudo nohup ./mp3.sh 2>/dev/null &
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
#音乐搜索功能
"6")
sudo ./kill_mplay_mp3.sh
echo "进入歌曲搜索程序，暂停当前播放..."
sleep 2
clear
#搜索页面效果展示
echo "=========音乐搜索先锋========="
echo ""
echo -e "\033[34m    1、网易\n    2、酷狗\n    3、百度\n\033[0m"
read -p "请输入你要选择的搜索源：" sou

case $sou in
"1")
echo "进入网易搜索引擎."
sleep 1
clear
echo "资源来自：http://music.zhuolin.wang/"
read -p "请输入你要搜索的歌曲/歌手：" musicc 
./sousuo_wangyi.py ${musicc}
sleep 2
;;

"2")
echo "进入酷狗搜索引擎."
sleep 1
clear
echo "资源来自：http://music.zhuolin.wang/"
read -p "请输入你要搜索的歌曲/歌手：" musicc 
./sousuo_kugou.py ${musicc}
sleep 2
;;
"3")
echo "进入百度搜索引擎."
sleep 1
clear
echo "资源来自：http://music.zhuolin.wang/"
read -p "请输入你要搜索的歌曲/歌手：" musicc 
./sousuo_baidu.py ${musicc}
sleep 2
;;
esac

######
;;
"7")
echo "后台运行中..."
exit 0
;;
"8")
echo "检查程序是否有更新..."
git fetch --all
git reset --hard origin/master && sudo chmod +x ./* -R
exit 0
;;
*)
echo "正在刷新操作..."
sleep 1
;;
esac
clear
done

