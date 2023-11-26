from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.edge.options import Options
import time
import getpass
from selenium.webdriver.common.by import By


def start_browser(uid, passwd):
    edge_options = Options()
    edge_options.add_argument('--headless')
    edge_options.add_argument('--disable-gpu')
    option = webdriver.EdgeOptions()
    option.binary_location = r'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'  # 这里添加edge的启动文件=>chrome的话添加chrome.exe的绝对路径
    browser = webdriver.Edge(r'C:\Program Files (x86)\Microsoft\Edge\Application\MicrosoftWebDriver',options=option)  # 这里添加的是driver的绝对路径
    browser.get('https://mail.163.com/#module=welcome.WelcomeModule%7C%7B%7D') #邮箱网址
    time.sleep(2)
    browser.find_element(By.ID,"loginDiv").send_keys(uid)
    browser.find_element(By.ID,"password").send_keys(passwd)
    browser.find_element(By.CLASS_NAME,"loginUrs").click()
    time.sleep(2)
    browser.switch_to.__class__('frame-nav')
    html = browser.page_source
    soup = BeautifulSoup(html,'html.parser')
    # print(soup)
    try:
        params = soup.select('.nui-tree-item-count')[0].text.strip()
        if str(params) != '':
            print("有"+str(params)+"封新邮件！")
        else:
            print("没有新邮件！")
    except IndexError as e:
        params = soup.select('._mail_tree_225_1379count')
        # print(str(params))
        # print("没有新邮件！")
    browser.quit()
    return

uid='GJJG_SHB'
passwd='-VPggrWWX9S8udf'
start_browser(uid, passwd)