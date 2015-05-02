cd "/Users/oliviadaoust/GitHub/From-Stata-to-R"

set more off
 
drop _all
clear
set obs 500
 
set seed 10101 
 
**** generates three normally distributed variables N(0,1)
gen x1 = invnormal(runiform())
gen x2 = invnormal(runiform())
gen u = invnormal(runiform())
 
**** sum stats (to be used for the 3D plot range)
sum x1 x2
 
**** generates interaction
gen x1x2 = x1*x2
 
**** y = xB + u
gen y = 0.04*x1 - 0.4*x2 + 2.2*x1x2 + u
 
**** regression
xi: reg y x1 x2 x1x2 
 
**** save coefficients
matrix b = e(b)
             
**** restricting to the three coefficient needed
mat coef = b[1,1..3] 
mat list coef // displays [coef]
 
**** transforms the matrix into a dataset
//!!change directory!! 
matsave coef, dropall replace 
 
**** save as dataset 
//!!change directory!! 
saveold "coef.dta", replace 
