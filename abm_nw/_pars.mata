mata:
transmorphic abm_nw::N_nodes( real scalar t, | real scalar N){
	t=parse_t(t)
	is_valid_time(t)
	
	
	if (args()==2){
	    is_posint(N)
		network.N_nodes(t,N)
	}
	else {
		return(network.N_nodes(t))
	}
}

transmorphic abm_nw::randomit(| real scalar bool)
{
    if(args()==1) {
	    is_bool(bool)
		network.randomit(bool)
	}
	else {
	    return(network.randomit())
	}
}

transmorphic abm_nw::tdim(| real scalar t)
{
	if(args()==1) {
		t=parse_t(t)	
	    is_posint(t)
		network.tdim(t)
	}
	else{
	    return(network.tdim())
	}
}

transmorphic abm_nw::directed(| real scalar bool)
{
    if (args()==1)  {
	    is_bool(bool)
		network.directed(bool)
	}
	else{
	    return(network.directed())
	}
}

transmorphic abm_nw::weighted(| real scalar bool)
{
	if(args()==1) {
		is_bool(bool)
		network.weighted(bool)
	}
	else {
		return(network.weighted())
	}
}



end
