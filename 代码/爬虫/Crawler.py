# encoding=utf-8
from bs4 import BeautifulSoup
import requests
import re
import time
import UrlSequence as urls

class Crawler:
    def __init__(self, base_url):
        # 初始化任务
        self.UrlSequence = urls.UrlSequence()
        # 增加种子 URL，作为未爬行任务
        self.UrlSequence.Unvisited_Add(base_url)

    # 爬行的主过程
    def crawling(self, base_url, max_count):

        # 当爬行任务非空，并且爬行的页面没有超过设定值时， 一直爬行
        while self.UrlSequence.UnvisitedIsEmpty() is False and self.UrlSequence.Visited_Count() <= max_count:
            # 深度优先
            visitUrl = self.UrlSequence.Unvisited_Pop()
            print("External url \"%s\"" % visitUrl)
            if visitUrl in self.UrlSequence.visited or visitUrl is None or visitUrl == "":
                continue
            # 抓取页面，并提取页面中的超链接到 links 中
            links = self.getLinks(visitUrl)
            # 保存到已抓取的任务中
            self.UrlSequence.Visited_Add(visitUrl)
            # 将新提取出的超链接保存到未抓取的任务中
            for link in links:
                self.UrlSequence.Unvisited_Add(link)


# 获得 URL 页面中的超链接
def getLinks(self, url):
    links = []  # 保存超链接的列表
    data = self.getPageSource(url)
    if data[0] == "200":
        # Create a BeautifulSoup object
        soup = BeautifulSoup(data[1], 'lxml')
        # 通过 <a href=".*"> 查找超链接
        a = soup.findAll("a", {"href":re.compile(',*') })
        for href in a:
            if href["href"].find("http://") != -1 or href["href"].find("https://") != -1:
                links.append(href["href"])
    return links


# 获得 URL 对应的 HTML 源码
def getPageSource(self, url, timeout=100, coding=None):
    try:
        # 如果要设定多个 headers 属性，用逗号隔开
        page = requests.get(url, headers={'User-Agent': 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)'})
        page.encoding = 'utf-8'
        html = page.text

        return ["200", html]
    except Exception as e:
        print('错误：' + str(e))
        return [str(e), None]
