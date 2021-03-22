mata:

transmorphic nw_data::N_nodes( real scalar t, | real scalar N){
		if (args()==2){
			if (t!=1) _error("number of nodes can only be set for t=1")
			is_frozen()
			N_nodes = N
		}
		else {
				return(N_nodes[t])
		}
}

transmorphic nw_data::randomit(| real scalar bool)
{
    if(args()==1) {
		is_frozen()
		randomit = bool
	}
	else {
	    return(randomit)
	}
}

transmorphic nw_data::tdim(| real scalar t)
{
	if(args()==1) {
	    is_frozen()
		tdim = t
	}
	else{
	    return(tdim)
	}
}

transmorphic nw_data::directed(| real scalar bool)
{
    if (args()==1)  {
		is_frozen()
		directed = bool
	}
	else{
	    return(directed)
	}
}

transmorphic nw_data::weighted(| real scalar bool)
{
	if(args()==1) {
		is_frozen()
		weighted = bool
	}
	else {
		return(weighted)
	}
}

transmorphic nw_data::nw_set(| real scalar bool)
{
	if (args()==1) {
		is_bool(bool)
		nw_set = bool
	}
	else {
		return(nw_set)
	}
}



end
