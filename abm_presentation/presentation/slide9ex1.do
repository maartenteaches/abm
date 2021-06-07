set seed 123456789
clear mata
drop _all
run grid_main.do

mata:

model = sir_grid()
model.rdim(10)
model.cdim(10)
model.prop_close(0.15)
model.prop_far(0.01)

N = J(10,10,100)
N[5,5] =2000
model.N(N)
model.tdim(100)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0)

model.run()
model.export_sir()

end

replace r = -r
foreach t of numlist 1 5(5) 100 {
     heatplot I r c if t==`t',          /// 
          discrete title(Time = `t')    ///
          name(ancgrid`t', replace)        ///
          cuts(0(0.05)0.7)              /// 
          colors(plasma)                ///
          yscale(off range(-10.5 -.5))  ///
          xscale(off  range(.5 10.5))   ///
          ylab(none) xlab(none)         ///
          plotregion(margin(zero))      ///
          aspect(1)                                        
}
