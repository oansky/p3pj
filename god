

import requests
from requests.exceptions import RequestException
from lxml import etree

count = 0

list_blue_key = range(12)
list_blue_count = [0]*12
dic_blue = dict(zip(list_blue_key, list_blue_count))
#print(dic_blue)

list_red_key = range(35)
list_red_count = [0]*35
dic_red = dict(zip(list_red_key, list_red_count))
#print(dic_red)

def get_page(url):
    try:
        headers = {
        'user-agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Mobile Safari/537.36',
        'accept-language': 'zh-CN,zh;q=0.9',
        'cache-control': 'max-age=0',
        'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8'
        }
        response = requests.get(url=url,headers=headers)
        # 更改编码方式，否则会出现乱码的情况
        response.encoding = "utf-8"
        if response.status_code == 200:
            return response.text
        return None
    except RequestException:
        return None

def parse_page(html):
    try:
        global count
        count+=1
        res = etree.HTML(html)
        red = res.xpath('//*[@class="smallRedball"]//text()')
        blue = res.xpath('//*[@class="smallBlueball"]//text()')
        #print(red+blue)
        for item in red:
            dic_red[item] += 1
        for item in blue:
            dic_blue[item] += 1
    except Exception as e:
        pass

def main(num):
    url = 'http://caipiao.163.com/t/award/dlt/{}.html'.format(str(num))
    html = get_page(url)
    parse_page(html)

if __name__ == '__main__':
    for num in range(17001, 17154):
        main(num)
    for num in range(18001, 18140):
        main(num)
    print("end...")
    print(dic_red)
    print(dic_blue)
    print("count："+str(count))

