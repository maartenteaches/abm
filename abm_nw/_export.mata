mata:

**# export_adjmat
real matrix abm_nw::export_adjmat(|real scalar t) 
{
	t = parse_t(t)
	is_valid_time(t)
	
	return(network.export_adjmat(t))
}

**# export_edgelist
real matrix abm_nw::export_edgelist(| real scalar t, string scalar ego_all)
{
    t = parse_t(t)
	is_valid_time(t)
	
	return(network.export_edgelist(t,ego_all))
}

end
