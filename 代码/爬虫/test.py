# #导入 urllib.request 包中的 urlopen 模块
# from urllib.request import urlopen
# #导入 beautifulsoup 包
# from bs4 import BeautifulSoup
# html = urlopen("file:///D:/%E5%A4%A7%E4%BA%8C%E4%B8%8B/%E6%95%B0%E6%8D%AE%E9%87%87%E9%9B%86%E4%B8%8E%E6%B8%85%E6%B4%97/%E5%AE%9E%E9%AA%8C%E4%B8%80/test.html")#打印输出抓取到的网页内容
# #使用 beautifulsoup 创建网页解析对象 bsObj
# bsObj = BeautifulSoup(html, "html.parser")
# #打印输出网页中的标题
# print(bsObj.h1)

# from urllib.request import urlopen
# from bs4 import BeautifulSoup
# html = urlopen("file:///D:/%E5%A4%A7%E4%BA%8C%E4%B8%8B/%E6%95%B0%E6%8D%AE%E9%87%87%E9%9B%86%E4%B8%8E%E6%B8%85%E6%B4%97/%E5%AE%9E%E9%AA%8C%E4%B8%80/warandpeace.html")
# bsObj = BeautifulSoup(html, "html.parser")
# nameList = bsObj.findAll("span",{"class":"green"})
# for name in nameList:
#  print(name.get_text())
#
# from urllib.request import urlopen
# from bs4 import BeautifulSoup
# import re
# html = urlopen("http://www.pythonscraping.com/pages/page3.html")
# bsObj = BeautifulSoup(html, "html.parser")
# images = bsObj.findAll("img",{"src":re.compile("\.\.\/img\/gifts\/img.*\.jpg")})
# for image in images:
#  print(image["src"])

from urllib.request import urlopen
from bs4 import BeautifulSoup
import re
html = urlopen("http://www.pythonscraping.com/pages/page3.html")
bsObj = BeautifulSoup(html, "html.parser")
images = bsObj.findAll("img", {"src":re.compile("\.\.\/img\/gifts\/img.*\.jpg")})
for image in images:
 print(image["src"])