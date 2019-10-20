/*
Author: Mr NguyÔn Ngäc B×nh
Email: nguyenngocbinhNEU@yahoo.com
First : 7/11/2012
Last update: 18/1/2013
dang kiem tra 18/3/2014
*/
set more off
global data "D:\GoogleDrive\Data\Ldvl"
global temp "E:\Dropbox\temp\ldvl"

use "$data\ldvl_2010.dta", clear

do "E:\Dropbox\dofile\labels\region6.do"
// Giíi tÝnh
gen gender = c3
label define gender 1"Nam" 2 "N÷" 99"Missing"
gen age = c5 
do "E:\Dropbox\dofile\labels\agegroup5.do"

// tao bien tinh trang hon nhan 
// Co gia tri bang 9 chua ro
gen marital_status = c8
recode marital_status (9 =.)
#delimit;
label define marital_status
1 " Ch­a cã vî/ chång"
2 " §· cã vî/ chång"
3 " Gãa"
4 " Ly h«n/ ly th©n"
99 "Mising";
#delimit cr


// B»ng cÊp cao nhÊt
gen highest_degree = c9
#delimit;
label define highest_degree 
0	"Ch­a ®i häc"
1	"D­íi tiÓu häc"
2	"TiÓu häc"
3	"THCS"
4	"S¬ cÊp nghÒ"
5	"THPT"
6	"Trung cÊp nghÒ"
7	"Trung cÊp CN"
8	"Cao ®¼ng nghÒ"
9	"Cao ®¼ng"
10	"§H trë lªn"
99	"Missing" ;
#delimit cr

gen tdvh =highest_degree 
recode tdvh 4 =3 5/10 =4 .=0 99=0 if age >=15
#delimit;
label define tdvh
0 "Kh«ng biÕt ®äc biÕt viÕt"
1 "Ch­a tèt nghiÖp tiÓu häc"
2 "TN tiÓu häc"
3 "TN THCS"
4 "TN THPT";
#delimit cr

// Do n¨m 2009 kh«ng cã biÕn highest_degree nªn t¹o biÕn train
gen train = .
replace train = 1 if highest_degree >= 0 & highest_degree <= 3 | highest_degree == 5

replace train = 3 if highest_degree == 4
replace train = 4 if highest_degree == 6
replace train = 5 if highest_degree == 7
replace train = 6 if highest_degree == 8
replace train = 7 if highest_degree == 9
replace train = 8 if highest_degree == 10
recode train (9 =.)  // Co gia tri khong xac dinh
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
1 "Kh«ng cã CMKT"
2 "Lao ®éng qua ®µo t¹o nghÒ"
3 "THCN"
4 "C§, §H trë lªn";
#delimit cr

// T¹o nh·n biÕn thµnh thÞ n«ng th«n
label define ttnt 1" Thµnh thÞ" 2 "N«ng th«n" 99" Missing"

gen hdkt = c40
// Cã viÖc lµm, thÊt nghiÖp, thiÕu viÖc lµm
gen employment = 1 if hdkt ==1 
replace employment = 2 if hdkt == 2 // that nghiep
// BiÕn thÊt nghiÖp ng­îc víi biÕn cã viÖc lµm
gen unemployment = 1 if hdkt ==2
replace unemployment = 2 if hdkt==1 
// T¹o biÕn thiÕu viÖc lµm
gen underemployment = 1 if c24 ==1 & c25 ==1
recode underemployment (.=2)
recode underemployment (2=.) if employment ==.

gen weekhour = c22 // Tæng sè giê lµm viªc/ 1 tuÇn

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
gen economic_sector = c16
recode economic_sector (9=.)
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
// Ngµnh cÊp 2
gen indus2 = int(c18/10)
recode indus2 (0=.)
replace indus2 = 100 if indus2 ==.
// Ngµnh cÊp 1
gen indus1 =.
do "E:\Dropbox\dofile\labels\indus1.do"

// Vi the viec lam cong viec chinh
gen employment_status = c15
recode employment_status (9=.)
// G¸n thî häc viÖc b»ng missing do n¨m 2011 kh«ng cã
recode employment_status (6=.)

#delimit;
label define employment_status
1 " Chñ c¬ së"
2 " Tù lµm"
3 " Lao ®éng gia ®×nh"
4 " Lµm c«ng ¨n l­¬ng"
5 " X· viªn hîp t¸c x·"
99 " Missing";
#delimit cr

gen occup2 = int(c14/10)

do "E:\Dropbox\dofile\labels\occup1.do"

gen train3 = train
recode train3 (1=0) if occup1 <1 | occup1 >8
recode train3 8 =7
#delimit;
label define train3
0 "Kh«ng cã CMKT"
1 " L§ qua ®µo t¹o kh«ng b»ng cÊp"
3	"S¬ cÊp nghÒ"
4	"Trung cÊp nghÒ"
5	"THCN"
6	"Cao ®¼ng nghÒ"
7 "C§, §H trë lªn"
99	"Missing" ;
#delimit cr

// Update 10/12/2012
gen wage = c28
replace wage =0 if wage <0

gen income =0
// Dan téc
gen dantoc = c6a 
recode dantoc (9 =2)
label define dantoc 1"Kinh" 2 "Kh¸c" 99 "Missing"


gen hoatdong = labour_force
recode hoatdong .=2 if c35 == 1 
recode hoatdong .=3 if c35 >1 & c35 <=5 
#delimit;
label define hoatdong
1 "Tham gia LLL§"
2 "Sinh viªn/ häc sinh"
3 " Kh¸c"
99 " Missing" ;
#delimit cr

gen lydokolv = c35
recode lydokolv 5=4 9=4
recode lydokolv (.=4)
recode lydokolv (1/4=.) if labour_force ==1 
#delimit;
label define lydokolv 
1 "Sinh viªn/ häc sinh"
2 " Néi trî"
3 " MÊt kh¶ n¨ng lao ®éng"
4 " Kh¸c"
99 " Missing" ;
#delimit cr
gen doituong = c7 ==1
local namelist dantoc age region6 agegroup5 marital_status gender highest_degree tdvh train train2 train3 employment  unemployment underemployment ///
economic_sector indus1 indus2 labour_force employment_status ttnt nganh_N_C_D  hdkt occup1  hoatdong lydokolv weekhour

foreach name in `namelist' {
recode `name' (.=99)
label values `name' `name'
}

gen weight = w_ng2010
order `namelist' weight tinh unemployment_rate wage  under_emp_rate  // them bien vao day**** ky_3t w_p_q
compress
save "$temp\ldvl_2010.dta", replace

* Thieu bien bhxh time_tn ky_3t
