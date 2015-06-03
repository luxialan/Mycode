#!/usr/bin/evn python
# -*- coding: cp936 -*-

import re                  #导入正则表达式模块
import urllib              #导入urllib模块，读取页面与下载页面需要用到
import os                  #define path for save
import sys

def getHtml(url):           #定义getHtml()函数，用来获取页面源代码
    page = urllib.urlopen(url)    #urlopen()根据url来获取页面源代码
    html = page.read()           #从获取的对象中读取内容
    return html

def getImage(html, save_p):  #定义getImage()函数，用来获取图片地址并下载
    #定义匹配图片地址的url的正则表达式
    #pat = r'"objURL":"(http://.*?\.jpg)"'   #baidu_def1
    pat = r'imgurl:&quot;(http://.*?\.jpg)&quot'  #ging_def1
    impat = re.compile(pat)   #对正则表达式进行编译，运行效率更高
    imagelist = impat.findall(html)  #使用findall()查找html中匹配正则表达式的图片url
    x = 0
    for imageurl in imagelist:
        print imageurl
        pic_name = save_p + '\\picture_%s.jpg' % x
        try:
            urllib.urlretrieve(imageurl, pic_name)  #urlretrieve()下载文件
            x +=1
        except:
            print 'some err in downing picture'

name = raw_input("enter the save file name： ")
save_p = 'E:\\Python\\beautiful\\my_own\\' + name + '_bing'

isExists=os.path.exists(save_p)

if not isExists:
    os.mkdir(save_p)
    uri = raw_input("the Internet link ")
    r = r'^http://'
    if re.match(r,uri):
        html2 = getHtml(uri)
    else:
        html2 = getHtml("http://" + uri)
    getImage(html2, save_p)
else:
    print 'Over!'

