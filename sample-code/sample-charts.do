
*** Urban Stata Scheme: urbanplots
*** Sample charts code
*** 01222023

cd ..\sample-plots

**# Setup: set scheme and fontface
set scheme urbanplots
graph set window fontface "Lato"

**# Bar/column chart
sysuse census, clear
collapse (sum) pop, by(region)
gen pop_mil = pop / 1000000

graph bar pop_mil, ///
	over(region) ///
	subtitle("{it:Population (millions)}") ///
	ytitle("") ///
	ylab(, glcolor(white))
graph export "bar.png", replace
	
**# Grouped bar/column chart
sysuse citytemp, clear

graph bar tempjan tempjuly, over(region) ///
	subtitle("{it:Average temperature (f)}") ///
	ylab(, glcolor(white)) ///
	legend(label(1 "January") label(2 "July"))
graph export "grouped-bar.png", replace	

**# Line chart
sysuse uslifeexp, clear

line le_wm le_bm year, ///
	subtitle("{it:Life expectancy (years)}") ///
	xtitle("") ///
	legend(label(1 "White Males") label(2 "Black Males"))
graph export "line.png", replace

**# Scatter plot with best fit line
sysuse auto, clear

gen label_indicator = inlist(make, "VW Diesel", "Plym. Arrow", "Olds 98", "Cad. Seville", "Toyota Celica") // outliers to label

corr mpg weight // store correlation coefficient
local rho = string(r(rho), "%03.2f")
di("`rho'")

twoway /// 
	(scatter mpg weight, msymbol(circle_hollow) msize(1.5)) || ///
	(scatter mpg weight if label_indicator == 1, ///
		msymbol(circle_hollow) msize(1.5) ///
		mlabel(make) mlabposition(7) mlabgap(.2) mlabsize(1.5) mlabcolor("0 0 0")) || ///
	(lfit mpg weight, lcolor("236 0 139") lwidth(.2)), ///
	legend(off) ///
	subtitle("{it:Mileage (mpg)}") ///
	xtitle("{it:Weight (lbs.)}") ///
	xlab(, noticks) ///	
	ylab(, noticks) ///
	text(11 4500 `"Corr = `rho'"')
graph export "scatter.png", replace
