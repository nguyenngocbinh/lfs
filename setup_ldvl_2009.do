/*
Author: Mr NguyÔn Ngäc B×nh
Email: nguyenngocbinhNEU@yahoo.com
First : 7/11/2012
Last update: 2013/03/27
*/
set more off
global data "D:\GoogleDrive\Data\Ldvl"
global temp "E:\Dropbox\temp\ldvl"

use "$data\ldvl_2009.dta", clear
/*
gen tinh = c10b
// T¹o biÕn vïng kinh tÕ
gen region6=6   // Dong bang song cuu Long
replace region6=5 if tinh >=70 & tinh<=79 // Dong Nam Bo
replace region6=4 if tinh >=62 & tinh<=68  // Tay Nguyen
replace region6=3 if tinh >=38 &tinh<=60   // Bac Trung Bo va Duyen Hai Mien Trung
replace region6=2 if tinh >=2 & tinh<=20  // Trung du va mien nui phia bac
replace region6=2 if tinh ==24
replace region6=2 if tinh ==25
replace region6=1 if tinh >=26 & tinh <=37   // Dong bang song Hong
replace region6=1 if tinh ==22
replace region6=1 if tinh ==1
*/
// T¹o biÕn tuæi vµ nhãm tuæi (kho¶ng c¸ch 5 n¨m)
gen tinh = .
gen region6 = vung
recode region6 (2=7) // nhËp HN vµo §B s«ng Hång
recode region6 (1=2) // §æi thø tù ®ång b»ng s«ng Hång vµ TD miÒn nói phÝa b¾c
recode region6 (7=1)
recode region6 (8=5)  // NhËp TPHCM vµo §«ng Nam Bé

#delimit;
label define region6 
		1 "§ång b»ng s«ng Hång" 
		2 "Trung du miÒn nói phÝa b¾c" 
		3 "B¾c Trung bé vµ Duyªn h¶i miÒn trung" 
		4 "T©y Nguyªn"
		5 "§«ng Nam Bé"
		6 "§ång b»ng s«ng Cöu Long"
		99 "Missing";
#delimit cr

gen regHN_HCM = vung
#delimit;
label define regHN_HCM
		1 "§ång b»ng s«ng Hång" 
		2 "Trung du miÒn nói phÝa b¾c" 
		3 "B¾c Trung bé vµ Duyªn h¶i miÒn trung" 
		4 "T©y Nguyªn"
		5 "§«ng Nam Bé"
		6 "§ång b»ng s«ng Cöu Long"
		9 "Hµ Néi"
		10 "TP. Hå ChÝ Minh"
		99 "Missing";
#delimit cr


// Giíi tÝnh
gen gender = c3
label define gender 1"Nam" 2 "N÷" 99"Missing"

gen age = c5 
do "E:\Dropbox\dofile\labels\agegroup5.do"

// T×nh tr¹ng h«n nh©n 
gen marital_status = c16
recode marital_status (9=.)
#delimit;
label define marital_status
1 " Ch­a cã vî/ chång"
2 " §· cã vî/ chång"
3 " Gãa"
4 " Ly h«n/ ly th©n"
99 "Mising";
#delimit cr



// B»ng cÊp cao nhÊt
// Recode nhung nguoi thuoc CNKT khong bang thanh ko co cmkt
gen train = c14
recode train (2=1)
recode train (9=.) // gia tri khong xac dinh
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

// Cã viÖc lµm, thÊt nghiÖp, thiÕu viÖc lµm
gen hdkt = c79
gen employment = 1 if  hdkt ==1 
replace employment = 2 if  hdkt == 2 // that nghiep
// BiÕn thÊt nghiÖp ng­îc víi biÕn cã viÖc lµm
gen unemployment = 1 if  hdkt ==2
replace unemployment = 2 if  hdkt==1 
// T¹o biÕn thiÕu viÖc lµm
gen underemployment = thieuvie
gen weekhour = c75 // Tæng sè giê lµm viªc/ 1 tuÇn
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
gen economic_sector = c42
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
gen indus2 = int(c43/10)
recode indus2 (0=.)
// Ngµnh cÊp 1
gen indus1 =.
do "E:\Dropbox\dofile\labels\indus1.do"

// Vi the viec lam cong viec chinh
gen employment_status = c47
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

gen occup2 = int(c39/10) 	// Da kiem tra chuan
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

gen bhxh = c50c
label define bhxh 1"cã" 2 "Kh«ng" 99 "Missing"

gen hdld = c48
recode hdld 9=99
#delimit;
label define hdld
1 "H§L§ kh«ng thêi h¹n"
2 " H§L§ tõ 1-3 n¨m"
3 " H§L§ d­íi 1 n¨m"
4 " Tháa thuËn miÖng"
5 " Kh«ng cã H§L§"
99 " Missing" ;
#delimit cr

// TiÒn l­¬ng
gen wage = 0 

gen income = c52 *4 // TiÒn l­¬ng trong 7 ngµy * 4 -> l­¬ng th¸ng
replace income =0 if income <0 

// Dan téc
gen dantoc = c6a 
recode dantoc (9 =99)
label define dantoc 1"Kinh" 2 "Kh¸c" 99 "Missing"

gen tdvh =.

gen hoatdong = labour_force
recode hoatdong .=2 if c29 == 1 
recode hoatdong .=3 if c29 > 1 & c29 <=5
#delimit;
label define hoatdong
1 "Tham gia LLL§"
2 "Sinh viªn/ häc sinh"
3 " Kh¸c"
99 " Missing" ;
#delimit cr

gen lydokolv = c29
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

local namelist dantoc nganh_N_C_D region6 regHN_HCM age agegroup5 marital_status gender train train2 train3 tdvh employment  weekhour /// 
unemployment underemployment economic_sector indus1 indus2 occup1 labour_force employment_status ttnt nganh_N_C_D  hdkt bhxh hdld hoatdong lydokolv
replace indus2 = 100 if indus2 ==.
foreach name in `namelist' {
recode `name' (.=99)
label values `name' `name'
}

order `namelist' weight tinh unemployment_rate wage under_emp_rate
compress
save $temp\ldvl_2009.dta, replace
