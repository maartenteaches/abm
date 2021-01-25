cscript
cd "c:\Mijn documenten\projecten\stata\abm\abm_pop"
do abm_pop.mata

mata:
timer_clear()
foo = abm_pop()
foo.N(5000)
foo.k(1)
foo.setup()

for(i=1; i<=5000;i++) {
	i
	for(t=1; t <=100; t++) {
		timer_on(1)
		foo.put((i,1,t), "bla")
		timer_off(1)
		timer_on(2)
		bla = foo.get((i,1,510))
		timer_off(2)
		timer_on(3)
		bla = foo.get((i,1,1))
		timer_off(3)
		timer_on(4)
		bla = foo.get((i,1))
		timer_off(4)
		timer_on(5)
		bla = foo.get((i,1,t), "last")
		timer_off(5)
	}
}

bar = AssociativeArray()
bar.reinit("real",3)
for(i=1; i<=5000;i++) {
	i
	for(t=1; t <=100; t++) {
		timer_on(6)
		bar.put((i,1,t),"bla")
		timer_off(6)
		timer_on(7)
		bla = bar.get((i,1,t))
		timer_off(7)
	}
}


timer()

end