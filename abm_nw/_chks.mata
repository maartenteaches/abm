mata: 
void abm_nw::is_symmetric(| real scalar t)
{
	real scalar i, j, stop
	real vector cols
	
	is_nodesset()
	is_valid_time(t)
	if (t==.) t=0
	
	
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

void abm_nw::is_valid_time(real scalar time)
{
	if (time != .) {
		if (tdim == 0 & time > 0) {
			_error(3000,"time is specified while there is no time dimension")
		}
		if (tdim==. & time > 0) {
			_error(3000, "time is specified without specifying tdim")
		}
		is_posint(time, "zero_ok")
		if(time > tdim) {
			_error(3000,"specified time exceeds tdim")
		}
	}
}

void abm_nw::is_valid_id(real scalar id, | real scalar time, string scalar dropped_ok)
{
	is_nodesset()
    is_valid_time(time)
	if (dropped_ok == "") {
		if (args()==1 | time == 0) {
			if(!anyof(nodes0,id)) {
				_error(3000,"invalid id")
			}
		}
		else{
			if(!anyof(*nodes[time],id)) {
				_error(3000,"invalid id")
			}
		}	
	}
	else {
        is_posint(id, "zero_ok")
		if ( id > maxnodes  ) {
			_error(3000, "invalid id")
		}
	}
}

void abm_nw::is_frozen(| real scalar t)
{
	if (t==.) t=0
	is_valid_time(t)
	if (t==0 & setup == 1) {
		_error("network has been frozen")
	}
	if(t>0 ) {
		if (frozen[t]==1) _error("network has been frozen")
	}
}

void abm_nw::is_setup()
{
	if(setup == 0) _error(3000,"setup is required")
}

void abm_nw::is_nodesset()
{
	if (nodes_set==0) _error(3000, "setting number of nodes is required")
}

end
