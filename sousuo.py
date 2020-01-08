#!/usr/bin/python3
# -*- coding:utf-8 -*-
import requests
import re
import json
import time,datetime
import sys
import os

t = time.time()
times = str(round(t * 1000))
#music_name = input("请输入你要搜索的音乐：")
music_name = sys.argv[1]
data = {
    'types': 'search',
    'count': 20,
    'source': 'baidu',
    'pages': 1,
    'name': music_name,
}
header = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36',
        }
r = requests.post("http://music.zhuolin.wang/api.php?callback=jQuery111305558783245103223_" + times, data=data ,headers=header,allow_redirects=False)
id_num = r.text


pattern = re.search(r'\[.*\]', id_num , re.M|re.I)
pattern2 = re.search(r'j.*\(', id_num , re.M|re.I)
shijian = pattern2.group().replace('(','')
json_id = pattern.group()
json_id = json.loads(json_id)
a = 1
new_list = []
for i in json_id:
    i['num'] = a
    print(str(i['num']) + "、歌名:" + str(i['album']) + "  ||  歌手:" + str(i['artist']))
    a += 1
    new_list.append(i)

number_num = input("请输入你的选择：")

for lins in new_list:
    if int(lins['num']) == int(number_num):
        json_new_id = lins['id']
        new_url = "http://music.zhuolin.wang/api.php?callback=jQuery111305558783245103223_" + times 
        datas = {
            'types':'url',
            'id': json_new_id,
            'source': 'baidu',
        }
        header = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36',
        }
        mp3_api = requests.post(new_url,data=datas,headers=header).text
        mp3_zhz = re.search(r'\{.*\}', mp3_api , re.M|re.I)
        mp3_json = mp3_zhz.group()
        mp3_json = json.loads(mp3_json)
        mp3_json_url = mp3_json['url']
        if len(mp3_json_url) > 0:  
            sou_url = 'nohup mplayer ' + mp3_json_url + ' 2>/dev/null &'
            os.system(sou_url)
        else:
            print("当前选项无资源...")