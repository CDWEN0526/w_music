#!/usr/bin/python3
# -*- coding:utf-8 -*-
import requests
import json
import re
import os
import sys
import random
path = sys.argv[1]
url = 'https://player.lmih.cn/api/playerlist'
data = {
    'id':'155782152289'
}
lists = []
url_requests = requests.get(url,params=data)
songid = url_requests.text 
matchobj = re.finditer( '\"songIds\":.*?]',songid)
for match in matchobj:
    songid = eval('{' + match.group() + '}')
    lists.append(songid)
#歌曲列表选择lists[x]
number = lists[7]['songIds']
random.shuffle(number)
zhizhen = 0
mp3_url = "https://player.lmih.cn/api/musicUrl"
for i in number:
    if zhizhen == 5:
        break
    mp3_data = {
        'songId': i,
        'type':'wy',
        'id':'155782152289'
    }
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36'
    }
    mp3_head = requests.get(mp3_url,headers=headers,params=mp3_data,allow_redirects=False)
    try:
        mp3 = mp3_head.headers['location']
    except KeyError:
        #print("未找到下载资源。。。")
        continue
    mp3_name = path + '/' + str(i) + '.mp3'

    download = requests.get(mp3,headers=headers)
    if os.path.exists(mp3_name) == False:
        with open(mp3_name,'wb') as files:
            #print("创建" + str(i) +"的下载。。。")
            files.write(download.content)
    else:
        pass
    zhizhen +=1

