cscript
cd "D:\Mijn documenten\projecten\stata\abm\game_of_life"

run gol_main.do
set scheme s1color

mata:
model = gol()
model.rdim(100)
model.cdim(100)
model.tdim(100)

init = J(100,100,0)
// a glider
init[20,20] = 1
init[21,21] = 1
init[22,21] = 1
init[22,20] = 1
init[22,19] = 1

// a blinker
init[10,90] = 1
init[11,90] = 1
init[12,90] = 1


model.init_state(init)
model.run()
model.extract(("t", "r", "c", "alive"))
end

replace r = -r
forvalues t=1/100{
    twoway scatter r c if alive & t==`t' , ///
        xscale(off range(0.1 100.5)) ///
        yscale(off range(-0.5 -100.5)) ///
        aspect(1) ///
        ylab(none) xlab(none) ///
        plotregion(margin(zero)) ///
        name(gr`t', replace) ///
        title(Time = `t') ///
        msymbol(s)
}