/* Author: NguyÔn Ngäc B×nh
   Organization: ILSSA
   First : 19/1/2015
*/

set more off

		foreach name in gender {
		
* do "F:\Dropbox\dofile\ldvl\setup_data_ldvl_2013.do"
local var `name'	// Note change categories
local year 2010	// Note change year 
capture mkdir F:\Dropbox\temp\ldvl\ldvl`year'\by`var'
cd "F:\Dropbox\temp\ldvl\ldvl`year'\by`var'"		
use "F:\dropbox\temp\ldvl\ldvl_`year'.dta", clear


capture mkdir "F:\Dropbox\temp\ldvl\ldvl`year'\by`var'\trongtuoi"
cd "F:\Dropbox\temp\ldvl\ldvl`year'\by`var'\trongtuoi"

for any economic_sector2 train0 train3 extra_hours : capture gen  X =0	
	keep if trongtuoi ==1  
// Mét sè chØ tiªu vÒ d©n sè
tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh lydokolv `var' ///
	[iw=weight] using Population_`year'By`var'.xls, f(0) replace	

// Lùc l­îng lao ®éng
tabout  gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh `var' ///
	if labour_force ==1 [iw = weight]  using Labour_force_`year'By`var'.xls, c(freq)  f(0)  replace // sè tuyÖt ®èi	
// Tû lÖ tham gia lùc l­îng lao ®éng
tabout  gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh `var' ///
	 [aw = weight]  using lfp_rate_`year'By`var'.xls, c(mean lfp_rate)  f(2 2)  sum replace 
// ViÖc lµm
tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
	if employment ==1 [iw=weight] using Employment_`year'By`var'.xls, f(0) replace
// ThÊt nghiÖp
tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh `var' ///
	if unemployment ==1 [iw=weight] using Unemployment_`year'By`var'.xls, f(0) replace
// Tû lÖ thÊt nghiÖp
tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh `var' ///
	[aw=weight] using Unemployment_rate_`year'By`var'.xls, c(mean unemployment_rate) f(2 2) sum replace
tabout  gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh ///
	time_tn prev_indus1  prev_nganh_N_C_D  prev_employment_status  prev_economic_sector prev_occup1 `var' ///
	if unemployment ==1 [iw=weight] using Prev_Unemployment_`year'By`var'.xls, f(0) replace
// ThiÕu viÖc lµm 
tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
	if underemployment ==1 [iw=weight] using Underemployment_`year'By`var'.xls, f(0) replace
// Tû lÖ thiÕu viÖc lµm
tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
	[aw=weight] using Underemployment_rate_`year'By`var'.xls, c( mean under_emp_rate)  f(2 2) sum replace
// Thêi gian lµm viÖc cña lao ®éng thiÕu viÖc lµm 
// TiÒn l­¬ng
tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
	if employment_status ==4 & income >0 [aw = weight]  using income_`year'By`var'.xls, c(mean income) f(2) sum replace
// Sè giê lµm thªm		
			tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector `var'  ///
				if employment ==1 [aw = weight]  using extra_hours_`year'By`var'.xls, c(mean extra_hours) f(2) sum replace
	}


