cd "d:\mijn documenten\projecten\stata\abm\abm"
clear mata
set seed 28863
run examples\sir_nw\nw_main.mata
mata:
model = sir_nw()
model.N(100)
model.tdim(10)
model.outbreak(2)
model.degree(4)
model.pr_long(.05)
model.transmissibility(0.1)
model.mindur(5)
model.meandur(6)
model.pr_loss(0.00)
model.run()
model.export_nw()
end

gen x_ego = cos((ego-1)/`n'*2*_pi)*(1+mod(ego,2)*.2)
gen y_ego = sin((ego-1)/`n'*2*_pi)*(1+mod(ego,2)*.2)
gen x_alter = cos((alter-1)/`n'*2*_pi)*(1+mod(alter,2)*.2)
gen y_alter = sin((alter-1)/`n'*2*_pi)*(1+mod(alter,2)*.2)
    

bys ego (alter) : gen first = _n == 1

forvalues t = 1/10{
    twoway pcspike y_ego x_ego y_alter x_alter,                ///
                  lcolor(gs8)                               || ///
        scatter y_ego x_ego if first & state`t'==1 ,           ///
                   mcolor(yellow) msymbol(O)                || ///
        scatter y_ego x_ego if first & state`t'==2 ,           ///
                   mcolor(red) msymbol(O)                   || ///
        scatter y_ego x_ego if first & state`t'==3 ,           ///
                   mcolor(black) msymbol(Oh)                   ///         
                   aspect(1) xscale(off) yscale(off)           ///
                   legend(order(2 "infected"                   ///
                                3 "susceptible"                ///
                                4 "recovered") rows(1))        ///
                   name(t`t', replace) title(Time `t')     
}