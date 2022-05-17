/*WEIGHTING*/

/*Compiling datasets and adjusting individual weights*/
use [PATH FOR SOURCE DATA 2011]
gen year=2011
gen fnwgt0=rakedw0/4

for new fnwgt1-fnwgt160: gen X=0

foreach i of numlist 1/80{
            local j=`i'-0
            replace fnwgt`i'=rakedw`j'/4

}

foreach i of numlist 81/160{
            replace fnwgt`i'=rakedw0/4

}

sort puf1y_id
save [PATH FOR DERVIED DATA 2011], replace



use [PATH FOR SOURCE DATA 2012]
gen year=2012
gen fnwgt0=rakedw0/4

for new fnwgt1-fnwgt160: gen X=0

foreach i of numlist 1/80{
            local j=`i'-0
            replace fnwgt`i'=rakedw`j'/4

}

foreach i of numlist 81/160{
            replace fnwgt`i'=rakedw0/4

}

sort puf1y_id
save [PATH FOR DERVIED DATA 2012], replace


use [PATH FOR SOURCE DATA 2015]
gen year=2015
gen fnwgt0=rakedw0/4

for new fnwgt1-fnwgt160: gen X=0

foreach i of numlist 1/80{
            local j=`i'-0
            replace fnwgt`i'=rakedw`j'/4

}

foreach i of numlist 81/160{
            replace fnwgt`i'=rakedw0/4

}

sort puf1y_id
save [PATH FOR DERVIED DATA 2015], replace




use [PATH FOR SOURCE DATA 2016]
gen year=2016
gen fnwgt0=rakedw0/4

for new fnwgt1-fnwgt160: gen X=0

foreach i of numlist 1/80{
            local j=`i'-0
            replace fnwgt`i'=rakedw`j'/4

}

foreach i of numlist 81/160{
            replace fnwgt`i'=rakedw0/4

}

sort puf1y_id
save [PATH FOR DERVIED DATA 2016], replace

cd [PATH FOR DERIVED DATA]
ls
use 2011CHIS_v4
append using 2012CHIS_v4
append using 2015CHIS_v4
append using 2016CHIS_v4

save pooledCHIS_v4
use pooledCHIS_v4

/*Applying weights*/
*Jackknife method;
svyset [pw=fnwgt0], jkrw(fnwgt1-fnwgt160, multiplier(1)) vce(jack) mse

