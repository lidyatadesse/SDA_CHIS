/*REGRESSIONS*/
use pooledCHIS_v5

*DID VOLUNTEER WORK OR COMMUNITY SERVICES, PY = am36;
*VOLUNTEER IN ORG DEALING W/COMMUNITY PROBLEM, PY = am39;
*MEET INFORMALLY TO DEAL W/COMMUNITY PROBLEM, PY = am40;

*Creating dichotomous variable for acculturation;
gen acc = .
replace acc = 0 if yrus_p1==1 | yrus_p1==3 | yrus_p1==4
replace acc = 1 if yrus_p1==5 
label variable acc "Acculturation (dich)"
label define acc 0 "<15 years" 1 "≥15 years"
label values acc acc

*Creating dichotomous variable for diabetes;
gen diabetes = .
replace diabetes = 1 if ab22==1 | ab22==3
replace diabetes = 0 if ab22==2
label variable diabetes "Updated Diabetes"
label define diabetes 1 "Yes/Borderline" 0 "No"
label values diabetes diabetes 

*Univariable Rregressions;
svy: logit mam acc, or
svy: logit mam i.srage2, or
svy: logit mam ib2.newrace, or
svy: logit mam i.marit, or
svy: logit mam i.newed, or
svy: logit mam i.totalHHI, or
svy: logit mam i.newemp, or
svy: logit mam diabetes2, or
svy: logit mam smkcur, or
svy: logit mam insurance, or
svy: logit mam usual, or
svy: logit mam docvis, or

*Multivariable Regression;
*Model 1 (Acculturation + Sociodemographic);
svy: logit mam acc i.srage2 ib2.newrace i.marit i.totalHHI i.newed i.newemp, or

*Model 2 (Acculturation + Health Seeking Behaviors);
svy: logit mam acc insurance usual docvis smkcur diabetes2, or

*Model 3 (Acculturation + Social Cohesion Interaction);
svy: logit mam acc##am40, or

*Model 4 (Acculturation + Social Cohesion Interaction + Confounders);
gen acc_am40 = acc*am40
svy: logit mam acc##am40 i.srage2 ib2.newrace i.totalHHI insurance usual docvis smkcur diabetes2, or




/*MODEL CHECKING*/
*Colineraity of sociodemographic variables;
regress mam i.srage2 ib2.newrace i.totalHHI i.newed i.newemp
vif 

*Colineraity of health-related variables;
regress mam insurance usual docvis smkcur i.ab22
vif

svy: logit mam i.yrus_p1 i.srage2 i.newrace i.marit i.totalHHI insurance usual docvis am36 am40 help trust, or

















