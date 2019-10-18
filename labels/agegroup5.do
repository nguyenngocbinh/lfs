gen agegroup5=.
replace agegroup5 = 0 if age >=0 & age <=14
replace agegroup5=1 if age>=15 & age<=19
replace agegroup5=2 if age>=20 & age<=24
replace agegroup5=3 if age>=25 & age<=29
replace agegroup5=4 if age>=30 & age<=34
replace agegroup5=5 if age>=35 & age<=39
replace agegroup5=6 if age>=40 & age<=44
replace agegroup5=7 if age>=45 & age<=49
replace agegroup5=8 if age>=50 & age<=54
replace agegroup5=9 if age>=55 & age<=59
replace agegroup5=10 if age>=60 & age<=64
replace agegroup5=11 if age>=65 

#delimit;
label define agegroup5 
	0 "Tõ 0 - 14 tuæi"
	1 "Tõ 15 - 19 tuæi" 
	2 "Tõ 20 - 24 tuæi" 
	3 "Tõ 25 - 29 tuæi" 
	4 "Tõ 30 - 34 tuæi" 
	5 "Tõ 35 - 39 tuæi" 
	6 "Tõ 40 - 44 tuæi" 
	7 "Tõ 45 - 49 tuæi" 
	8 "Tõ 50 - 54 tuæi" 
	9 "Tõ 55 - 59 tuæi" 
	10 "Tõ 60 - 64 tuæi" 
	11 "Trªn 65 tuæi"
	99 "missing";
#delimit cr

gen agegroup5_new=.
replace agegroup5_new = -4 if age <=2
replace agegroup5_new = -3 if age >=3 & age <=4
replace agegroup5_new = -2 if age ==5
replace agegroup5_new = -1 if age >=6 & age <=10
replace agegroup5_new = 0 if age >=11 & age <=14
replace agegroup5_new=1 if age>=15 & age<=19
replace agegroup5_new=2 if age>=20 & age<=24
replace agegroup5_new=3 if age>=25 & age<=29
replace agegroup5_new=4 if age>=30 & age<=34
replace agegroup5_new=5 if age>=35 & age<=39
replace agegroup5_new=6 if age>=40 & age<=44
replace agegroup5_new=7 if age>=45 & age<=49
replace agegroup5_new=8 if age>=50 & age<=54
replace agegroup5_new=9 if age>=55 & age<=59
replace agegroup5_new=10 if age>=60 & age<=64
replace agegroup5_new=11 if age>=65 

#delimit;
label define agegroup5_new 
	-4 "Tõ 0 -2 tuæi"
	-3 "Tõ 3 -4 tuæi"
	-2 "5 tuæi"
	-1 "Tõ 6 - 10 tuæi"
	0 "Tõ 11 - 14 tuæi"
	1 "Tõ 15 - 19 tuæi" 
	2 "Tõ 20 - 24 tuæi" 
	3 "Tõ 25 - 29 tuæi" 
	4 "Tõ 30 - 34 tuæi" 
	5 "Tõ 35 - 39 tuæi" 
	6 "Tõ 40 - 44 tuæi" 
	7 "Tõ 45 - 49 tuæi" 
	8 "Tõ 50 - 54 tuæi" 
	9 "Tõ 55 - 59 tuæi" 
	10 "Tõ 60 - 64 tuæi" 
	11 "Trªn 65 tuæi"
	99 "missing";
#delimit cr

gen thanhnien = 1 if age>=15 & age<=24
recode thanhnien (.=2)

#delimit;
label define thanhnien
1 "Tõ 15 - 24 tuæi" 
2 "Trªn 25 tuæi";
#delimit cr
label values thanhnien thanhnien

gen trongtuoi =1 if age >=15 & age <=59 & gender ==1
replace trongtuoi = 1 if age >=15 & age <=54 & gender ==2
recode trongtuoi .=0 if age <=14
recode trongtuoi .=2

#delimit;
label define trongtuoi 
	0 "Tõ 0 - 14 tuæi"
	1 "N÷ tõ 15 - 54, Nam 15 - 59 tuæi" 
	2 "N÷ >=55, Nam >=60 tuæi" ;
#delimit cr
label values trongtuoi trongtuoi

capture drop nhomtuoi

gen nhomtuoi = 1 if age>=15 & age<=29
replace nhomtuoi =2 if age >=29 & age <=59 & gender ==1
replace nhomtuoi = 2 if age >=29 & age <=54 & gender ==2
replace nhomtuoi = 0 if age <=14 
recode nhomtuoi (.=3)

#delimit;
label define nhomtuoi
	0 "Tõ 0 - 14 tuæi"
	1 "Tõ 15 - 29 tuæi" 
	2 "N÷ tõ 29 - 54, Nam 29 - 59 tuæi" 
	3 "N÷ >=55, Nam >=60 tuæi", modify ;
#delimit cr
label values nhomtuoi nhomtuoi
