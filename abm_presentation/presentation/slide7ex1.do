clear mata
set seed 28863
run nw_main.do
mata:
model = sir_nw()
model.N(2000)
model.tdim(150)
model.outbreak(10)
model.degree(10)
model.pr_long(.2)
model.transmissibility(.018)
model.mindur(10)
model.meandur(14)
model.pr_loss(0.00)
model.run()
model.export_sir()
end

twoway line S I R t,  name(sir3, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all

mata:
model.pr_long(.05)
model.run()
model.export_sir()
end

twoway line S I R t,  name(sir4, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 

drop _all
