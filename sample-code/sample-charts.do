
*** Urban Stata Scheme: urbanschemes
*** Sample charts code
*** 02092023

cd ..\sample-plots

**# Setup: set scheme and fontface
set scheme urbanschemes
graph set window fontface "Lato"

**# Bar/column chart - v1 (with y-axis labels)
sysuse census, clear
collapse (sum) pop, by(region)
gen pop_mill = pop / 1000000

graph bar pop_mil, over(region) /// // plot population (millions) by region
	subtitle("{it:Population (millions)}") /// // subtitle = y-axis title
	ytitle("") /// // remove y-axis title from side of plot
	ylab(, format(%2.0f) noticks) /// // format y-axis labels to two digits and remove ticks
	yscale(lcolor(white)) // remove y-axis line
graph export "bar-v1.svg", replace fontface(Lato)
graph export "bar-v1.emf", replace
graph export "bar-v1.png", replace
graph export "bar-v1.tif", replace

**# Bar/column chart - v2 (with bar labels)
sysuse census, clear
collapse (sum) pop, by(region)

graph bar pop, over(region) /// // plot population by region
	blabel(total, format(%12.0fc)) /// // label bars with total population, formatted with commas
	ytitle("") /// // remove y-axis title from side of plot
	ylab(, glcolor(white) noticks nolab) /// // remove grid lines, y-axis ticks, and y-axis labels
	yscale(lcolor(white)) // remove y-axis line
graph export "bar-v2.svg", replace fontface(Lato)
graph export "bar-v2.emf", replace
graph export "bar-v2.png", replace
graph export "bar-v2.tif", replace

**# Bar/column chart - v3 (with bar labels, vary colors)
sysuse census, clear
collapse (sum) pop, by(region)

graph bar pop, over(region) /// // plot population by region
	asyvars  /// // plot region populations as separate variables (to easily control colors)
	showyvars /// // show region labels on x-axis
	blabel(total, format(%12.0fc)) /// // label bars with total population, formatted with commas
	bargap(75) /// // increase space between bars
	ytitle("") /// // remove y-axis title from side of plot
	ylab(, glcolor(white) noticks nolab) /// // remove grid lines, y-axis ticks, and y-axis labels
	yscale(lcolor(white)) /// // remove y-axis line
	legend(off) // turn legend off
graph export "bar-v3.svg", replace fontface(Lato)
graph export "bar-v3.emf", replace
graph export "bar-v3.png", replace
graph export "bar-v3.tif", replace

**# Grouped bar/column chart - v1 (with y-axis labels)
sysuse citytemp, clear

graph bar tempjan tempjuly, over(region) /// // plot jan and june temp by region
	subtitle("{it:Average temperature (f)}") /// // subtitle = y-axis title
	ylab(, noticks) /// // remove y-axis ticks
	yscale(lc(white)) /// // remove y-axis line
	legend(label(1 "January") label(2 "July")) /// // relabel legend
	plotregion(margin(t = 6)) // make space on top of plot for legend
graph export "grouped-bar-v1.svg", replace fontface(Lato)
graph export "grouped-bar-v1.emf", replace	
graph export "grouped-bar-v1.png", replace
graph export "grouped-bar-v1.tif", replace

**# Grouped bar/column chart - v2 (with bar labels)
sysuse citytemp, clear

graph bar tempjan tempjuly, over(region) /// // plot jan and june temp by region
	blabel(total, format("%2.0f")) /// // label bars with temperatures formatted to two digits
	ylab(, glcolor(white) noticks nolab) /// // remove grid lines, y-axis ticks, and y-axis labels
	yscale(lc(white)) /// // remove y-axis line
	legend(label(1 "January") label(2 "July")) /// // relabel legend
	plotregion(margin(t = 12)) // make space on top of plot for legend
graph export "grouped-bar-v2.svg", replace fontface(Lato)
graph export "grouped-bar-v2.emf", replace	
graph export "grouped-bar-v2.png", replace
graph export "grouped-bar-v2.tif", replace

**# Horizontal bar chart - v1
sysuse auto, clear
split make, p(" ") 

graph hbar (mean) price, ///
	over(make1, sort(1) descending) /// // sort bars in descending order of 1st (only) variable
	subtitle("{it:Average price (dollars)}") //// // subtitle = y-axis title
	ytitle("") /// // remove y-axis title
	ylab(, noticks) /// // remove y-axis ticks
	yscale(lc(white)) /// // remove y-axis line
	plotregion(margin(b = 0 t = 0)) // remove gap at bottom and top of plot
graph export "horiz-bar-v1.svg", replace fontface(Lato)
graph export "horiz-bar-v1.emf", replace	
graph export "horiz-bar-v1.png", replace
graph export "horiz-bar-v1.tif", replace

**# Line chart - v1 
sysuse uslifeexp, clear

line le_wm le_bm year, /// // plot life expectancy over time by race
	subtitle("{it:Life expectancy (years)}") /// // subtitle = y-axis title
	ylab(0(10)80, noticks) /// // reset y-axis to begin at 0, remove y-axis ticks
	yscale(lc(white)) /// // remove y-axis line
	xtitle("") /// // remove unnecessary x-axis title ("Years")
	legend(label(1 "White Males") label(2 "Black Males")) /// // relabel legend
	plotregion(margin(b = 0 t = 6)) // remove gap at bottom of plot, make space on top of plot for legend
graph export "line-v1.svg", replace fontface(Lato)
graph export "line-v1.emf", replace
graph export "line-v1.png", replace
graph export "line-v1.tif", replace

**# Scatter plot with best fit line - v1
sysuse auto, clear

corr mpg weight // store correlation coefficient
local rho = string(r(rho), "%03.2f")
di("`rho'")

twoway /// 
	(scatter mpg weight, msize(1.5)) || /// // scatter mpg and weight
	(lfit mpg weight, lcolor("236 0 139") lwidth(.2)), /// // fit predicted line, change color and width
	subtitle("{it:Mileage (mpg)}") //// // subtitle = y-axis title
	xtitle("{it:Weight (lbs)}") /// // x-axis title
	xlab(, noticks) /// //	remove x-axis ticks
	ylab(, noticks) ///	// remove y-axis ticks
	legend(off) /// // turn off legend
	text(11 4450 `"Corr = `rho'"') // add correlation coefficient
graph export "scatter-v1.svg", replace fontface(Lato)
graph export "scatter-v1.emf", replace
graph export "scatter-v1.png", replace
graph export "scatter-v1.tif", replace

**# Histogram - v1
*https://www.stata.com/support/faqs/graphics/gph/graphdocs/histogram-of-continuous-variable-as-density/index.html
sysuse sp500, clear

histogram open, ///
	subtitle("{it:Density}") //// // subtitle = y-axis title
	ytitle("") /// // remove y-axis title
	xtitle("{it:Open price}") /// // x-axis title
	xlab(, noticks) /// //	remove x-axis ticks
	ylab(, noticks) // remove y-axis ticks
graph export "hist-v1.svg", replace fontface(Lato)
graph export "hist-v1.emf", replace
graph export "hist-v1.png", replace
graph export "hist-v1.tif", replace

**# Kernel density - v1
sysuse auto, clear

local options kernel(biweight) bwidth(5) recast(area) boundary color(%50) // set kernel density options

graph two ///
	(kdensity mpg if foreign, `options') /// // kernel density plot for foreign with options
	(kdensity mpg if !foreign, `options'), /// // kernel density plot for domestic with options
	subtitle("{it:Density}") //// // subtitle = y-axis title
	ytitle("") /// // remove y-axis title
	xtitle("{it:MPG}") /// // x-axis title
	legend(label(1 "Foreign") label(2 "Domestic")) /// // relabel legend
	plotregion(margin(b = 0)) // remove gap at bottom of plot
graph export "density-v1.svg", replace fontface(Lato)
graph export "density-v1.emf", replace
graph export "density-v1.png", replace
graph export "density-v1.tif", replace

**# Box plot - v1 *https://www.stata.com/support/faqs/graphics/gph/graphdocs/box-plot-of-two-variables-by-categorical-variable/index.html
sysuse bpwide, clear

graph box bp_before bp_after, over(agegrp) /// // box plot over age groups
	subtitle("{it:Blood pressure by age group}") /// // subtitle = y-axis title
	ylab(, noticks) ///	// remove y-axis ticks
	plotregion(margin(t = 10)) // make space on top of plot for legend
graph export "box-v1.svg", replace fontface(Lato)
graph export "box-v1.emf", replace
graph export "box-v1.png", replace
graph export "box-v1.tif", replace

