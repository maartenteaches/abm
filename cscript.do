cscript
cd "d:\Mijn documenten\projecten\stata\abm\abm_pop"
do abm_pop.mata

mata:

// one characteristic per obs (k==1)
foo = abm_pop()
foo.N(5000)
foo.k(1)
foo.setup()

foo.put((1,1 ,1),"bla")
assert(foo.get((1,1))   == "bla")
assert(foo.get((1,1,2)) == "bla")
foo.put((1,1 ,4), "foo")
assert(foo.get((1,1))   == "foo")

assert(foo.get((1,1,4), "last")      == "foo")
assert(foo.get((1,1,4), "forwards")  == "foo")
assert(foo.get((1,1,4), "backwards") == "foo")
assert(foo.get((1,1,4), "binary")    == "foo")
assert(foo.get((1,1,4))              == "foo")

assert(foo.get((1,1,5), "last")      == "foo")
assert(foo.get((1,1,5), "forwards")  == "foo")
assert(foo.get((1,1,5), "backwards") == "foo")
assert(foo.get((1,1,5), "binary")    == "foo")
assert(foo.get((1,1,5))              == "foo")

assert(foo.get((1,1,3), "first")     == "bla")
assert(foo.get((1,1,3), "forwards")  == "bla")
assert(foo.get((1,1,3), "backwards") == "bla")
assert(foo.get((1,1,3), "binary")    == "bla")
assert(foo.get((1,1,3))              == "bla")

assert(foo.get((1,1,1), "first")     == "bla")
assert(foo.get((1,1,1), "forwards")  == "bla")
assert(foo.get((1,1,1), "backwards") == "bla")
assert(foo.get((1,1,1), "binary")    == "bla")
assert(foo.get((1,1,1))              == "bla")

foo.put((2,1,4), 1)
assert(foo.get((2,1,3))              == J(0,0,.))
assert(foo.get((2,1,3), "forwards")  == J(0,0,.))
assert(foo.get((2,1,3), "backwards") == J(0,0,.))
assert(foo.get((2,1,3), "binary")    == J(0,0,.))
assert(foo.get((2,1,1))              == J(0,0,.))

assert(foo.get((2,1,4))              == 1)
assert(foo.get((2,1,4), "first")     == 1)
assert(foo.get((2,1,4), "last")      == 1)
assert(foo.get((2,1,4), "forwards")  == 1)
assert(foo.get((2,1,4), "backwards") == 1)
assert(foo.get((2,1,4), "binary")    == 1)

assert(foo.get((2,1,5))==1)
assert(foo.get((2,1,5), "last")      == 1)
assert(foo.get((2,1,5), "forwards")  == 1)
assert(foo.get((2,1,5), "backwards") == 1)
assert(foo.get((2,1,5), "binary")    == 1)

// internally abm_pop stores the content as pointers
// I want that if a is put into an abm_pop instance
// its content is fixed at that point in time. If a 
// is later changed, the content previously stored should not change
a = 1
foo.put((4,1,1),a)
assert(foo.get((4,1))==1)
a=2
assert(foo.get((4,1))==1)


// two characteristic per obs (k==1)
foo = abm_pop()
foo.N(5000)
foo.k(2)
foo.setup()

foo.put((1,2 ,1),"bla")
assert(foo.get((1,2))   == "bla")
assert(foo.get((1,2,2)) == "bla")
foo.put((1,2 ,4), "foo")
assert(foo.get((1,2))   == "foo")

assert(foo.get((1,2,4), "last")      == "foo")
assert(foo.get((1,2,4), "forwards")  == "foo")
assert(foo.get((1,2,4), "backwards") == "foo")
assert(foo.get((1,2,4), "binary")    == "foo")
assert(foo.get((1,2,4))              == "foo")

assert(foo.get((1,2,5), "last")      == "foo")
assert(foo.get((1,2,5), "forwards")  == "foo")
assert(foo.get((1,2,5), "backwards") == "foo")
assert(foo.get((1,2,5), "binary")    == "foo")
assert(foo.get((1,2,5))              == "foo")

assert(foo.get((1,2,3), "first")     == "bla")
assert(foo.get((1,2,3), "forwards")  == "bla")
assert(foo.get((1,2,3), "backwards") == "bla")
assert(foo.get((1,2,3), "binary")    == "bla")
assert(foo.get((1,2,3))              == "bla")

assert(foo.get((1,2,1), "first")     == "bla")
assert(foo.get((1,2,1), "forwards")  == "bla")
assert(foo.get((1,2,1), "backwards") == "bla")
assert(foo.get((1,2,1), "binary")    == "bla")
assert(foo.get((1,2,1))              == "bla")

foo.put((2,2,4), 1)
assert(foo.get((2,2,3))              == J(0,0,.))
assert(foo.get((2,2,3), "forwards")  == J(0,0,.))
assert(foo.get((2,2,3), "backwards") == J(0,0,.))
assert(foo.get((2,2,3), "binary")    == J(0,0,.))

assert(foo.get((2,2,4))              == 1)
assert(foo.get((2,2,4), "first")     == 1)
assert(foo.get((2,2,4), "last")      == 1)
assert(foo.get((2,2,4), "forwards")  == 1)
assert(foo.get((2,2,4), "backwards") == 1)
assert(foo.get((2,2,4), "binary")    == 1)

assert(foo.get((2,2,5))==1)
assert(foo.get((2,2,5), "last")      == 1)
assert(foo.get((2,2,5), "forwards")  == 1)
assert(foo.get((2,2,5), "backwards") == 1)
assert(foo.get((2,2,5), "binary")    == 1)

// extracting the content
bar = abm_pop()
bar.N(10)
bar.k(2)
bar.setup()
for(i=1;i<=10;i++) {
	bar.put((i,1,1),i)
	bar.put((i,1,3),(i+1))
	bar.put((i,2,1),(i+2))
	bar.put((i,2,4),(i+3))
}
res = bar.extract(1,5)
a = J(10,5,.)
for(i=1; i<=10; i++) {
	for(j=1; j<=5; j++) {
		a[i,j] = *res[i,j]
	}
}
b = (1..10)', (1..10)', (2..11)', (2..11)', (2..11)'
assert(a==b)

res = bar.extract(2,5)
a = J(10,5,.)
for(i=1; i<=10; i++) {
	for(j=1; j<=5; j++) {
		a[i,j] = *res[i,j]
	}
}
b = (3..12)', (3..12)', (3..12)', (4..13)', (4..13)'
assert(a==b)

res = bar.extract(1,5)
a = J(10,5,.)
for(i=1; i<=10; i++) {
	for(j=1; j<=5; j++) {
		a[i,j] = *res[i,j]
	}
}
b = (1..10)', (1..10)', (2..11)', (2..11)', (2..11)'
assert(a==b)

res = bar.extract(2,5)
a = J(10,5,.)
for(i=1; i<=10; i++) {
	for(j=1; j<=5; j++) {
		a[i,j] = *res[i,j]
	}
}
b = (3..12)', (3..12)', (3..12)', (4..13)', (4..13)'
assert(a==b)

// adding observations
bar = abm_pop()
bar.N(10)
bar.k(2)
bar.setup()
bar.put((1,2,1), "k")
bar.put((1,2,5), (1,2,8))

assert(bar.N()==10)
bar.add(2)
assert(bar.N()==12)
assert(bar.get((11,1,1))==J(0,0,.))
assert(bar.get((12,1,1))==J(0,0,.))

bar.put((11,1,1),5)
assert(bar.get((11,1))==5)

end
