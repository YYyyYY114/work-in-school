#导入 urllib.request 包中的 urlopen 模块
from urllib.request import urlopen

#导入 urllib.error 包中的 HTTPError，URLError 模块，用于捕获异常
from urllib.error import HTTPError,URLError

from bs4 import BeautifulSoup

#定义获取标题的 getTitle 函数，传入参数 url
def getTitle(url):
    try:
        html = urlopen(url) #抓取网页
    except (HTTPError,URLError) as e: #使用 try…except HTTPError as e,来捕获 HTTP响应异常
        print(type(e),":",e)
        return None #有异常返回 None
    try:
        bsObj = BeautifulSoup(html, "html.parser") #解析网页
        title = bsObj.body.h1
    except AttributeError as e: #使用 try…except AttributeError as e,来捕获值属性异常
        print(e)
        return None #有异常返回 None
    return title #无异常返回 title
#
# title = getTitle("http://exercise1.html")#异常网址 url
title = getTitle ("file:///D:/%E5%A4%A7%E4%BA%8C%E4%B8%8B/%E6%95%B0%E6%8D%AE%E9%87%87%E9%9B%86%E4%B8%8E%E6%B8%85%E6%B4%97/%E5%AE%9E%E9%AA%8C/%E5%AE%9E%E9%AA%8C%E4%B8%89/exercise1.html") #复制浏览器打开exercise1.html 时的网址 url

if title == None: #打印输出
    print("Title could not be found")
else:
    print(title)