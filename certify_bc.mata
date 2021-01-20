clear all
cd "d:\mijn documenten\projecten\stata\abm\abm"

include current_version.do
do abm_bc.mata

mata:
doc = abm_bc()
doc.vnr("1.0.0")
assert(doc.vnr()== (1,0,0))

assert(doc.lessthan_version((0,6,4))==0)
assert(doc.lessthan_version((1,0,0))==0)
assert(doc.lessthan_version((5,6,4))==1)

// partial version number
doc.vnr("1.0.")
assert(doc.vnr()==(1,0,0))

doc.vnr("1.0")
assert(doc.vnr()==(1,0,0))

doc.vnr("1.")
assert(doc.vnr()==(1,0,0))

doc.vnr("1")
assert(doc.vnr()==(1,0,0))
end