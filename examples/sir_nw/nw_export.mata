include examples/sir_nw/nw_locals.mata

mata:

void sir_nw::export_sir()
{
    real matrix res
	pointer matrix p
    string rowvector varnames
	real scalar xid, n, i, j

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
    varnames = "t", "S", "I", "R"
    xid = st_addvar("float", varnames)
    n = st_nobs()
    n = rows(res) - n
    if (n > 0) {
        st_addobs(n)
    }
    st_store(.,xid, res)
}

void sir_nw::export_r()
{
	real matrix res
	pointer matrix p_exposes, p_state
	real scalar xid, n, i, j, t
	string rowvector varnames
	real colvector n_ill

	t = .
	
	res = (1..tdim)',J(tdim,1,0)
	n_ill = J(tdim,1,0)
	p_exposes = agents.extract(`exposes',tdim)
	p_state = agents.extract(`state',tdim)
	for (i=1; i<=N; i++) {
		if (*p_state[i,1]==`infectious') {
			t=1  
		} 
		else {
		    t=.
		}
		for(j=2;j<=tdim;j++) {
			if (*p_state[i,j-1]==`susceptible' & 
			    *p_state[i,j]  ==`infectious') {
					t=j
					n_ill[t] = n_ill[t] + 1
				}
			if (*p_state[i,j-1]==`infectious' & 
			    (*p_state[i,j]  ==`removed' | *p_state[i,j]  ==`susceptible')) t = .
			if (t!=.) {
			    res[t,2] = res[t,2] + rowsum((*p_exposes[i,j])[2,.])
			}
		}
	}
	res[.,2] = res[.,2]:/n_ill
	varnames = "t", "reprod"
    xid = st_addvar("float", varnames)
    n = st_nobs()
    n = rows(res) - n
    if (n > 0) {
        st_addobs(n)
    }
    st_store(.,xid, res)
	
}

void sir_nw::export_nw()                             // <-- new
{
    real vector xid
    real matrix result, state
    real scalar i, j, k, n
    string vector varnames
	pointer matrix p
	
	p = agents.extract(`state', tdim)
	state = J(N,tdim,.)
	for (i=1; i<=N; i++) {
		for(j=1; j<=tdim; j++) {
			state[i,j] = *p[i,j]
		}
	}
	
	result = nw.export_edgelist(0, "ego_all") 
    result = result, J(rows(result),tdim,.)
    for (i=1; i<=rows(result);i++) {
        result[|i,4 \ i, .|] = state[result[i,1],.]
    }

	k = cols(result)
    varnames = J(1,k,"")
    varnames[1..3] = "ego", "alter","weight"
    for(i = 4 ; i <= k; i++) {
        varnames[i] = "state" + strofreal(i-3)
    }
    xid = st_addvar("long", varnames)
    n = st_nobs()
    n = rows(result) - n
    if (n > 0) {
        st_addobs(n)
    }
    st_store(.,xid, result)
    st_local("n", strofreal(N))
}


end