//数据合并与清理

import excel "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\原始数据.xlsx", sheet("Sheet1") firstrow
import excel "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\原始数据.xlsx", sheet("Sheet2") firstrow clear
gen 地区2=substr(地区,1,6)
gen year=年份
sort 地区2 year
save "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\1.dta"
sort year
save "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\1.dta", replace
import excel "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\汇率.xlsx", sheet("Sheet1") firstrow clear
sort year
save "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\2.dta"
use "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\泰尔指数测算.dta"
gen 地区2=substr(地区,1,6)
gen year=年份
sort 地区2 year
save "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\泰尔指数测算.dta", replace
import excel "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\数字普惠金融.xlsx", sheet("Provinces") firstrow clear
gen 地区2=substr(prov_name,1,6)
sort 地区2 year
save "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\3.dta"
import excel "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\产业结构合理化高级化2021.xlsx", sheet("1") firstrow clear
drop N O P 
drop Q R S T 
gen 地区2=substr(地区,1,6)
gen year=时间
sort 地区2 year
drop if 时间==.
sort 地区2 year
save "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\4.dta"
use "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\1.dta"
merge  year using C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\2
drop _m
sort 地区2 year
merge 地区2 year using C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\3
drop _m
sort 地区2 year
merge 地区2 year using C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\4
drop _m
sort 地区2 year
merge 地区2 year using C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\泰尔指数测算
drop _m
sort 地区2 year
sum index
gen duf=index/100
gen lngdp=ln(地区生产总值)
gen foreign=经营单位所在地进出口总额/10*人民币美元平均汇率/地区生产总值/10000
sum foreign
tab foreign
gen high=冯
gen rat=泰尔指数倒数
gen urb=城镇人口/年末常住人口
gen edu=普通高等学校/年末常住人口
gen innov=国内专利申请授权/(年末常住人口*10000)
keep if year>=2012&year<=2021

//描述性统计分析
sum theil duf lngdp foreign high rat urb edu innov
//相关性分析
pwcorr_a theil duf lngdp foreign high rat urb edu innov
//多重共线性检验
reg theil duf lngdp foreign high rat urb edu innov
estat vif
//回归分析
//OLS回归
reg theil duf lngdp foreign high rat urb edu innov
//模型效应检验
encode 地区2,gen(id)
xtset id year

xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,fe
est store fe
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,re
est store re
hausman fe re

xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,re
xttest0
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,re
hausman fe re
hausman fe re,constant sigmamore

xi:reg theil duf lngdp foreign high rat urb edu innov i.year
test _Iyear_2013 _Iyear_2014 _Iyear_2015 _Iyear_2016 _Iyear_2017 _Iyear_2018 _Iyear_2019 _Iyear_2020 _Iyear_2021
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,fe
test _Iyear_2013 _Iyear_2014 _Iyear_2015 _Iyear_2016 _Iyear_2017 _Iyear_2018 _Iyear_2019 _Iyear_2020 _Iyear_2021
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,re
test _Iyear_2013 _Iyear_2014 _Iyear_2015 _Iyear_2016 _Iyear_2017 _Iyear_2018 _Iyear_2019 _Iyear_2020 _Iyear_2021

//组间异方差
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,fe
xttest3
//组内自相关
xtserial   theil duf lngdp foreign high rat urb edu innov
//截面相关
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,fe
xtcsd,pes
xtcsd,fri
xtcsd,fre
//Hausman过度识别检验
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,re robust
xtoverid
//异方差、自相关、截面相关内容修正
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year ,fe r
xi:xtscc theil duf lngdp foreign high rat urb edu innov i.year ,fe

//内生性检验

xi:reg theil duf lngdp foreign high rat urb edu innov
est store ols
xi:ivregress 2sls theil (duf=l.duf l2.duf) lngdp foreign high rat urb edu innov
est store iv
hausman iv ols ,c sigmamore

xi:ivregress 2sls theil (duf=l.duf l2.duf) lngdp foreign high rat urb edu innov
estat endogenous
xi:ivregress 2sls theil (duf=l.duf l2.duf) lngdp foreign high rat urb edu innov i.id i.year,r
estat endogenous
xi:xtivreg2  theil (duf=l.duf l2.duf) lngdp foreign high rat urb edu innov  i.year,fe r endog(duf)

//内生性处理
xi:xtreg theil l.duf lngdp foreign high rat urb edu innov i.year ,fe r
xi:xtreg theil l2.duf lngdp foreign high rat urb edu innov i.year ,fe r
xi:xtivreg2  theil (duf=l.duf l2.duf)  lngdp foreign high rat urb edu innov i.year ,fe r gmm2s first
xi:xtivreg2  theil (duf=l.duf l2.duf l3.duf)  lngdp foreign high rat urb edu innov i.year ,fe r gmm2s first
xi:xtabond2  theil l.theil duf  lngdp foreign high rat urb edu innov i.year ,gmm(l.theil ,lag(1 2) collapse)  gmm(duf ,lag(2 3) collapse) iv(lngdp foreign high rat urb edu innov  i.year)  twostep robust constant small
xi:xtabond2  theil l.theil duf  lngdp foreign high rat urb edu innov i.year ,gmm(l.theil duf,lag(2 2) collapse) iv(lngdp foreign high rat urb edu innov i.year)  twostep robust constant small


//分组回归与U型曲线
import excel "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\地区划分.xlsx", sheet("三大区域") firstrow clear
gen 地区2=省份2
sort 地区2
save "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\5.dta", replace
use "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\1.dta"
sort 地区2
merge 地区2 using C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\5
drop _m
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year if area==1,fe r
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year if area!=1,fe r
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year if area==2,fe r
xi:xtreg theil duf lngdp foreign high rat urb edu innov i.year if area==3,fe r
gen duf2=duf*duf
xi:xtscc theil duf lngdp foreign high rat urb edu innov i.year if area==1,fe
xi:xtscc theil duf lngdp foreign high rat urb edu innov i.year if area!=1,fe
xi:xtscc theil duf lngdp foreign high rat urb edu innov i.year if area==3,fe
xi:xtreg theil duf duf2 lngdp foreign high rat urb edu innov i.year ,fe r
xi:xtreg theil duf duf2 lngdp foreign high rat urb edu innov i.year if area==1,fe r
xi:xtreg theil duf duf2 lngdp foreign high rat urb edu innov i.year if area!=1,fe r
xi:xtscc theil duf duf2 lngdp foreign high rat urb edu innov i.year if area==1,fe
sort 地区2 year
sort id year
xi:xtreg theil l.duf l.duf2 lngdp foreign high rat urb edu innov i.year if area==1,fe r
xi:xtreg theil l.duf l.duf2 lngdp foreign high rat urb edu innov i.year if area!=1,fe r
xi:xtreg theil l.duf l.duf2 lngdp foreign high rat urb edu innov i.year ,fe r
xi:xtivreg2  theil (duf duf2=l.duf l2.duf l.duf2 l2.duf2)  lngdp foreign high rat urb edu innov i.year ,fe r gmm2s first
xi:xtivreg2  theil (duf duf2=l.duf l2.duf l.duf2 l2.duf2)  lngdp foreign high rat urb edu innov i.year if area==1,fe r gmm2s first
xi:xtivreg2  theil (duf duf2=l.duf l2.duf l.duf2 )  lngdp foreign high rat urb edu innov i.year if area==1,fe r gmm2s first
xi:xtivreg2  theil (duf duf2=l.duf  l.duf2 l2.duf2 )  lngdp foreign high rat urb edu innov i.year if area==1,fe r gmm2s first
xi:xtivreg2  theil (duf duf2=l.duf l2.duf l3.duf l.duf2 l2.duf2 )  lngdp foreign high rat urb edu innov i.year if area==1,fe r gmm2s first

//门限效应
xi:xthreg  theil   lngdp foreign high rat urb edu innov i.year ,rx(duf) qx(lngdp) thnum(3) trim(0.01 0.01 0.05) grid(400) bs(200 200 200) robust
xi:xthreg  theil   lngdp foreign high rat urb edu innov i.year ,rx(duf) qx(lngdp) thnum(1) trim(0.01 ) grid(400) bs(200 ) robust
sum lngdp
save "C:\Users\55397\Desktop\视频\04数字普惠金融对城乡收入差距的影响研究\1.dta", replace
