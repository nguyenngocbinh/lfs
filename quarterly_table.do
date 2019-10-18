/* Author: NguyÔn Ngäc B×nh
   Organization: ILSSA
   First : 19/1/2015
   Note: §æi gi¸ trÞ i ë 2 chç
*/

set more off
		foreach  name in ttnt {
* do "F:\Dropbox\dofile\ldvl\setup_data_ldvl_2013.do"
local var `name'	// Note change categories
local year 2016	// Note change year 
capture mkdir F:\Dropbox\temp\ldvl\ldvl`year'\by`var'
cd "F:\Dropbox\temp\ldvl\ldvl`year'\by`var'"	
use "F:\dropbox\temp\ldvl\ldvl_`year'_q1-4.dta", clear
for any economic_sector2 train0 train3 extra_hours : capture gen  X =0	

	forvalues i=4/4 {
	// Mét sè chØ tiªu vÒ d©n sè
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh `var' ///
		if ky_3t ==`i'   [iw = w_p_q] using Population_`year'Q`i'By`var'.xls, f(0) replace	
	}	
	keep if age >=15 	
	
	forvalues i=4/4{	
	// Mét sè chØ tiªu vÒ d©n sè
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh lydokolv `var' ///
		if age >=15 & ky_3t ==`i'   [iw = w_p_q] using Population15_`year'Q`i'By`var'.xls, f(0) replace	
	// Lùc l­îng lao ®éng
	tabout  gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh `var' ///
		if labour_force ==1 &  ky_3t ==`i'   [iw = w_p_q] 	using Labour_force_`year'Q`i'By`var'.xls, f(0)  replace 	
	// Tû lÖ tham gia lùc l­îng lao ®éng
	tabout  gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh `var' ///
		 if ky_3t ==`i' [aw = w_p_q]  using lfp_rate_`year'Q`i'By`var'.xls, c(mean lfp_rate)  f(2 2)  sum replace 
	// ViÖc lµm
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
		if employment ==1 &  ky_3t ==`i'   [iw = w_p_q]  using Employment_`year'Q`i'By`var'.xls, f(0) replace
	// ThÊt nghiÖp
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh time_tn  `var' ///
		if unemployment ==1 &  ky_3t ==`i'   [iw = w_p_q]  using Unemployment_`year'Q`i'By`var'.xls, f(0) replace
	// Tû lÖ thÊt nghiÖp
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh time_tn `var'  ///
		if  ky_3t ==`i'   [aw = w_p_q]  using Unemployment_rate_`year'Q`i'By`var'.xls, c(mean unemployment_rate) f(2 2) sum replace
	// ViÖc lµm tr­íc khi thÊt nghiÖp
	tabout  gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh ///
	time_tn prev_indus1  prev_nganh_N_C_D  prev_employment_status  prev_economic_sector prev_occup1  `var' ///
		if prev_nganh_N_C_D !=99 & unemployment ==1 &  ky_3t ==`i'   [iw = w_p_q]  using  Prev_Unemployment_`year'Q`i'By`var'.xls, f(0) replace
	// ThiÕu viÖc lµm 
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
		if underemployment ==1 &  ky_3t ==`i'   [iw = w_p_q]  using Underemployment_`year'Q`i'By`var'.xls, f(0) replace
	// Tû lÖ thiÕu viÖc lµm
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
		if  ky_3t ==`i'   [aw = w_p_q]  using Underemployment_rate_`year'Q`i'By`var'.xls, c( mean under_emp_rate)  f(2 2) sum replace
		
	//  Sè giê lµm viÖc cña lao ®éng co viÖc lµm 
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
		if employment ==1 &  ky_3t ==`i'   [aw = w_p_q]  using WeekHourEmployment_`year'Q`i'By`var'.xls, c(mean weekhour) f(2) sum  replace
		
	//  Sè giê lµm viÖc cña lao ®éng thiªu viÖc lµm 
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
		if underemployment ==1 &  ky_3t ==`i'   [aw = w_p_q]  using WeekHourUnderemployment_`year'Q`i'By`var'.xls, c(mean weekhour) f(2) sum replace
		
	// TiÒn l­¬ng/ thu nhap
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector economic_sector2 `var'  ///
		if employment_status ==4 & income >0 & ky_3t ==`i'  [aw = w_p_q]  using income_`year'Q`i'By`var'.xls, c(mean income) f(2) sum replace

	// Sè giê lµm thªm		
	tabout gender ttnt region6 regHN_HCM  train train2 train0 train3 agegroup5 thanhnien nhomtuoi tdvh nganh_N_C_D occup1 indus1 employment_status economic_sector `var'  ///
		if employment ==1 &  ky_3t ==`i' [aw = w_p_q]  using extra_hours_`year'Q`i'By`var'.xls, c(mean extra_hours) f(2) sum replace
// Sè giê lµm viÖc trªn d­íi 20 giê
	capture gen temp_weekhour = 1 if weekhour <= 20
	recode temp_weekhour .=2 if weekhour >20
	label var temp_weekhour "Lao ®éng thieu viec lµm "
	tabout gender  ttnt nganh_N_C_D employment_status economic_sector economic_sector2 temp_weekhour  [aw=w_p_q] ///
		if underemployment ==1  & ky_3t ==`i' & age >=15 using WeekHour_20_un_`year'Q`i'By`var'.xls, c( row) f(2 2) replace
	label var temp_weekhour "Lao ®éng co viec lµm "
	tabout gender  ttnt nganh_N_C_D employment_status economic_sector economic_sector2 temp_weekhour  [aw=w_p_q] ///
		if employment ==1  & ky_3t ==`i' & age >=15 using WeekHour_20_em_`year'Q`i'By`var'.xls, c( row ) f(2 2)  append
                      }
					  
}



