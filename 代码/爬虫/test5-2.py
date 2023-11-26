from lxml import etree
import urllib.request
# import urllib.parse
# from bs4 import BeautifulSoup

response = urllib.request.urlopen('file:///D:/%E5%A4%A7%E4%BA%8C%E4%B8%8B/%E6%95%B0%E6%8D%AE%E9%87%87%E9%9B%86%E4%B8%8E%E6%B8%85%E6%B4%97/%E5%AE%9E%E9%AA%8C/%E5%AE%9E%E9%AA%8C%E4%BA%94/htmlParser_test4-1.html')
myStr = response.read().decode('utf-8')

content = etree.HTML(myStr)

rows=content.xpath('//div[@class="footer"]/a/@href')[0]
print(rows)