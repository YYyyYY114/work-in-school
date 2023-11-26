from bs4 import BeautifulSoup
from lxml import etree
text = """
<table>
 <td>姓名</td><td>年龄</td></tr>
 <td>张三</td><td>25</td></tr>
 <td>李四</td><td>20</td></tr>
</table>
"""
soup = BeautifulSoup(text,"html.parser")
print(soup.prettify())
#name = soup.select("td")[0]
html = etree.HTML(soup.prettify())
name = html.xpath("//tbody/tr[1]/td[1]/text()")
print(name)
