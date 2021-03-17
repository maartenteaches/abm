mata:

real scalar nw_data::edge_exists(real scalar ego, real scalar alter, real scalar t)
{
	real scalar res
	
	res = anyof(*adjlist[ego,t], alter)
	return(res)
}

real rowvector nw_data::neighbours(real scalar ego, real scalar t)
{
	return(*adjlist[ego,t])
} 

real scalar nw_data::N_edges( real scalar t)
{
	return(N_edges[t])
}
	
void nw_data::no_edge(real scalar t, real scalar orig, real scalar dest) 
{
	if(edge_exists(orig, dest, t)) {
		_error(3000,"edge already defined")
	}
	if (directed == 0) {
		if(edge_exists(dest,orig,t)) {
			_error(3000,"edge already defined")
		}		
	}
}

real scalar nw_data::weight(real scalar ego, real scalar alter, real scalar t)
{
	if (weighted) {
		return(network.get((t,ego,alter)))
	}
	else {
		return(anyof(*adjlist[ego,t], alter))
	}
}

real vector nw_data::schedule( real scalar t)
{
	real vector res

    res = *nodes[t]
	if (randomit) res = jumble(res')'
	return(res)
}

real vector nw_data::nodes(real scalar t)
{
	return(*nodes[time])
}

real scalar nw_data::maxnodes()
{
	return(maxnodes)
}

end
