//
// Read In Data;
// (Note: Change path name so that it is appropriate for your computer)
  
  clear
  use "/Users/orangeyu/Desktop/DATA_DID.dta"

// **************************************************************
// ***** /* Table 1: Variable definitions */ ******
// **************************************************************

// 	 ID year policy y treated x1 x2 x3 x4


// **************************************************************
// ***** /* Table 2: Descriptive statistics */ ******
// **************************************************************

  cd "/Users/orangeyu/Desktop"

  outreg2 using Table2_描述性统计.docx, replace sum(log) keep(y x1 x2 x3 x4) title(Descriptive statistics)
  
 
// **************************************************************
// ***** /* Table 3: Basic results */ ******
// **************************************************************

   xtset ID year 
   
   gen post = (year >= policy_year)
   
   gen x = treated * post

   reg y x treated post, r
   est sto a1
 
   reg y x treated post x1 x2, r
   est sto a2
   
   reg2docx a1 a2 using Table3_基准回归.docx, replace scalars(N r2(%9.3f)) b(%9.3f) t(%7.2f) title("Table3") depvar

   
// **************************************************************
// ***** /* Figure 1 */ ******
// **************************************************************

   egen mean_y = mean(y), by(year treated)
   
   graph twoway (connect mean_y year if treated==1, sort) (connect mean_y year if treated==0, sort lpattern(dash)), ///  
   xline(2012, lpattern(dash) lcolor(gray)) ///
   ytitle("y") xtitle("year") ///
   legend(label(1 "treat") label(2 "control")) ///
   xlabel(2006 (1) 2018) graphregion(color(white))
   
   
// **************************************************************
// ***** /* Figure 2 */ ******
// **************************************************************
   

//  ssc install coefplot 

  gen policy_shock = year - 2012

  tab policy_shock

  replace policy_shock = -3 if policy_shock < -3

  replace policy_shock = 3 if policy_shock > 3


  forvalues i = 3(-1)1{

  gen pre_`i' = (policy_shock == -`i' & treat == 1)

  }

  gen current = (policy_shock == 0 & treat == 1)

  forvalues j = 1(1)3{

  gen post_`j' = (policy_shock == `j' & treat == 1)

  }

  drop pre_1

  xtreg y pre_* current post_* i.year, fe r

  coefplot, baselevels ///
  keep(pre_* current post_*) ///
  vertical ///
  yline(0,lcolor(edkblue*0.8)) ///
  xline(3, lwidth(vthin) lpattern(dash) lcolor(teal)) ///
  ytitle("Dynamic effect", size(small)) ///
  xtitle("policy_shock", size(small)) ///
  addplot(line @b @at) ///
  ciopts(lpattern(dash) recast(rcap) msize(medium)) ///
  msymbol(circle_hollow) ///
  scheme(s1mono)



