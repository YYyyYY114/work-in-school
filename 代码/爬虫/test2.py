# import requests
# r = requests.get("http://www.baidu.com/", headers = {'User-Agent' : 'Mozilla/5.0'},timeout=10) #同时指定了 headers 和 timeout
# r.encoding='utf-8' #设定为页面的编码，即页面源码中 charset 的值
# print(r.text) #输出页面的 HTML 文本信息(调用.text)

import dns.resolver
a=dns.resolver.query("www.btbu.edu.cn","A") #’A’表示将主机名转换为 IP 地址
ip=a.response.answer[0].items[0].address #获得相应的 IP 地址如'202.120.224.81'
print(ip)


