/*
Author: Mr NguyÔn Ngäc B×nh
Email: nguyenngocbinhNEU@yahoo.com
First : 27/12/2013
Update: 25/10/2019
*/

gen hinhthuctimviec = c53
#delimit;
label define hinhthuctimviec 
1 "Nép ®¬n xin viÖc"
2 "Liªn hÖ/ t­ vÊn c¬ së dÞch vô viÖc lµm"	
3 "Qua b¹n bÌ, ng­êi th©n"
4 "§Æt qu¶ng c¸o t×m viÖc"
5 "Qua th«ng b¸o tuyÓn dông"
6 "§ang tham gia pháng vÊn"
7 "T×m kiÕm viÖc tù do"
8 "ChuÈn bÞ ®Ó b¾t ®Çu ho¹t ®éng SX-KD"
99 "Missing";
#delimit cr

gen prev_occup2 = int(c61/100)
gen prev_occup1 = .
replace prev_occup1 = 1 if prev_occup2 >=11 & prev_occup2 <=19
replace prev_occup1 = 2 if prev_occup2 >=21 & prev_occup2 <=26
replace prev_occup1 = 3 if prev_occup2 >=31 & prev_occup2 <=36
replace prev_occup1 = 4 if prev_occup2 >=41 & prev_occup2 <=44
replace prev_occup1 = 5 if prev_occup2 >=51 & prev_occup2 <=54
replace prev_occup1 = 6 if prev_occup2 >=61 & prev_occup2 <=63
replace prev_occup1 = 7 if prev_occup2 >=71 & prev_occup2 <=75
replace prev_occup1 = 8 if prev_occup2 >=81 & prev_occup2 <=83
replace prev_occup1 = 9 if prev_occup2 >=91 & prev_occup2 <=96
replace prev_occup1 = 10 if prev_occup2 >=0 & prev_occup2 <=3

#delimit;
label define prev_occup1 
1 "Nhµ l·nh ®¹o trong c¸c ngµnh, c¸c cÊp vµ c¸c ®¬n vÞ	"
2 "Nhµ chuyªn m«n bËc cao"	
3 "Nhµ chuyªn m«n bËc trung"
4 "Nh©n viªn trî lý v¨n phßng"
5 "Nh©n viªn dÞch vô vµ b¸n hµng"
6 "Lao ®éng cã kü n¨ng trong n«ng nghiÖp, l©m nghiÖp vµ thñy s¶n"
7 "Lao ®éng thñ c«ng vµ c¸c nghÒ nghiÖp cã liªn quan kh¸c	"
8 "Thî l¾p r¸p vµ vËn hµnh m¸y mãc, thiÕt bÞ	"
9 "Lao ®éng gi¶n ®¬n	"
10 "Lùc l­îng qu©n ®éi	"
99 "Missing";
#delimit cr


gen prev_indus2 = int(c62/100)
gen prev_indus1 = .
replace prev_indus1 = 1 if prev_indus2 >=1 & prev_indus2 <=3
replace prev_indus1 = 2 if prev_indus2 >=5 & prev_indus2 <=9
replace prev_indus1 = 3 if prev_indus2 >=10 & prev_indus2 <=33
replace prev_indus1 = 4 if prev_indus2 ==35 
replace prev_indus1 = 5 if prev_indus2 >=36 & prev_indus2 <=39
replace prev_indus1 = 6 if prev_indus2 >=41 & prev_indus2 <=43
replace prev_indus1 = 7 if prev_indus2 >=45 & prev_indus2 <=47
replace prev_indus1 = 8 if prev_indus2 >=49 & prev_indus2 <=53
replace prev_indus1 = 9 if prev_indus2 >=55 & prev_indus2 <=56
replace prev_indus1 = 10 if prev_indus2 >=58 & prev_indus2 <=63
replace prev_indus1 = 11 if prev_indus2 >=64 & prev_indus2 <=66
replace prev_indus1 = 12 if prev_indus2 == 68
replace prev_indus1 = 13 if prev_indus2 >=69 & prev_indus2 <=75
replace prev_indus1 = 14 if prev_indus2 >=77 & prev_indus2 <=82
replace prev_indus1 = 15 if prev_indus2 ==84 
replace prev_indus1 = 16 if prev_indus2 ==85 
replace prev_indus1 = 17 if prev_indus2 >=86 & prev_indus2 <=88
replace prev_indus1 = 18 if prev_indus2 >=90 & prev_indus2 <=93
replace prev_indus1 = 19 if prev_indus2 >=94 & prev_indus2 <=96
replace prev_indus1 = 20 if prev_indus2 >=97 & prev_indus2 <=98
replace prev_indus1 = 21 if prev_indus2 ==99

#delimit;
label define prev_indus1 
1 "N«ng nghiÖp, l©m nghiÖp vµ thñy s¶n"
2 "Khai kho¸ng"
3 "C«ng nghiÖp chÕ biÕn, chÕ t¹o"
4 "SX vµ ph©n phèi ®iÖn, khÝ ®èt, n­íc nãng, h¬i n­íc vµ ®iÒu hßa kh«ng khÝ"
5 "Cung cÊp n­íc; ho¹t ®éng qu¶n lý vµ xö lý r¸c th¶i, n­íc th¶i"
6 "X©y dùng"
7 "B¸n bu«n vµ b¸n lÎ; söa ch÷a « t«, m« t«, xe m¸y vµ c¸c xe cã ®éng c¬ kh¸c"
8 "VËn t¶i kho b·i"
9 "DÞch vô l­u tró vµ ¨n uèng"
10 "Th«ng tin vµ truyÒn th«ng" 
11 "Ho¹t ®éng tµi chÝnh, ng©n hµng vµ b¶o hiÓm"
12 "Ho¹t ®éng KD bÊt ®éng s¶n"
13 "Ho¹t ®éng chuyªn m«n, khoa häc vµ c«ng nghÖ"
14 "Ho¹t ®éng hµnh chÝnh vµ dÞch vô hç trî"
15 "Ho¹t ®éng cña §CS, tæ chøc chÝnh trÞ-x· héi, QLNN, ANQP, B§XH b¾t buéc"
16 "Gi¸o dôc vµ ®µo t¹o"
17 "Y tÕ vµ ho¹t ®éng trî gióp x· héi"
18 "NghÖ thuËt vui ch¬i vµ gi¶i trÝ"
19 "Ho¹t ®éng dÞch vô kh¸c"
20 "Ho¹t ®éng lµm thuª c¸c c«ng viÖc trong c¸c hé gia ®×nh"
21 "Ho¹t ®éng cña c¸c tæ chøc vµ c¬ quan quèc tÕ"
22 "KX§" 
99 "Missing";
#delimit cr

gen prev_nganh_N_C_D = 1 if prev_indus1 ==1
replace prev_nganh_N_C_D = 2 if prev_indus1 == 2 | prev_indus1 == 3 | prev_indus1 == 4 | prev_indus1 == 6
recode prev_nganh_N_C_D (.=3) if prev_indus1 != .
#delimit;
label define prev_nganh_N_C_D
1 "N«ng nghiÖp"
2 "C«ng nghiÖp"
3 "DÞch vô" ;
#delimit cr

gen prev_employment_status = c63
recode prev_employment_status (.=2)  if age >=15
recode prev_employment_status 4=9999 
recode prev_employment_status 5=4 
recode prev_employment_status 9999=5
recode prev_employment_status 9=99
#delimit;
label define prev_employment_status
1 " Chñ c¬ së"
2 " Tù lµm"
3 " Lao ®éng gia ®×nh"
4 " Lµm c«ng ¨n l­¬ng"
5 " X· viªn hîp t¸c x·"
99 " Missing" ;
#delimit cr

gen prev_economic_sector = c64
recode prev_economic_sector 2=1 3=2 4=3 5/6 =4 7/10=5 11=6 12=7 
recode prev_economic_sector (0=.)
recode prev_economic_sector  -1=99  9 =99 // Change
#delimit;
label define prev_economic_sector
1	"Hé c¸ nh©n"
2	"Hé kinh doanh c¸ thÓ"
3	"TËp thÓ"
4	"T­ nh©n"
5	"Nhµ n­íc"
6	"Vèn ®Çu t­ n­íc ngoµi"
7  "C¸c tæ chøc ®oµn thÓ kh¸c"
99	"Missing" , modify ;
#delimit cr
