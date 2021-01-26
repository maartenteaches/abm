cscript
cd "d:\mijn documenten\projecten\stata\abm\abm"

do abm_bc.mata

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

foo.mod_version("1.0.0")
assert(foo.mod_version()==(1,0,0))

foo.mod_version("1.0.")
assert(foo.mod_version()==(1,0,0))

foo.mod_version("1.0")
assert(foo.mod_version()==(1,0,0))

foo.mod_version("1.")
assert(foo.mod_version()==(1,0,0))

foo.mod_version("1")
assert(foo.mod_version()==(1,0,0))

foo.mod_version("1.0.0")
foo.test_lt()
foo.test_leq()
foo.test_gt()
foo.test_geq()

foo.mod_version("1.0.0")
foo.test_setup()
assert(foo.mod_version()==(1,0,0))

foo.mod_version("0.3.0")
foo.test_setup()
assert(foo.mod_version()==(0,3,0))

bar = testing()
bar.test_setup()
assert(bar.mod_version()==(1,0,0))

end
exit



// less than
assert(doc.mod_lt((0,6,4))==0)
assert(doc.mod_lt((1,0,0))==0)
assert(doc.mod_lt((5,6,4))==1)

// less or equal
assert(doc.mod_leq((0,6,4))==0)
assert(doc.mod_leq((1,0,0))==1)
assert(doc.mod_leq((5,6,4))==1)

// greater or equal
assert(doc.mod_geq((0,6,4))==1)
assert(doc.mod_geq((1,0,0))==1)
assert(doc.mod_geq((5,6,4))==0)

// greater than
assert(doc.mod_gt((0,6,4))==1)
assert(doc.mod_gt((1,0,0))==0)
assert(doc.mod_gt((5,6,4))==0)

// partial version number
doc.mod_version("1.0.")
assert(doc.mod_version()==(1,0,0))

doc.mod_version("1.0")
assert(doc.mod_version()==(1,0,0))

doc.mod_version("1.")
assert(doc.mod_version()==(1,0,0))

doc.mod_version("1")
assert(doc.mod_version()==(1,0,0))

// the purpose of this class is for it be inherrited
class model extends abm_bc {

}

model=model()
model.mod_version("1.0.0")
assert(model.mod_version()==(1,0,0))
assert(model.mod_lt((3,0,2))==1)
assert(model.mod_lt((0,0,2))==0)
end