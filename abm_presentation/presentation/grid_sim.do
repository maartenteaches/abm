include grid_locals.do

mata:

void sir_grid::run()
{
    real scalar t, r, c
    setup()
    dots(0)
    dots(1)
    for (t=2; t<=tdim; t++) {
        for (r=1; r<=rdim; r++) {
            for (c=1; c<=cdim; c++) {
                town[r,c].run(t)
            }
        }
        for (r=1; r<=rdim; r++) {
            for (c=1; c<=cdim; c++) {
                travel(r,c,t)
            }
        }
        dots(t)
    }  
}

void sir_grid::setup()
{
    real scalar r, c, j, initial
        
	if (N==J(0,0,.))                   _error("N has not been set")
	if (tdim==.)                       _error("tdim has not been set")
	if (outbreak==.)                   _error("outbreak has not been set")
	if (removed==J(0,0,.))             removed = 0
	if (mcontacts==J(0,0,.))           _error("mcontacts has not been set")
	if (transmissibility==.)           _error("transmissibility has not been set")
	if (mindur==.)                     _error("mindur has not been specified")
	if (meandur==.)                    _error("meandur has not been specified")
	if (pr_loss==.)                    pr_loss = 0
    if (prop_close==.)                 _error("N_close has not been specified")
    if (prop_medium==.)                prop_medium = 0
    if (prop_far==.)                   prop_far = 0
    
    if (rows(N) == 1 & cols(N) == 1){
    	N = J(rdim, cdim, N)
    }
    else if (rows(N)!=rdim | cols(N)!= cdim) {
    	_error("N can either be a scalar or a rdim x cdim matrix")
    }
    if (rows(removed) == 1 & cols(removed) == 1 ) {
    	removed = J(rdim,cdim,removed)
    }
    else if (rows(removed)!= rdim | cols(removed)!= cdim) {
    	_error("removed can either be a scalar or a rdim x cdim matrix")
    }
    if (rows(mcontacts) == 1 & cols(mcontacts)==1) {
    	mcontacts = J(rdim,cdim,mcontacts)
    }
    else if (rows(mcontacts)!=rdim | cols(mcontacts)!= cdim) {
    	_error("mcontacts can either be a scalar or rdim x cdim matrix")
    }
    
    grid.abm_version("0.1.5")
    grid.rdim(rdim)
    grid.cdim(cdim)
    grid.neumann(0)
    grid.torus(0)
    grid.setup()
    
    town = sir(rdim,cdim)
    initial = ceil(runiform(1,1)*rdim*cdim)
    j= 0
    for(r=1; r<=rdim; r++) {
        for(c=1; c<=cdim; c++) {
            j = ++j
            town[r,c].N(N[r,c])
            town[r,c].tdim(tdim)
            town[r,c].outbreak((j==initial)*outbreak)
            town[r,c].removed(removed[r,c])
            town[r,c].mcontacts(mcontacts[r,c])
            town[r,c].transmissibility(transmissibility)
            town[r,c].mindur(mindur)
            town[r,c].meandur(meandur)
            town[r,c].pr_loss(pr_loss)
            town[r,c].vil_id(j)
            town[r,c].setup()
        }
    } 
}

void sir_grid::travel(real scalar r, real scalar c, real scalar t)
{
    travel_contact(r,c,t,"close")
    travel_contact(r,c,t,"medium")
    travel_contact(r,c,t,"far")
}

void sir_grid::travel_contact(real scalar r, real scalar c, real scalar t, string scalar where)
{
    real scalar i, j, k, tr, tc, N_travel, target
    real vector traveling, key
    real matrix neigh, exposed

    if (where == "close") {
        N_travel = ceil(prop_close*N[r,c])
        traveling = ceil(runiform(1,N_travel)*N[r,c])
        neigh = grid.find_ring(r,c,1)
        
    }
    else if (where == "medium") {
        N_travel = ceil(prop_medium*N[r,c])
        traveling = ceil(runiform(1,N_travel)*N[r,c])
        neigh = grid.find_ring(r,c,2)
        
    }
    else {
        N_travel = ceil(prop_far*N[r,c])
        traveling = ceil(runiform(1,N_travel)*N[r,c])
        neigh = grid.schedule()
        
    }
    k = rows(neigh)

    for(i=1; i<=N_travel; i++) {
        if (town[r,c].state(traveling[i],t)== `infectious') {
            target = ceil(runiform(1,1)*k)
            tr = neigh[target,1]
            tc = neigh[target,2]
            exposed = town[tr, tc].meet(traveling[i],town[r,c].vil_id)
         	for(j=1; j<= cols(exposed); j++) {
                exposed[3,j] = town[tr,tc].infect(exposed[1,j],t) 
            }
            key = traveling[i],`exposes', t
            exposed = town[r,c].agents.get(key), exposed
            town[r,c].agents.put(key,exposed)
        }
    }
}

end
