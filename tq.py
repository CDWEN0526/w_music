#!/usr/bin/python3
# -*- coding:utf-8 -*-
import requests
import json
ip=requests.get('http://icanhazip.com/').text.strip()
r=requests.post(url='http://ip.taobao.com/service/getIpInfo2.php', data={'ip': ip})
dizhi = r.json()
chengshi = dizhi['data']['city']
tq=requests.get('http://api.help.bj.cn/apis/weather2d/?id=' + chengshi).text
tianqi = json.loads(tq)
print(tianqi['city'] + "   温度:" +tianqi['temp'] + "   天气:" + tianqi['weather'])
