mata:
void gol::setup()
{
    real scalar r,c, i, rr, cc
    real rowvector key
    real matrix neigh
    
    if (rdim == .) _error("rdim needs to be specified")
    if (cdim == .) _error("cdim needs to be specified")
    if (tdim == .) _error("tdim needs to be specified")
    if (init_state == J(0,0,.)) _error("initial state needs to be specified")
    if (rows(init_state) != rdim) _error("the number of rows in init_state does not equal rdim")
    if (cols(init_state) != cdim) _error("the number of columns in init_state does not equal cdim")
    
    grid.abm_version("0.1.4")
    grid.rdim(rdim)
    grid.cdim(cdim)
    grid.tdim(0)
    grid.neumann(0)
    grid.torus(1)
    grid.setup()
    
    state.abm_version("0.1.4")
    state.N(grid.size())
    state.k(1)
    state.setup()
    
    key = ., 1, 1
    i = 1
    for(r=1; r<=rdim; r++) {
        for(c=1; c<=cdim; c++) {
            key[1] = i++
            state.put(key, init_state[r,c])
        }
    }
    
    N_alive = J(rdim,cdim,0)
    for (r=1; r<=rdim; r++) {
        for (c=1; c<=cdim; c++) {
            neigh = grid.find_ring(r,c,1)
            for (i=1; i<=8; i++) {
                rr = neigh[i,1]
                cc = neigh[i,2]
                N_alive[r,c] = N_alive[r,c] + init_state[rr,cc]
            }
        }
    }
    future_N_alive = N_alive
}

void gol::run()
{
    real scalar t, r, c
    
    setup()
    dots(0)
    dots(1)
    for (t=2; t<=tdim; t++) {
        N_alive = future_N_alive
        for(r=1; r<=rdim; r++) {
            for(c=1; c<=cdim; c++) {
                step(r,c,t)
            }
        }
        dots(t)
    }
}

real scalar gol::make_id(real scalar r, real scalar c)
{
    return( (r-1)*cdim + c )
}

void gol::born(real scalar r, real scalar c, real scalar t, real rowvector key) 
{
    real scalar i, rr, cc, id
    real matrix neigh
    
    neigh = grid.find_ring(r,c,1)
    for(i=1; i<=8; i++) {
        rr = neigh[i,1]
        cc = neigh[i,2]
        future_N_alive[rr,cc] = future_N_alive[rr,cc] + 1 
    }
    state.put(key,1)
}

void gol::died(real scalar r, real scalar c, real scalar t, real rowvector key) 
{
    real scalar i, rr, cc, id
    real matrix neigh
    
    neigh = grid.find_ring(r,c,1)
    for(i=1; i<=8; i++) {
        rr = neigh[i,1]
        cc = neigh[i,2]
        future_N_alive[rr,cc] = future_N_alive[rr,cc] - 1 
    }
    state.put(key,0)    
}

void gol::step(real scalar r, real scalar c, real scalar t)
{
    real scalar id
    real rowvector key
  
    id = make_id(r,c)
    key = id, 1, t
 
    if(state.get(key, "last")==0) {
        if (N_alive[r,c] == 3) born(r,c,t, key)
    }
    else {
        if (N_alive[r,c] < 2 | N_alive[r,c] > 3) died(r,c,t, key)
    }
}

void gol::extract(string rowvector names)
{
	real matrix res
    pointer matrix pres
	real colvector color, happy
	real rowvector idx
	real scalar id, i, t, r, c
	
	if(cols(names)!=4){
		_error(3300, "names must contain 4 columns")
	}
	
    pres = state.extract(1,tdim)
    
    res = J(tdim*rdim*cdim, 4, .)
    
    i = 1
    for(t=1; t<=tdim; t++) {
        for(r=1; r<=rdim; r++) {
            for(c=1; c<=cdim; c++) {
                res[i,1] = t
                res[i,2] = r
                res[i,3] = c
                id = make_id(r,c)
                res[i,4] = *pres[id,t]
                i =i+1
            }
        } 
    }

	
	idx = st_addvar("float", names)

	if (st_nobs() < rows(res) ) {
		st_addobs(rows(res) - st_nobs())
	}
	st_store(.,idx,res)
}
end
