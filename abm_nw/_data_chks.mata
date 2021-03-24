mata: 

void nw_data::is_symmetric( real scalar t)
{
	real scalar i, j, stop
	real vector cols
	
	prepare()
			
	stop = 0

	for(i=1; i <= maxnodes;i++) {
		cols = neighbours(i,t)
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
	if (prepared == 0) return
	if (t==.) t=1
	if (frozen[t]==1) _error("network has been frozen")
}

void nw_data::is_setup()
{
	if(setup == 0) _error(3000,"setup is required")
}

void nw_data::is_prepared()
{
	if (prepared == 1) _error(3000, "initial parameters have already been set")
}

end
