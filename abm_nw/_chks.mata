mata: 
real scalar abm_nw::parse_t(real scalar t)
{
	t = (t==. ? 1 : t + mod_leq((0,1,0)))

	return(t)
}

void abm_nw::is_valid_time(real scalar time)
{
	if (time != .) {
		if (network.tdim() == 1 & time > 1) {
			_error(3000,"time is specified while there is no time dimension")
		}
		if (network.tdim()==. & time > 1) {
			_error(3000, "time is specified without specifying tdim")
		}
		is_posint(time)
		if(time > network.tdim()) {
			_error(3000,"specified time exceeds tdim")
		}
	}
}

void abm_nw::is_valid_id(real scalar id, | real scalar time, string scalar dropped_ok)
{
	if (args()==1) {
		time = 1
	}
	else {
		is_valid_time(time)
	}
	if (dropped_ok == "") {
		if(!anyof(network.nodes(time),id)) {
			_error(3000,"invalid id")
		}
	}
	else {
        is_posint(id)
		if ( id > network.maxnodes()  ) {
			_error(3000, "invalid id")
		}
	}
}

end
