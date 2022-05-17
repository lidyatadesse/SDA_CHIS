/*Choosing variables*/
use pooledCHIS_v4, replace
keep ah33new srsex yrus_p1 srage_p1 sras sraso srh sro ombsrr_p1 srw sraa marit ahedc_p1 ak22_p ak22_p1 wrkst_p1 ab22 year ///
smkcur usual ins acmdnum aj8b dmc8 ///
ad14b ad17b mamscrn2 ad14 ad17 ad26 ad19 ///
am19 am21 am36 am39 am40 ///
rakedw0 fnwgt1-fnwgt160 fnwgt0
*Amongst foreign-born;
keep if ah33new==2
*Amongst women;
keep if srsex==2
*Amongst women at least 40 years of age;
drop if srage_p1==18
drop if srage_p1==26
drop if srage_p1==30
drop if srage_p1==35

gen mam = .
replace mam = 0 if ad14b==1 | ad14==1
replace mam = 1 if ad14b==2 | ad14==2
label variable mam "Ever had Mammogram"
label define mam 1 "No" 0 "Yes" 
label values mam mam
*So our outcome of interest here is never having a mammogram (when y = 1);

gen disc = .
replace disc = 1 if dmc8==1
replace disc = 0 if dmc8==2
label variable disc "Discrimination"
label define disc 1 "Yes" 0 "No" 
label values disc disc

*Creating new age categories;
gen srage2 = .
replace srage2 = 40 if srage_p1==40 | srage_p1==45
replace srage2 = 50 if srage_p1==50 | srage_p1==55
replace srage2 = 60 if srage_p1==60 | srage_p1==65
replace srage2 = 70 if srage_p1==70 | srage_p1==75
replace srage2 = 80 if srage_p1==80 | srage_p1==85
label variable srage2 "Self-Reported Age (5 CAT)"
label define srage2 40 "40-49" 50 "50-59" 60 "60-69" 70 "70-79" 80 "80+"
label values srage2 srage2

*Creating new race and ethnicity categories;
gen newrace = .
replace newrace = 1 if ombsrr_p1==1
replace newrace = 2 if ombsrr_p1==2
replace newrace = 3 if ombsrr_p1==3
replace newrace = 4 if ombsrr_p1==5
replace newrace = 5 if ombsrr_p1==4 | ombsrr_p1==6
label variable newrace "Updated Race and Ethnicity (5 CAT)"
label define newrace2 1 "Hispanic" 2 "NH White" 3 "NH Black" 4 "NH Asian" 5 "Other/Multi"
label values newrace newrace2

*Creating new education categories;
gen newed = .
replace newed = 1 if ahedc_p1==1 | ahedc_p1==2
replace newed = 2 if ahedc_p1==3
replace newed = 3 if ahedc_p1==5
replace newed = 4 if ahedc_p1==4 | ahedc_p1==6
replace newed = 5 if ahedc_p1==7 | ahedc_p1==8 | ahedc_p1==9
label variable newed "Updated Education (5 CAT)
label define newed 1 "Less than High School" 2 "High School" 3 "Vocational School" 4 "Some College" 5 "College Grad" 
label values newed newed

*Creating new HHI categories;
gen totalHHI = .
replace totalHHI = 1 if ak22_p <20000 | ak22_p1==1 | ak22_p==2
replace totalHHI = 2 if ak22_p >= 20000 & ak22_p <50000
replace totalHHI = 2 if ak22_p1==3 | ak22_p==4 | ak22_p==5
replace totalHHI = 3 if ak22_p >= 50000 & ak22_p <80000
replace totalHHI = 3 if ak22_p1==6 | ak22_p==7 | ak22_p==8
replace totalHHI = 4 if ak22_p >= 80000 & ak22_p <110000
replace totalHHI = 3 if ak22_p1==9 | ak22_p==10 | ak22_p==11
replace totalHHI = 5 if ak22_p >= 110000 | ak22_p1==12 | ak22_p==13 | ak22_p==14 | ak22_p1==15 | ak22_p==16 | ak22_p==17 | ak22_p1==18 | ak22_p==19
label variable totalHHI "Updated Total HHI"
label define totalHHI 1 "< $20,000" 2 "$20,000 - $49,999" 3 "50,000 - $79,999" 4 "$80,000 - $109,999" 5 "≥ $110,000"
label values totalHHI totalHHI

*Creating employment categories;
gen newemp = .
replace newemp = 1 if wrkst_p1==1
replace newemp = 2 if wrkst_p1==2 | wrkst_p1==3
replace newemp = 3 if wrkst_p1==4
replace newemp = 4 if wrkst_p1==5
label variable newemp "Updated Employment Status"
label define newemp 1 "Full Time" 2 "Part Time/Other" 3 "Unemployed, Looking" 4 "Unemployed, Not Looking"
label values newemp newemp

*Creating new categories for # of doctor visits;
gen docvis = .
replace docvis = 0 if acmdnum==0
replace docvis = 1 if acmdnum==1 | acmdnum==2 | acmdnum==3 
replace docvis = 2 if acmdnum==4 | acmdnum==5 | acmdnum==6
replace docvis = 3 if acmdnum==7 | acmdnum==8 | acmdnum==9 | acmdnum==10
label variable docvis "Updated # of Doctor Visits"
label define docvis3 0 "0 times" 1 "1-3 times" 2 "4-6 times" 3 "7+ times" 
label values docvis docvis3

*Creating new categories for social cohesion variables;
gen help = .
replace help = 0 if am19==3 | am19==4
replace help = 1 if am19==1 | am19==2
label variable help "Neighbors Help Each Other"
label define help 0 "No" 1 "Yes"
label values help help

gen trust = .
replace trust = 0 if am21==3 | am21==4
replace trust = 1 if am21==1 | am21==2
label variable trust "Neighbors Can be Trusted"
label define trust 0 "No" 1 "Yes"
label values trust trust


*DID VOLUNTEER WORK OR COMMUNITY SERVICES, PY = am36;
*VOLUNTEER IN ORG DEALING W/COMMUNITY PROBLEM, PY = am39;
*MEET INFORMALLY TO DEAL W/COMMUNITY PROBLEM, PY = am40;

save pooledCHIS_v5, replace
