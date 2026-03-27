mata:

//# N_nodes()
transmorphic nw_data::N_nodes( real scalar t, | real scalar N){
		if (args()==2){
			if (t!=1) _error("number of nodes can only be set for t=1")
			is_prepared()
			N_nodes = N
		}
		else {
				return(N_nodes[t])
		}
}

//# randomit()
transmorphic nw_data::randomit(| real scalar bool)
{
    if(args()==1) {
		is_frozen()
		is_bool(bool)
		randomit = bool
	}
	else {
	    return(randomit)
	}
}

//# tdim()
transmorphic nw_data::tdim(| real scalar t)
{
	if(args()==1) {
	    is_prepared()
		is_posint(t)
		tdim = t
	}
	else{
	    return(tdim)
	}
}

//# directed()
transmorphic nw_data::directed(| real scalar bool)
{
    if (args()==1)  {
		is_prepared()
		is_bool(bool)
		directed = bool
	}
	else{
	    return(directed)
	}
}

//# weighted()
transmorphic nw_data::weighted(| real scalar bool)
{
	if(args()==1) {
		is_prepared()
		is_bool(bool)
		weighted = bool
	}
	else {
		return(weighted)
	}
}

//# nw_set()
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
