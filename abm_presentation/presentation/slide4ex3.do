mata:
model.transmissibility(0.045)
model.mcontacts(3)
model.run()
model.export_sir()
end

twoway line S I R t,  name(anc3, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all
