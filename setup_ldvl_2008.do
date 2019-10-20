/*
Author: Mr NguyÔn Ngäc B×nh
Email: nguyenngocbinhNEU@yahoo.com nanabi
First : 7/11/2012
Last update: 18/1/2013
*/
set more off
global data "D:\GoogleDrive\Data\Ldvl"
global temp "E:\Dropbox\temp\ldvl"

use "$data\ldvl_2008.dta", clear
recode tinh 28 =1		// tØnh Hµ T©y
// T¹o biÕn vïng kinh tÕ
do "E:\Dropbox\dofile\labels\region6.do"

gen dantoc = p5a
// T×nh tr¹ng h«n nh©n 
gen marital_status = p17
recode marital_status (5=4)
#delimit;
label define marital_status
1 " Ch­a cã vî/ chång"
2 " §· cã vî/ chång"
3 " Gãa"
4 " Ly h«n/ ly th©n"
99 "Mising";
#delimit cr

// Giíi tÝnh
gen gender = p3
label define gender 1"Nam" 2 "N÷" 99"Missing"

do "E:\Dropbox\dofile\labels\agegroup5.do"
// B»ng cÊp cao nhÊt
// Recode nhung nguoi thuoc CNKT khong bang thanh ko co cmkt
gen train = p16
recode train (7=8)
recode train (6=7) 
recode train(2=1)
#delimit;
label define train 
1	"Kh«ng cã CMKT"

3	"S¬ cÊp nghÒ"
4	"Trung cÊp nghÒ"
5	"THCN"
6	"Cao ®¼ng nghÒ"
7	"Cao ®¼ng"
8	"§H trë lªn"
99	"Missing" ;
#delimit cr

gen train1 = train 
replace train1  = 2 if train1 ==3 
replace train1  = 3 if train1 ==4 | train1 ==5
replace train1  = 4 if train1 ==6 | train1 ==7
replace train1  = 5 if train1 ==8
#delimit;
label define train1 
1	"Kh«ng cã CMKT"
2	"S¬ cÊp nghÒ"
3	"Trung cÊp"
4	"Cao ®¼ng"
5	"§H trë lªn"
99	"Missing" ;
#delimit cr

gen train2 = train
recode train2 3/4=2 6=2 5=3 7/8=4 .=1 if age >=15
#delimit;
label define train2
1 " Kh«ng cã CMKT"
2 "Lao ®éng qua ®µo t¹o nghÒ"
3 "THCN"
4 "C§, §H trë lªn";
#delimit cr

// T¹o nh·n biÕn thµnh thÞ n«ng th«n
label define ttnt 1" Thµnh thÞ" 2 "N«ng th«n" 99" Missing"

// Cã viÖc lµm, thÊt nghiÖp, thiÕu viÖc lµm
gen employment = 1 if  p34 ==1 | p34 ==6
replace employment = 2 if  p34 == 2 // that nghiep
// BiÕn thÊt nghiÖp ng­îc víi biÕn cã viÖc lµm
gen unemployment = 1 if  p34 ==2
replace unemployment = 2 if  p34==1 | p34 ==6
// T¹o biÕn thiÕu viÖc lµm
gen underemployment = 1 if p32 ==1 & p31 <35

gen weekhour = p31 // Tæng sè giê lµm viªc/ 1 tuÇn
// G¸n nh·n 
/*********** NÕu biÕn viÖc lµm nhËn gi¸ trÞ missing tøc lµ ng­êi n»m ngoµi lll® 
*/
label define employment 1"Cã viÖc lµm" 2"Kh«ng" 99"missing"
label define unemployment 1"ThÊt nghiÖp" 2"Kh«ng" 99"missing"
label define underemployment 1"ThiÕu viÖc lµm" 2"Kh«ng" 99"missing"

// T¹o biÕn lùc l­îng lao ®éng vµ tû lÖ thÊt nghiÖp
* 1. Tinh luc luong lao dong  
gen labour_force = employment					
replace labour_force = unemployment if unemployment==1	// Cong them so nguoi that nghiep vao so nguoi co viec lam
label define labour_force 1"Lùc l­îng lao ®éng " 2"Kh«ng" 99"Missing"
****** Tinh ty le that nghiep
* 2. T¹o biÕn tû lÖ thÊt nghiÖp
/* 	a. Cho ty le that nghiep = luu luong lao dong
	b. Replace ty le that nghiep = so nguoi that nghiep
	c. Ap dung lenh sum cho bien ty le tn
*/
gen unemployment_rate=0 if labour_force==1		
replace unemployment_rate=100 if unemployment==1

// Tû lÖ thiÕu viÖc lµm
gen under_emp_rate = .
recode under_emp_rate (.=0) if employment ==1
replace under_emp_rate = 100 if underemployment ==1
// Tû lÖ tham gia LLLD: Labour force participation rate
gen lfp_rate = 100 if labour_force ==1 
recode lfp_rate (.=0) if age >=15

// Lo¹i h×nh kinh tÕ
gen economic_sector = p28
recode economic_sector (0=.)
recode economic_sector (7=.)
#delimit;
label define economic_sector
1	"Hé c¸ nh©n"
2	"Hé kinh doanh c¸ thÓ"
3	"TËp thÓ"
4	"T­ nh©n"
5	"Nhµ n­íc"
6	"Vèn ®Çu t­ n­íc ngoµi"
99	"Missing" ;
#delimit cr

// T¹o c¸c biÕn ngµnh kinh tÕ 
// Ngµnh cÊp 3

// Ngµnh cÊp 2
gen indus2 = int(p29/10^3)
replace indus2 = 100 if indus2 ==.
// Ngµnh cÊp 1
gen indus1 =.
do "E:\Dropbox\dofile\labels\indus1.do"

// Vi the viec lam cong viec chinh
gen employment_status = p30
// G¸n thî häc viÖc b»ng missing do n¨m 2011 kh«ng cã
recode employment_status (6=.)
recode employment_status (.=2)  if age >=15
#delimit;
label define employment_status
1 " Chñ c¬ së"
2 " Tù lµm"
3 " Lao ®éng gia ®×nh"
4 " Lµm c«ng ¨n l­¬ng"
5 " X· viªn hîp t¸c x·"
99 " Missing";
#delimit cr

gen occup2 = p27
do "E:\Dropbox\dofile\labels\occup1.do"

gen lydokolv = p26a
replace lydokolv = lydokolv -1 
recode lydokolv 0=4 .=4
recode lydokolv (1/4=.) if labour_force ==1 
#delimit;
label define lydokolv 
1 "Sinh viªn/ häc sinh"
2 " Néi trî"
3 " MÊt kh¶ n¨ng lao ®éng"
4 " Kh¸c"
99 " Missing" ;
#delimit cr

gen tdvh =. 

local namelist region6 age agegroup5 marital_status gender train employment dantoc  tdvh  ///
unemployment underemployment economic_sector indus1 indus2 labour_force employment_status ttnt nganh_N_C_D train2 occup1 weekhour lydokolv

foreach name in `namelist' {
recode `name' (.=99)
label values `name' `name'
}
order `namelist' weight tinh unemployment_rate
compress
save $temp\ldvl_2008.dta, replace
