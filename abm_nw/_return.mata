mata:

real scalar abm_nw::edge_exists(real scalar ego, real scalar alter, | real scalar t, string scalar fast)
{
	real scalar res
	
	if (args()==2) t=0
	if (args()<4) {
		is_valid_id(ego, t)
		is_valid_id(alter, t)
	}
	if (t==0) {
		res = anyof(*adjlist0[ego], alter)
	}
	else {
		res = anyof(*adjlist[ego,t], alter)
	}
	return(res)
}

real rowvector abm_nw::neighbours(real scalar ego, | real scalar t, string scalar dropped_ok, string scalar fast)
{
	if (t==.) t=0
	if (args() < 4) {
		is_valid_id(ego, t, dropped_ok)
		is_nodesset()
	}
	if (t==0) {
		return(*adjlist0[ego])
	} 
	else {
		return(*adjlist[ego,t])
	}
	
} 




real scalar abm_nw::N_edges(| real scalar t)
{
	is_valid_time(t)
	if (t==.) t = 0
	if (t==0) {
		return(N_edges0)
	}
	else {
		return(N_edges[t])
	}
}
	
void abm_nw::no_edge(real scalar t, real scalar orig, real scalar dest, | string scalar fast) 
{
	if (args()<4) {
		is_valid_id(orig,t)
		is_valid_id(dest,t)
	}
	if(edge_exists(orig, dest, t, "fast")) {
		_error(3000,"edge already defined")
	}
	if (directed == 0) {
		if(edge_exists(dest,orig,t, "fast")) {
			_error(3000,"edge already defined")
		}		
	}
}

real scalar abm_nw::weight(real scalar ego, real scalar alter, | real scalar t, string scalar fast)
{
	if (args() < 4) {
		is_valid_id(ego)
		is_valid_id(alter)
	}
	if (t==.) t=0
	if (weighted) {
		return(network.get((t,ego,alter)))
	}
	else {
		if(t==0) {
			return(anyof(*adjlist0[ego], alter))
		}
		else{
			return(anyof(*adjlist[ego,t], alter))
		}
	}
}

real vector abm_nw::schedule(| real scalar t)
{
	real vector res
	
    if(args()==0) t = 0
	is_valid_time(t)
	if (t==0) {
		res = nodes0
	}
	else {
	    res = *nodes[t]
	}
	if (randomit) res = jumble(res')'
	return(res)
}

end
