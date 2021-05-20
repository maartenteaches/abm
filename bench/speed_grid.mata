cscript
cd "d:\mijn documenten\projecten\stata\abm\abm"
do abm.mata

mata:
model = abm_grid()
model.rdim(1000)
model.cdim(1000)
model.tdim(1)
model.torus(1)
timer_clear()
timer_on(1)
model.setup()
timer_off(1)

for(r=1; r<1000;r++){
    timer_on(3)
    foo = model.find_ring(500,500,r)
    timer_off(3)
}

timer()
end