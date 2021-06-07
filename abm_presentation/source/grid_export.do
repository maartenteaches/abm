include grid_locals.do

mata:

real matrix sir::export_sir()
{
    real matrix res
	pointer matrix p
	real scalar i, j

	res = J(N,tdim,.)
	p = agents.extract(`state', tdim)
	for (i=1; i<=N; i++) {
		for(j=1; j<=tdim; j++) {
			res[i,j] = *p[i,j]
		}
	}
	res =  (1..tdim)', mean(res:==`susceptible')', 
	                   mean(res:==`infectious')', 
					   mean(res:==`removed')'

    return(res)
}

void sir_grid::export_sir()
{
    real scalar r, c, i, xid, n
    real matrix res
    string rowvector varnames
    
    res = J(rdim*cdim*tdim, 6,.)

    i = 0
    for(r=1; r<=rdim; r++) {
        for(c=1; c<=cdim; c++) {
            res[|1+tdim*i++ ,1 \ (i+1)*tdim,6|] = J(tdim,1,(r,c)),town[r,c].export_sir()
        }
    }
    varnames = "r", "c", "t", "S", "I", "R"
    xid = st_addvar("float", varnames)
    n = st_nobs()
    n = rows(res) - n
    if (n > 0) {
        st_addobs(n)
    }
    st_store(.,xid, res)
}

end