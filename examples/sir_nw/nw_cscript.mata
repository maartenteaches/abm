version 16.1
cscript

set seed 123456

cd "D:\Mijn documenten\projecten\stata\abm\sug\london\nw"
do nw_master.do


// declare parameters
mata:
model = sir_nw()
model.N(10)
model.tdim(20)
model.outbreak(2)
model.degree(4)
model.pr_long(.10)
model.mindur(10)
model.meandur(14)
model.pr_loss(.01)
assert(model.N()==10)
assert(model.tdim()==20)
assert(model.outbreak()==2)
assert(model.mindur()==10)
assert(model.meandur()==14)
assert(model.pr_loss()==0.01)
model.posint(3)
model.pr(0)
model.pr(.5)
model.pr(1)
end

rcof "mata: model.posint(0)"   == 3498
rcof "mata: model.posint(1.4)" == 3498
rcof "mata: model.posint(-2)"  == 3498
rcof "mata: model.pr(-1)"      == 3498 
rcof "mata: model.pr(1.2)"     == 3498

// setup
mata:
model = sir_nw()
model.N(10)
model.tdim(5)
model.outbreak(4)
model.degree(4)
model.pr_long(.10)
model.transmissibility(.2)
model.mindur(10)
model.meandur(14)
model.pr_loss(0.01)
model.setup()
assert(model.agents.N()==10)
assert(model.agents.k()==4)

n_ill = 0
for(i=1;i<=10;i++) {
	key = i,1, 1 //state
	assert(model.agents.get(key)==1 | model.agents.get(key)==2)
	n_ill = n_ill + (model.agents.get(key)==2)
	key = i,2,1 // dur
	assert(model.agents.get(key)==1)
}
assert(n_ill == 4)

end

// infect()
mata:
model = sir_nw()
model.N(10)
model.tdim(5)
model.outbreak(4)
model.degree(4)
model.pr_long(.10)
model.transmissibility(1)
model.mindur(10)
model.meandur(14)
model.pr_loss(0.01)
model.setup()

key = 1,1,2
model.agents.put(key,1)
key = 1,3,2
model.agents.put(key,0)
model.infect(1,2)
key = 1,1,2
assert(model.agents.get(key) == 2)
key = 1,2, 2
assert(model.agents.get(key)==1)

key = 2,1,2
model.agents.put(key, 2)
key = 2,3,2
model.agents.put(key,1)
model.infect(2,2)
key = 2,1,2
assert(model.agents.get(key) == 2)
key = 2,2,2
assert(model.agents.get(key)==1)

model.transmissibility(0)
key = 3,1,2
model.agents.put(key, 1)
key = 3,3,2
model.agents.put(key,0)
model.infect(3,2)
key = 3,1,2
assert(model.agents.get(key) == 1)
key = 3,2,2
assert(model.agents.get(key)==1)

end

// progress
mata:
model = sir_nw()
model.N(10)
model.tdim(5)
model.outbreak(4)
model.degree(4)
model.pr_long(.10)
model.transmissibility(1)
model.mindur(10)
model.meandur(10.5)
model.pr_loss(0.01)
model.setup()

model.agents.put((1,1,2),2)
model.agents.put((1,2,2),9)
model.progress(1,2)
assert(model.agents.get((1,1,2)) == 2)
assert(model.agents.get((1,2,2)) == 9)

model.agents.put((2,1,2),2)
model.agents.put((2,2,2),10)
model.progress(2,2)
assert(model.agents.get((2,1,2)) == 2)
assert(model.agents.get((2,2,2)) == 10)

model.agents.put((3,1,2),2)
model.agents.put((3,2,2),11)
model.agents.put((3,3,2),1)
model.progress(3,2)
assert(model.agents.get((3,1,2)) == 3)
assert(model.agents.get((3,2,2)) == 1)
end


// run()
set rmsg on
mata:
model = sir_nw()
model.N(2000)
model.tdim(200)
model.outbreak(200)
model.degree(4)
model.pr_long(.50)
model.transmissibility(.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0.02)
model.run()
model.export_sir()
end

twoway line S I R t, name(sir, replace)
drop _all

mata
model.export_r()
end
twoway line reprod t, name(reprod, replace)

drop _all
// export_nw
mata:
model = sir_nw()
model.N(100)
model.tdim(10)
model.outbreak(2)
model.degree(4)
model.pr_long(.05)
model.transmissibility(.045)
model.mindur(10)
model.meandur(14)
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
                  lcolor(gs8) scheme(s1mono) ||                ///
        scatter y_ego x_ego if first & state`t'==1 ,           ///
                   mcolor(yellow) msymbol(O) ||                ///
        scatter y_ego x_ego if first & state`t'==2 ,           ///
                   mcolor(red) msymbol(O) ||                   ///
		scatter y_ego x_ego if first & state`t'==3 ,           ///
                   mcolor(black) msymbol(Oh)                   ///		   
                   aspect(1) xscale(off) yscale(off)           ///
                   legend(order(1 "infected" 2 "susceptible")) ///
                   name(t`t', replace) title(Time `t')     
}
