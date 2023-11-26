//异质性检验
//两个十年对比
gen theten=0      //生成第一个十年变量
replace theten=1 if year==1945 | year==1946 | year==1947 | year==1948 | year==1949 | year==1950 | year==1951 | year==1952 | year==1953 | year==1954     //生成第二个十年变量
bdiff,group(theten) model(reg invest mvalue kstock) reps(100) detail  //对比两组数据回归的结果
//画图
twoway (line invest mvalue if theten==0, sort) (line invest mvalue if theten==1, sort) 
//四个五年对比
sort year          //排序
gen group_b = group(4)  //利用循环生成虚拟变量，比较四组年份的回归结果
forvalues i = 1/4{
    qui reg invest mvalue kstock if group_b == `i', r   
    est store groupb_`i'
}
esttab groupb_*, replace nogap compress b(%6.3f) s(N r2_a) se  star(* 0.1 ** 0.05 *** 0.01) addnotes("*** 1% ** 5% * 10%")
//画图
xtline invest, overlay t( mvalue ) i( group_b )
