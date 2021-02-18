cd "d:\mijn documenten\projecten\stata\abm\abm"
clear mata
drop _all
set seed 1234567

run examples\sir\sir_main.mata

mata:
model = sir()
model.N(2000)
model.tdim(150)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0)
model.run()
model.export_sir()
end

twoway line S I R t,  name(sir1, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 

drop _all

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

set seed 123456789
drop _all

mata:
model = sir()
model.N(2000)
model.tdim(150)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0)

base = "t", "S", "I", "R"
for(i=1; i<=10; i++){
    model.run()
    names = J(1,4,"")
    for(j=1; j<=4; j++) {
        names[j] = base[j] + strofreal(i)
    }
    model.export_sir(names)
}
end

twoway line S* t1, lcolor(green ..)            || ///
       line I* t1 , lcolor(orange ..)          || ///
       line R* t1, lcolor(blue ..)                ///
       legend(order(1 "S" 11 "I" 21 "R") cols(3)) ///
       ylab(,angle(0)) name(anc4, replace)   
       