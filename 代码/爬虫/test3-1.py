url = 'http://search.jd.com/Search'
qrydata = {
 'keyword':'互联网大数据',
 'enc':'utf-8'
}
lt = []
for k,v in qrydata.items():
    lt.append(k+'='+str(v))
query_string = 'G'.join(lt)
url = url+'?'+query_string
print(url)
