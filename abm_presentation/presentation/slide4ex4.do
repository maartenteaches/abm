mata:
model.mcontacts(4)
model.removed(500)
model.run()
model.export_sir()
end

twoway line S I R t,  name(anc4, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all
