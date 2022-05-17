/*CREATING INDEX VARIABLE*/

*Recoding social cohesion variables;
gen c_am19 = help
gen c_am21 = trust
recode am36 (1 = 1) (2=0), gen(c_am36)
recode am39 (1 = 1) (2=0), gen(c_am39)
recode am40 (1 = 1) (2=0), gen(c_am40)
sum c_*
gen addindex = c_am19 + c_am21 + c_am36 + c_am40
gen addindex_01 = (c_am19 + c_am21 + c_am36 + c_am40)/4
egen meanindex = rowmean(c_am19 c_am21 c_am36 c_am40)
histogram meanindex, percent
pwcorr c_am19 c_am21 c_am36 c_am40
alpha c_am19 c_am21 c_am36 c_am40

*Trying McDonald's omega coefficient instead;
omegacoef c_am19 c_am21 c_am36 c_am40

