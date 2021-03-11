mata: 
void nw_data::is_symmetric(| real scalar t)
{
	real scalar i, j, stop
	real vector cols
	
	is_nodesset()
	if (t==.) t=mod_gt((0,1,0))
		
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
	real scalar lb 
	lb = mod_gt((0,1,0))
	if (t==.) t=lb
	if (t==0 & setup == 1) {
		_error("network has been frozen")
	}
	if(t>lb ) {
		if (frozen[t]==1) _error("network has been frozen")
	}
}

void nw_data::is_setup()
{
	if(setup == 0) _error(3000,"setup is required")
}

void nw_data::is_nodesset()
{
	if (nodes_set==0) _error(3000, "setting number of nodes is required")
}

end
