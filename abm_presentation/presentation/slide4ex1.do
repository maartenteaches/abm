clear mata
drop _all
run sir_main.do

mata:

model = sir()
model.N(2000)
model.tdim(250)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0.02)
model.run()
model.export_sir()
end

twoway line S I R t,  name(anc1, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all
