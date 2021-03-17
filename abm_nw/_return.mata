mata:

real scalar abm_nw::edge_exists(real scalar ego, real scalar alter, | real scalar t)
{
	t = parse_t(t)
	is_valid_id(ego, t)
	is_valid_id(alter, t)
	
	return(network.edge_exists(ego,alter,t))
}

real rowvector abm_nw::neighbours(real scalar ego, | real scalar t, string scalar dropped_ok)
{
	t = parse_t(t)
	is_valid_id(ego, t, dropped_ok)

	return(network.neighbours(ego, t))
} 

real scalar abm_nw::N_edges(| real scalar t)
{
	t = parse_t(t)
	is_valid_time(t)

	return(network.N_edges(t))
}
	
void abm_nw::no_edge(real scalar t, real scalar orig, real scalar dest) 
{
	t = parse_t(t)
	is_valid_id(orig,t)
	is_valid_id(dest,t)
	
	network.no_edge(t, orig, dest)
}

real scalar abm_nw::weight(real scalar ego, real scalar alter, | real scalar t)
{
	t = parse_t(t)
	is_valid_id(ego)
	is_valid_id(alter)
	
	return(network.weight(ego, alter, t))
}

real vector abm_nw::schedule(| real scalar t)
{
	t = parse_t(t)
	is_valid_time(t)
	
	return(network.schedule(t))
}

end
