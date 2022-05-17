/*DESCRIPTIVE STATS*/

*DID VOLUNTEER WORK OR COMMUNITY SERVICES, PY = am36;
*VOLUNTEER IN ORG DEALING W/COMMUNITY PROBLEM, PY = am39;
*MEET INFORMALLY TO DEAL W/COMMUNITY PROBLEM, PY = am40;

*Table 1 (Column Percents + Adjusted Chi-Squares);
svyset [pw=fnwgt0], jkrw(fnwgt1-fnwgt160, multiplier(1)) vce(jack) mse

tabout yrus_p1 srage2 newrace marit newed totalHHI newemp ab22 smkcur insurance usual docvis mam using table1draft.xls, ///
cells(col ci) f(1 1) clab(Col_% 95%_CI) svy stats(chi2) ///
npos(lab) per ///
replace

*Table 1 (Counts);
svyset [pw=fnwgt0], jkrw(fnwgt1-fnwgt160, multiplier(1)) vce(jack) mse

tabout yrus_p1 srage2 newrace marit newed totalHHI newemp ab22 smkcur insurance usual docvis mam using table1draft.xls, ///
cells(freq) format(0c 1p 1p) clab(_ _ _) ///
layout(rb) h3(nil) ///
replace 

*Table 2 (Column Percents + Adjusted Chi-Squares);
svyset [pw=fnwgt0], jkrw(fnwgt1-fnwgt160, multiplier(1)) vce(jack) mse

tabout help trust am36 am39 am40 mam using table2draft.xls, ///
cells(col ci) f(1 1) clab(Col_% 95%_CI) svy stats(chi2) ///
npos(lab) per ///
replace

*Table 2 (Counts);
svyset [pw=fnwgt0], jkrw(fnwgt1-fnwgt160, multiplier(1)) vce(jack) mse

tabout help trust am36 am39 am40 mam using table2draft.xls, ///
cells(freq) format(0c 1p 1p) clab(_ _ _) ///
layout(rb) h3(nil) ///
replace 


srage2 newrace marit newed totalHHI newemp ab22 smkcur ins usual docvis mam using table1draft.xls
