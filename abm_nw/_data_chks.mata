mata: 
real scalar nw_data::parse_t(real scalar t)
{
	if (t==.) t= mod_gt((0,1,0))
	t = t + mod_leq((0,1,0))
	return(t)
}
void nw_data::is_symmetric( real scalar t)
{
	real scalar i, j, stop
	real vector cols
	
	is_nodesset()
			
	stop = 0

	for(i=1; i <= maxnodes;i++) {
		cols = neighbours(i,t, "dropped_ok")
		for(j=1; j<=length(cols);j++){
			if (weight(i,cols[j],t) != weight(cols[j],i,t)) {
				stop = 1
				_error(3000,"network is not symmetric")
				break
			}
		}
		if (stop) break
	}

}

void nw_data::is_frozen(| real scalar t)
{
	if (frozen[t]==1) _error("network has been frozen")
}

void nw_data::is_setup()
{
	if(setup == 0) _error(3000,"setup is required")
}

end
