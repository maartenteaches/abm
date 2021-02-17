cd "c:\mijn documenten\projecten\stata\abm\abm"
clear mata
drop _all
set seed 1234567

run examples\schelling\schelling_main.mata

mata:
model = schelling()
model.rdim(10)
model.cdim(10)
model.tdim(5)
model.nred(45)
model.nblue(45)
model.limit(.3)
model.run()
model.summtable()
model.extract(("r","c","t", "id", "red", "happy"))
end

replace r = -r

forvalues t = 0/5 {
    twoway scatter r c if red == 0 & t == `t' & happy == 1, ///
           msymbol(O) mcolor(blue) msize(*2)                ///
           mlabel(id) mlabpos(0)                         || ///
           scatter r c if red == 1 & t == `t' & happy == 1, ///
           msymbol(O) mcolor(red) msize(*2)                 ///
           mlabel(id) mlabpos(0)                         || ///
           scatter r c if red == 0 & t == `t' & happy == 0, ///
           msymbol(Oh) mcolor(blue) msize(*2)               ///
           mlabel(id) mlabpos(0)                         || ///
           scatter r c if red == 1 & t == `t' & happy == 0, ///
           msymbol(Oh) mcolor(red) msize(*2)                ///
           mlabel(id) mlabpos(0)                            ///
           yscale(off range(-10.5 -.5))                     ///
           xscale(off  range(.5 10.5))                      ///
           ylab(none) xlab(none)                            ///
           plotregion(margin(zero))                         ///
           aspect(1)                                        ///
           xline(.5(1)9.5)                                  ///
           yline(-.5(-1)-9.5)                               ///
           legend(off)                                      ///
           name(gr`t', replace) title(Iteration `t')
}