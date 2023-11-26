from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
import time
import requests
from selenium.webdriver.common.by import By

def getnamepage(name):
    b.get('http://image.baidu.com/')
    search_box = b.find_element(By.ID,'kw')
    search_box.send_keys(name)
    search_box.send_keys(Keys.ENTER)
    time.sleep(5)

def download(imglist, num):
    # 选取大尺寸
    ele = b.find_element(By.ID,'sizeFilter')
    ActionChains(b).move_to_element(ele).perform()
    time.sleep(5)
    ele4 = b.find_element(By.XPATH,'//*[@id="sizeFilter"]/div/div[1]')  # 到网页中查找html中选取大尺寸按钮的xpath
    ActionChains(b).move_to_element(ele4).perform()
    time.sleep(5)
    ele4.click()
    time.sleep(5)
    # 打开第一张图片，在此界面中点击左右切换图片
    #
    ele1 = b.find_element(By.XPATH,'//*[@id="imgid"]/div/ul/li[2]/div/div/a/img')
    # 查找要爬取的第一张图片的 xpath
    ele1.click()
    b.switch_to.window(b.window_handles[1])  # 很重要的一步，切换窗口，否则页面找不到元素, pythonshell里面是b.switch_to_window
    x = 1
    for i in range(1, num + 1):
        # ele3=b.find_element_by_xpath('/html/body/div[1]/div[2]/div/span[2]/span')
        # ele3.click()
        # time.sleep(3)#为保险起见，设置一个睡眠和爬取的时间差
        ele2 = b.find_element(By.XPATH,'//*[@id="srcPic"]/img')
        # 查找网页当前显示的图片的 xpath
        img = ele2.get_attribute('src')  # 获取当前图片的 url 链接
        r = requests.get(img)
        if r.status_code == 200:
            path = 'D:\大二下\数据采集与清洗\实验\实验四\picture\%d.jpg' % x  # 设置图片存
            # 储路径
            print('正在爬取 ' + img)
            with open(path, 'wb') as f:
                f.write(r.content)
                time.sleep(1)
                f.close()
                print('爬取成功')
                x += 1
            ele3 = b.find_element(By.XPATH,'//*[@id="container"]/span[2]')  # 查找“下一张”的 xpath
            ele3.click()
            # time.sleep(3)
            # 跳到下一张
        else:
            ele3 = b.find_element(By.XPATH,'//*[@id="container"]/span[2]')  # 查找“下一张”的 xpath
            ele3.click()
            time.sleep(1)
            continue

if __name__ == "__main__":
    b = webdriver.Chrome()
    name = '大海'  # 自定义要搜索的内容
    num = 30
    imglist = []
    getnamepage(name)
    download(imglist, num)
    b.close()
