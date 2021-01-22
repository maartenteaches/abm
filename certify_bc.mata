clear all
cd "d:\mijn documenten\projecten\stata\abm\abm"

include current_version.do
do abm_bc.mata

mata:
doc = abm_bc()
doc.mod_version("1.0.0")
assert(doc.mod_version()== (1,0,0))

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
model.mod_version("2.1.0")
assert(model.mod_version()==(2,1,0))
assert(model.mod_lt((3,0,2))==1)
assert(model.mod_lt((1,0,2))==0)
end