version 16.1
cscript

set seed 123456

cd "D:\Mijn documenten\projecten\stata\abm\sug\london\sir"
do sir_master.do


// declare parameters
mata:
model = sir()
model.N(10)
model.tdim(20)
model.outbreak(2)
model.mcontacts(2)
model.mindur(10)
model.meandur(14)
model.pr_loss(.01)
assert(model.N()==10)
assert(model.tdim()==20)
assert(model.outbreak()==2)
assert(model.mcontacts()==2)
assert(model.mindur()==10)
assert(model.meandur()==14)
assert(model.pr_loss()==0.01)
end


// setup
mata:
model = sir()
model.N(10)
model.tdim(5)
model.outbreak(4)
model.mcontacts(2)
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

// meet
mata:
model = sir()
model.N(10)
model.tdim(5)
model.outbreak(4)
model.mcontacts(2)
model.transmissibility(.2)
model.mindur(10)
model.meandur(14)
model.pr_loss(.01)
model.setup()
model.meet(4,1)
model.meet(5,1)
model.meet(6,1)
end


// infect()
mata:
model = sir()
model.N(10)
model.tdim(5)
model.outbreak(4)
model.mcontacts(2)
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
model = sir()
model.N(10)
model.tdim(5)
model.outbreak(4)
model.mcontacts(2)
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
model = sir()
model.N(2000)
model.tdim(200)
model.outbreak(200)
model.mcontacts(3)
model.transmissibility(.06)
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

