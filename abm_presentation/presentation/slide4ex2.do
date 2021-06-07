mata:
model.pr_loss(0)
model.tdim(150)
model.transmissibility(0.03)
model.run()
model.export_sir()
end

twoway line S I R t,  name(anc2, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all
