mata:
foo = abm_grid()

// new() sets the abm_version to current
assert(foo.abm_version() == foo.abm_current())

foo.abm_version("0.5.1")
assert(foo.abm_version() == (0,5,1))
end

rcof "mata: foo.setup()" == 3351

mata:
foo.rdim(10)
foo.cdim(20)
assert(foo.rdim() == 10)
assert(foo.cdim() == 20)

// defaults for setup()
foo.setup()
assert(foo.tdim()     == 0)
assert(foo.idim()     == 1)
assert(foo.neumann()  == 0)
assert(foo.torus()    == 0)
assert(foo.randit()   == 0)
assert(foo.size()     == 200)
end



mata:
foo= abm_grid()
end

rcof "mata: foo.rdim(-1)" == 3300
rcof "mata: foo.rdim(1.5)" == 3300
rcof "mata: foo.cdim(-1)" == 3300
rcof "mata: foo.cdim(1.5)" == 3300
rcof "mata: foo.idim(-1)" == 3300
rcof "mata: foo.idim(1.5)" == 3300
rcof "mata: foo.tdim(-1)" == 3300
rcof "mata: foo.tdim(1.5)" == 3300
rcof "mata: foo.torus(-1)" == 3300
rcof "mata: foo.torus(1.5)" == 3300
rcof "mata: foo.torus(2)" == 3300
rcof "mata: foo.neumann(-1)" == 3300
rcof "mata: foo.neumann(1.5)" == 3300
rcof "mata: foo.neumann(2)" == 3300
rcof "mata: foo.randit(-1)" == 3300
rcof "mata: foo.randit(1.5)" == 3300
rcof "mata: foo.randit(2)" == 3300


mata:
foo.rdim(5)
foo.cdim(10)
foo.idim(0)
foo.tdim(10)
foo.torus(1)
foo.neumann(1)
foo.randit(1)

assert(foo.rdim() == 5)
assert(foo.cdim() == 10)
assert(foo.idim() == 0)
assert(foo.tdim() == 10)
assert(foo.torus() == 1)
assert(foo.neumann() == 1)
assert(foo.randit() == 1)
foo.setup() // setup does not overwrite set parameters
assert(foo.rdim() == 5)
assert(foo.cdim() == 10)
assert(foo.idim() == 0)
assert(foo.tdim() == 10)
assert(foo.torus() == 1)
assert(foo.neumann() == 1)
assert(foo.randit() == 1)

end

mata:
foo = abm_grid()
foo.rdim(5)
foo.cdim(4)
foo.setup()

bla = foo.random_cell(60)
assert(all(bla :<= (5,4)))
assert(all(bla :> 0))
assert(all(floor(bla) :== bla))
bla = foo.schedule()
assert(all(bla :<= (5,4)))
assert(all(bla :> 0))
assert(all(floor(bla) :== bla))
end