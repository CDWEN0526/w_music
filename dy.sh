#!/bin/bash
#作者：cdwen
#http://www.kk2w.cc网站电影爬取程序
IFS=$'\n'
which aria2c > /dev/null
if [ $? -ne 0 ];then
    echo "安装环境"
	sudo apt -y install aria2
fi
echo "数据来源于：http://www.kk2w.cc"
echo "此程序只提供电影下载，电视剧无法下载，下载过程中可能会导致音乐无法播放或卡顿..."
read -p "请输入你要下载的电影名：" dy_name

dy_url=`curl -s -d "wd=${dy_name}" -i http://www.kk2w.cc/index.php?m=vod-search | grep p1 | grep m1 | sed "s@\">@\n@g" | grep html | sed 's@href=\"@\n@g' | sed 's@title=\"@@g' | sed 's@\"@@g' | grep html`

a=0
for i in ${dy_url};do
	url=`echo $i | awk '{print $1}'`
	name=`echo $i | awk '{print $2}'`
	echo "${a}、电影名：${name}"
	new_url=`echo "http://www.kk2w.cc${url}"`
	eval a_${a}=${new_url}
	let a+=1
done

read -p "请输入你的选择：" ke
ke="a_${ke}"
x_url=`eval echo '$'"${ke}"`
down_url=`curl -s -i ${x_url} | sed 's@<a@\n<a@g'| sed 's@a>@a>\n@g' | grep mp4 | sed 's@href=@href=\n@g' | sed 's@<@<\n@g' | grep mp4 | sed 's@target=@@g' | sed 's@>@@g' | sed 's@<@@g' | sed 's@_self@@g' | sed 's@"@@g' | sed "s@'@|@g" `

if [ ! -n "${down_url}" ];then
	echo "未找到下载资源..."
	sleep 2
	exit 0
fi

x=0
for i in ${down_url};do
	w_url=`echo $i | awk -F '|' '{print $2}'`
	w_name=`echo $i | awk -F '|' '{print $NF}'`
	echo "${x}、${w_name}"
	eval x_${x}="'${w_url}'"
	let x+=1
done

read -p "请输入你的选择：" dos
dos="x_${dos}"
mp_url=`eval echo '$'"${dos}"`

read -p "请输入电影保存路径：" pwd_file
cd ${pwd_file}
sudo nohup aria2c  -x 3 -s 3 "${mp_url}" &
echo "正在后台下载，请耐心等待..."
echo "ps:如何判断是否下载完成，在保存路径下没有.aria2后缀的文件，即下载成功..."
chown 