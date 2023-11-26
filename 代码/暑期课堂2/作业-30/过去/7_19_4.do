gen yyear=0   //第一个十年
replace yyear=1 if inlist(year,1945,1946,1947,1948,1949,1950,1951,1952,1953,1954)  //第二个十年
tab yyear,gen(yyear)  //生成两个十年的虚拟变量
reg invest mvalue kstock i.yearr,r
