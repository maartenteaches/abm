mata:

class testing extends abm_bc {
    void test_lt()
    void test_leq()
    void test_gt()
    void test_geq()
    void test_setup()
}

void testing::test_lt()
{
    assert(mod_lt((0,6,4))==0)
    assert(mod_lt((1,0,0))==0)
    assert(mod_lt((5,6,4))==1)    
}

void testing::test_leq()
{
    assert(mod_leq((0,6,4))==0)
    assert(mod_leq((1,0,0))==1)
    assert(mod_leq((5,6,4))==1)
}

void testing::test_gt()
{
    assert(mod_gt((0,6,4))==1)
    assert(mod_gt((1,0,0))==0)
    assert(mod_gt((5,6,4))==0)
}

void testing::test_geq()
{
    assert(mod_geq((0,6,4))==1)
    assert(mod_geq((1,0,0))==1)
    assert(mod_geq((5,6,4))==0)
}

void testing::test_setup()
{
    bc_setup()
}

foo = testing()

foo.abm_version("1.0.0")
assert(foo.abm_version()==(1,0,0))

foo.abm_version("1.0.")
assert(foo.abm_version()==(1,0,0))

foo.abm_version("1.0")
assert(foo.abm_version()==(1,0,0))

foo.abm_version("1.")
assert(foo.abm_version()==(1,0,0))

foo.abm_version("1")
assert(foo.abm_version()==(1,0,0))

foo.abm_version("1.0.0")
foo.test_lt()
foo.test_leq()
foo.test_gt()
foo.test_geq()

foo.abm_version("1.0.0")
foo.test_setup()
assert(foo.abm_version()==(1,0,0))

foo.abm_version("0.3.0")
foo.test_setup()
assert(foo.abm_version()==(0,3,0))

bar = testing()
bar.test_setup()
assert(bar.abm_version()==(1,0,0))

end
exit
