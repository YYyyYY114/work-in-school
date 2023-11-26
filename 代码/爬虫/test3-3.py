#爬取必应壁纸
# 注意指定爬取内容的存储目录和爬取的页面数量
import os
import re
import urllib.request
import requests

def get_one_page(url):
    headers = {'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.69'}
    response = requests.get(url,headers = headers)
    if(response.status_code == 200):
        return response.text
    return None

def download(url,filename):
    filepath = 'D://大二下//数据采集与清洗//实验//实验三//picture//'+filename+'.jpg' #存储地址
    headers = {'user-agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.69'}
    if os.path.exists(filepath):
        return
    with open(filepath,'wb')as f:
        req = urllib.request.Request(url, headers=headers)
        response = urllib.request.urlopen(req)
        f.write(response.read())

def parse(html):
    pattern = re.compile('data-progressive="(.*?)".*?<h3>(.*?)</h3>')
    items = re.findall(pattern,html)
    for item in items:
        try:
            url = item[0].replace('800','1920').replace('480','1080')
            imagename = item[1].strip()
            rule = re.compile(r'[a-zA-z1-9()-/]')#[]用来表示一组字符【abc】匹配 a,b,或 c
            imagename = rule.sub('', imagename)
            download(url,imagename.strip())
            print(imagename,"正在下载")
        except Exception:
            continue

if __name__ == '__main__':
    for page in range(1,4):
        url = 'https://bing.ioliu.cn/?p='+str(page)
        print("正在抓取第", page, "页" ,url)
        html = get_one_page(url)
        parse(html)