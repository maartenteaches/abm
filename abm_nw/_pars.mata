mata:
transmorphic abm_nw::N_nodes( real scalar t, | real scalar N){
		real scalar i
		is_valid_time(t)
		if (t==.) t=0
		
		if (args()==2){
			if (t!=0) _error("number of nodes can only be set for t=0")
		    is_posint(N)
			is_frozen()
			N_nodes0 = N
			adjlist0 = J(N_nodes0,1,NULL)
			for(i=1; i<=N_nodes0; i++) {
				adjlist0[i] = &(J(1,0,.))
			}
			nodes0 = 1..N_nodes0
			maxnodes = N_nodes0
			dropped_nodes0 = J(1,0,.)
			nodes_set=1
		}
		else {
			if (t==0) {
				return(N_nodes0)
			}
		    else {
				return(N_nodes[t])
			}
		}
}

transmorphic abm_nw::randomit(| real scalar bool)
{
    if(args()==1) {
	    is_bool(bool)
		is_frozen()
		randomit = bool
	}
	else {
	    return(randomit)
	}
}

transmorphic abm_nw::tdim(| real scalar t)
{
    real scalar i,j
	
	if(args()==1) {
	    is_frozen()
	    is_posint(t, "zero_ok")
	    is_nodesset()
		tdim = t
		if (tdim > 0) {
			adjlist = J(maxnodes, tdim, NULL)
			nodes = J(tdim,1,NULL)
			N_nodes = J(tdim,1,.)
			N_edges = J(tdim,1,0)
			dropped_nodes = J(tdim,1,NULL)
			frozen = J(tdim,1,0)
			for(i=1;i<=tdim; i++) {
				dropped_nodes[i] = &(J(1,0,.))
			}
			
			for(i=1; i<= maxnodes; i++) {
				for(j=1; j<=tdim; j++) {
					adjlist[i,j] = &(J(1,0,.))
				}
			}
		}
	}
	else{
	    return(tdim)
	}
}

transmorphic abm_nw::directed(| real scalar bool)
{
    if (args()==1)  {
	    is_bool(bool)
		is_frozen()
		directed = bool
	}
	else{
	    return(directed)
	}
}

transmorphic abm_nw::weighted(| real scalar bool)
{
	if(args()==1) {
		is_bool(bool)
		is_frozen()
		weighted = bool
	}
	else {
		return(weighted)
	}
}



end
