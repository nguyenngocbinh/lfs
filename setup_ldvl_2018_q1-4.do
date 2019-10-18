/*
Author: Mr NguyÔn Ngäc B×nh
Email: nguyenngocbinhNEU@yahoo.com
First : 18/10/2019
*/
clear
set more off
global data "D:\ldvl\LFS_2018"
global temp "D:\ldvl\tmp"

use "$data\lfs_2018_q1.dta", clear
	gen ky_3t =1
	gen w_p_q = cal_weigh 
tempfile file_q1
save `file_q1', replace

use "$data\lfs_2018_q2.dta", clear
	gen ky_3t =2
	gen w_p_q = cal_weigh
	rename thieuvieclamthongthuong thieuvieclamthongthuong1
tempfile file_q2
save `file_q2', replace

use "$data\lfs_2018_q3.dta", clear
	gen ky_3t =3
	gen w_p_q = cal_weigh	
tempfile file_q3
save `file_q3', replace

use "$data\lfs_2018_q4.dta", clear
	gen ky_3t =4
	gen w_p_q = cal_weigh	

tempfile file_q4
save `file_q4', replace

* Append 

use `file_q1', clear
append using `file_q2'
append using `file_q3'
append using `file_q4'

gen doituong = c6 ==1
* Bæ sung thªm sè giê lµm viÖc bq/ tuÇn 1-9, 10-19 ... 60+
* Bs lý do kh«ng tham gia ho¹t ®éng kinh tÕ
*Lo¹i h×nh kinh tÕ, nªn nhãm nhãm 1, 2 vµo lµm 1
* VÏ biÓu ®å viÖc lµm, thÊt nghiÖp theo nhãm tuæi
* ChØ tiªu di c­ néi ®Þa
* Tû lÖ ng­êi di c­ tham gia ho¹t ®éng kinh tÕ
/* Trong b¸o c¸o ph©n tÝch nµy, di c­ bao gåm nh÷ng ng­êi 15 tuæi trë lªn chuyÓn tõ x·/ph­êng/thÞ trÊn kh¸c 
®Õn n¬i ë hiÖn t¹i trong vßng 12 th¸ng tr­íc thêi ®iÓm ®iÒu tra. Do vËy ng­êi di c­ ®Ò cËp ë ®©y chñ yÕu lµ di c­ néi ®Þa.
*/
// T¹o biÕn vïng kinh tÕ
do "D:\ldvl\label\region6.do"

// Giíi tÝnh
rename c3 gender
rename c5 age 

do "D:\ldvl\label\agegroup5.do"

// T×nh tr¹ng h«n nh©n 
gen marital_status = c9
recode marital_status (5=4)
#delimit;
label define marital_status
1 " Ch­a cã vî/ chång"
2 " §· cã vî/ chång"
3 " Gãa"
4 " Ly h«n/ ly th©n"
99 "Mising";
#delimit cr

gen migration = c10 if age >=5 
recode migration 1/4 =1 5=0 .=0 if age >=5
label define migration 1 "Di c­" 0 "Kh«ng di c­"

gen migration_reasons = c13 
recode migration_reasons (.=9) if migration ==1 
#delimit;
label define migration_reasons 
1 "T×m viÖc"
2 "B¾t ®Çu c«ng viÖc míi"
3 "MÊt viÖc/ kh«ng t×m ®­îc viÖc"
4 "Theo gia ®×nh/ nghØ h­u"
5 "Kªt h«n"
6 "ChuyÓn nhµ"
7 "C¶i thiÖn ®iªu kiÖn sèng"
8 "§i häc"
9 "Kh¸c",modify ;
#delimit cr

gen provinces_migration = c12a
gen reg_migration=6  
replace reg_migration=5 if provinces_migration >=70 & provinces_migration<=79 
replace reg_migration=4 if provinces_migration >=62 & provinces_migration<=68  
replace reg_migration=3 if provinces_migration >=38 &provinces_migration<=60   
replace reg_migration=2 if provinces_migration >=2 & provinces_migration<=20  
replace reg_migration=2 if provinces_migration ==24
replace reg_migration=2 if provinces_migration ==25
replace reg_migration=1 if provinces_migration >=26 & provinces_migration <=37
replace reg_migration=1 if provinces_migration ==22
replace reg_migration=1 if provinces_migration ==1

#delimit;
label define reg_migration 
		1 "§ång b¾ng s«ng Hång" 
		2 "Trung du miªn nói phÝa b¾c" 
		3 "B¾c Trung bé vµ Duyªn h¶i miÒn trung" 
		4 "T©y Nguyªn"
		5 "§«ng Nam bé"
		6 "§ång b»ng s«ng Cöu Long"
		99 "Missing";
#delimit cr

/* Tr×nh ®é häc vÊn, CMKT */
gen tdvh = c17
recode tdvh  .=0 1=0 2=1 3=2 4 =3 5/9 =4 if age >=15
#delimit;
label define tdvh
0 "Kh«ng biÕt ®äc biÕt viÕt"
1 "Ch­a tèt nghiÖp tiÓu häc"
2 "TN tiÓu häc"
3 "TN THCS"
4 "TN THPT";
#delimit cr

gen tdvh0 = c17
recode tdvh0 0=.
#delimit;
label define tdvh0
1 "Ch­a bao giê ®i häc"
2 "Ch­a häc xong tiÓu häc"
3 "TiÓu häc"
4 "THCS"
5 "THPT"
6 "Trung cÊp CN"
7 "Cao ®¼ng CN"
8 "§¹i häc"
9 "Trªn ®¹i häc";
#delimit cr

// Do n¨m 2009 kh«ng cã biÕn highest_degree nªn t¹o biÕn train
capture drop train0
gen train0 = c19
recode train0 (7=8)
replace train0 =7 if c17 ==6
recode train0 1/8 = 9 if c17 ==7
recode train0 1/9=10 if c17 ==8
recode train0 1/10= 11 if c17 ==9

#delimit;
label define train0 
1 "Kh«ng cã tr×nh ®é, kü n¨ng nghÒ "
2 "CNKT kh«ng b»ng"
3 "Kü n¨ng nghÒ d­íi 3 th¸ng"
4  "Chøng chØ nghÒ d­íi 3 th¸ng"
5	"S¬ cÊp nghÒ"
6 "Trung cÊp nghÒ"
7	"THCN"
8 "Cao ®¼ng nghÒ"
9	"Cao ®¼ng"
10	"§¹i häc"
11  "Trªn ®¹i häc" ;
#delimit cr


gen train = c19
recode train 2/4 =1 5=3 6=4 7=6
recode train 1/6 = 5 if c17 ==6
recode train 1/7= 7 if c17 ==7 
recode train 1/8= 8 if c17 ==8 | c17 ==9 
recode train (.=1) if age >=15
recode train (0=99) if age >=15
#delimit;
label define train 
1	"Kh«ng cã CMKT"
2  "CNKT  kh«ng b»ng/ kü n¨ng, CC nghÒ d­íi 3 th¸ng "
3	"S¬ cÊp nghÒ"
4	"Trung cÊp nghÒ"
5	"THCN"
6	"Cao ®¼ng nghÒ"
7	"Cao ®¼ng"
8	"§H trë lªn "
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
5	"§h/trªn §h"
99	"Missing" ;
#delimit cr

gen train2 = train
recode train2 2=1 3/4=2 6=2 5=3 7/8=4 .=1 if age >=15
#delimit;
label define train2
1 " Kh«ng cã CMKT"
2 "Lao ®éng qua ®µo t¹o nghÒ"
3 "THCN"
4 "C§, §H trë lªn";
#delimit cr

gen train3 = train0
recode train3 4=3
recode train3 7=6 
recode train3 8/9=7 10=8 11=9
#delimit;
label define train3
1 "Kh«ng cã tr×nh ®é, kü n¨ng nghÒ "
2 "CNKT kh«ng b»ng"
3 "Kü n¨ng/CC nghÒ d­íi 3 th¸ng"
5	"S¬ cÊp nghÒ"
6	"Trung cÊp"
7	"Cao ®¼ng"
8	"§¹i häc"
9  "Trªn ®¹i häc" ;
#delimit cr

// T¹o nh·n biÕn thµnh thÞ n«ng th«n
capture label drop ttnt
label define ttnt 1"Thµnh thÞ" 2 "N«ng th«n" 99" Missing"

gen employment = 1 if hdkt ==1 & doituong ==1
gen unemployment = 1 if hdkt == 2 & doituong ==1
gen weekhour = c45 // Tæng sè giê lµm viÖc/ 1 tuÇn
gen extra_hours = c45b
replace extra_hours = . if extra_hours <=0

gen underemployment = thieuvieclamthongthuong1
recode underemployment (.=2) if employment ==1
replace underemployment =. if doituong !=1

replace underemployment = 2 if weekhour <=0 
label define hdkt 1"Cã viÖc lµm" 2"ThÊt nghiÖp" 99"Ngoµi lùc l­îng lao ®éng", modify
label define employment 1"Cã viÖc lµm" 2"Kh«ng" 99"missing"
label define unemployment 1"ThÊt nghiÖp" 2"Kh«ng" 99"missing"
label define underemployment 1"ThiÕu viÖc lµm" 2"Kh«ng" 99"missing"

* Tinh luu luong lao dong
// 1. Tinh luc luong lao dong  
gen labour_force=employment					
replace labour_force=unemployment if unemployment==1	
label define labour_force 1"Lùc l­îng lao ®éng " 2"Kh«ng" 99"Missing"
// Tinh ty le that nghiep
gen unemployment_rate=0 if labour_force==1		
replace unemployment_rate=100 if unemployment==1
// Tû lÖ thiÕu viÖc lµm
gen under_emp_rate = .
recode under_emp_rate (.=0) if employment ==1
replace under_emp_rate = 100 if underemployment ==1
// Tû lÖ tham gia LLLD: Labour force participation rate
gen lfp_rate = 100 if labour_force ==1 
recode lfp_rate (.=0) if age >=15
replace lfp_rate =. if doituong !=1

// NghÒ
gen occup2 = int(c29c/100)
do "D:\ldvl\label\occup1.do"

// T¹o c¸c biÕn ngµnh kinh tÕ  c«ng viÖc chiÕm nhiÒu thêi gian nhÊt
// Ngµnh cÊp 2
gen indus2 = int(c30c/100)
// Ngµnh cÊp 1
gen indus1 =.
do "D:\ldvl\label\indus1.do"

// Lo¹i h×nh kinh tÕ nhµ n­íc cã phÇn chia thµnh 3 lo¹i nh­ng trong phÇn nµy gép chung vµo
gen economic_sector = c31
recode economic_sector 2=1 3=2 4=3 5/6 =4 7/10=5 11=6 12=7 
recode economic_sector (0=.)
recode economic_sector  -1=99  9 =99 // Change
#delimit;
label define economic_sector
1	"Hé c¸ nh©n"
2	"Hé kinh doanh c¸ thÓ"
3	"TËp thÓ"
4	"T­ nh©n"
5	"Nhµ n­íc"
6	"Vèn ®Çu t­ n­íc ngoµi"
7  "C¸c tæ chøc ®oµn thÓ kh¸c"
99	"Missing" , modify ;
#delimit cr

gen economic_sector0 = c31
#delimit;
label define economic_sector0
1	"Hé NLTS"
2	"C¸ nh©n lµm tù do"
3	"C¬ së kinh doanh c¸ thÓ"
4	"TËp thÓ"
5	"DN ngoµi NN"
6	"§¬n vÞ sù nghiÖp ngoµi NN"
7   "CQ LËp ph¸p, hµnh ph¸p, t­ ph¸p"
8   "Tæ chøc NN"
9   "§¬n vÞ sù nghiÖp NN"
10  "Doanh nghiÖp NN"
11  "Khu vùc n­íc ngoµi"
12  "Tæ chøc, ®oµn thÓ kh¸c"
99	"Missing" ;
#delimit cr

gen economic_sector2 = c31
recode economic_sector2 2=1 3=2 4=3 5/6 =4 7/8=5 9=6 10=7 11=8 12=9 
recode economic_sector2 (0=.)
#delimit;
label define economic_sector2
1	"Hé/ c¸ nh©n "
2	"C¬ së kinh doanh c¸ thÓ"
3	"TËp thÓ"
4	"T­ nh©n"
5	"C¬ quan tæ chøc NN"
6	"§¬n vÞ sù nghiÖp NN"
7  "Doanh nghiÖp NN"
8  "Khu vùc n­íc ngoµi"
9  "Tæ chøc, ®oµn thÓ kh¸c"
99	"Missing" ;
#delimit cr


// VÞ thÕ viÖc lµm cña c«ng viÖc chiÕm nhiÒu thêi gian nhÊt
gen employment_status = c35
recode employment_status 4=9999 
recode employment_status 5=4 
recode employment_status 9999=5
recode employment_status 9=99
#delimit;
label define employment_status
1 " Chñ c¬ së"
2 " Tù lµm"
3 " Lao ®éng gia ®×nh"
4 " Lµm c«ng ¨n l­¬ng"
5 " X· viªn hîp t¸c x·"
99 " Missing";
#delimit cr

// Tæng thu nhËp
gen income_all_job = c44
replace income_all_job = . if income_all_job <=0

// Thu nhËp c«ng viÖc chÝnh
gen income_main_job = c44a
replace income_main_job = 0 if income_main_job <=0

gen wage =.

// B¶o hiÓm chung tÊt c¶
* gen bhxh = c32
* label define bhxh 1"cã" 2 "Kh«ng" 99 "Missing"

// Thêi gian thÊt nghiÖp
gen time_tn = c64 
#delimit;
label define time_tn
1 "D­íi 1 th¸ng"
2 " Tõ 1- 3 th¸ng"
3 " Tõ 3- 12 th¸ng"
4 " Tõ 1- 5 n¨m"
5 " Trªn 5 n¨m"
99 " Missing" ;
#delimit cr


gen hdld = c36
recode hdld (0=.)
#delimit;
label define hdld
1 "H§L§ KX§ thêi h¹n"
2 " H§L§ 1 n¨m ®Õn <3 n¨m"
3 " H§L§ 3 th¸ng ®Õn <1 n¨m"
4 "H§L§ d­íi 3 th¸ng "	
5 "Hîp ®ång kho¸n/ giao viÖc"
6 " Tháa thuËn miÖng"
7 " Kh«ng cã H§L§"
99 " Missing" ;
#delimit cr

do "D:\ldvl\support_ldvl2018.do"

gen hoatdong = labour_force
recode hoatdong .=2 if c24 == 2
recode hoatdong .=3 if c24 != 2
#delimit;
label define hoatdong
1 "Tham gia LLL§"
2 "Sinh viªn/ häc sinh"
3 " Kh¸c"
99 " Missing" ;
#delimit cr

gen lydokolv = c24
recode lydokolv 1=4 2=1 5=2 6/9=4
replace lydokolv =. if labour_force ==1 
recode lydokolv .=4 if  labour_force !=1 
#delimit;
label define lydokolv 
1 "Sinh viªn/ häc sinh"
2 " Néi trî"
3 " MÊt kh¶ n¨ng lao ®éng"
4 " Kh¸c"
99 " Missing" ;
#delimit cr


// Recode gi¸ trÞ missing b»ng 99 vµ g¸n nh·n cho biÕn
* bhxh hdld
local namelist region6 regHN_HCM agegroup5 marital_status gender train train2 train3 train0 employment  ///
unemployment underemployment economic_sector economic_sector2 economic_sector0 indus1 indus2 occup1 labour_force ///
employment_status ttnt nganh_N_C_D  tdvh  tdvh0  hdkt time_tn prev_indus1  prev_nganh_N_C_D  prev_employment_status ///
prev_economic_sector prev_occup1 hinhthuctimviec lydokolv hoatdong trongtuoi  migration migration_reasons reg_migration
foreach name in `namelist' {
recode `name' (.=99) if age >=15
label values `name' `name'
}

		
* gen weight = cal_weigh

order `namelist' age w_p_q tinh unemployment_rate under_emp_rate wage  weekhour  lfp_rate extra_hours
compress
label var marital_status "T×nh tr¹ng h«n nh©n"
label var tdvh "Tr×nh ®é häc vÊn cao nhÊt"
label var train "Tr×nh ®é chuyªn m«n kü thuËt"
label var train2 "Tr×nh ®é chuyªn m«n kü thuËt"
label var agegroup5 "Nhãm tuæi"
label var economic_sector "H×nh thøc së h÷u"
label var indus1 "Nhãm ngµnh kinh tÕ cÊp 1"
label var occup1 "Nhãm nghÒ cÊp 1"
label var  nganh_N_C_D "3 ngµnh lín"
label var region6 "Vïng kinh tÕ"
label var gender "Giíi tÝnh"
label var ttnt "Khu vùc"

save "$temp\ldvl_2018_q1-4.dta", replace


