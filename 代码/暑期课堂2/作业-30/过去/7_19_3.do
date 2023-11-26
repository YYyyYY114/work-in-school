sort company 
gen group_x7 = group(5) 

forvalues i = 1/5{
qui reg invest mvalue kstock if group_x7 == `i', r 
qui outreg2 using "grunfeld.dta", append bdec(3) tdec(2) ctitle(`y')
est store groupx7_`i'
}
esttab groupx7_*, replace nogap compress b(%6.3f) s(N r2_a) se star(* 0.1 ** 0.05 *** 0.01) addnotes("*** 1% ** 5% * 10%")


sort year        
gen group_b = group(4)

cap erase "grunfeld.txt"
forvalues i = 1/4{
    qui reg invest mvalue kstock if group_b == `i', r   
    qui outreg2 using "grunfeld.dta", append bdec(3) tdec(2) ctitle(`y')
    est store groupb_`i'
}

esttab groupb_*, replace nogap compress b(%6.3f) s(N r2_a) se  star(* 0.1 ** 0.05 *** 0.01) addnotes("*** 1% ** 5% * 10%")

