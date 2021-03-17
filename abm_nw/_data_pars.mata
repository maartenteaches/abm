mata:

transmorphic nw_data::N_nodes( real scalar t, | real scalar N){
		real scalar i
		
		if (args()==2){
			if (t!=1) _error("number of nodes can only be set for t=1")
			is_frozen()
			N_nodes = N
		}
		else {
				return(N_nodes[t])
		}
}

transmorphic abm_nw::randomit(| real scalar bool)
{
    if(args()==1) {
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
		tdim = t
	}
	else{
	    return(tdim)
	}
}

transmorphic abm_nw::directed(| real scalar bool)
{
    if (args()==1)  {
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
		is_frozen()
		weighted = bool
	}
	else {
		return(weighted)
	}
}



end
