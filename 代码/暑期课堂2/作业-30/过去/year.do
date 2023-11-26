gen theten=0      //生成第一个十年变量
replace theten=1 if year==1945 | year==1946 | year==1947 | year==1948 | year==1949 | year==1950 | year==1951 | year==1952 | year==1953 | year==1954     //生成第二个十年变量
bdiff,group(theten) model(reg invest mvalue kstock ) reps(100) detail
