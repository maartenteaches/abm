mata:
real rowvector abm_grid::make_key(real scalar r, real scalar c, real scalar t, real scalar i)
{
	string scalar errmsg

	is_setup() 
	is_valid_cell((r,c))
	if (idim == 1 ) {
		if (i != . & i != 1 & i != 0) {
			_error(3001, "you specified i, but set idim to 1")
		}
		else if ( i != 0 ) {
			i = 1
		}
	}
	else {
		if (i < 0 | (i > idim & idim != 0) | floor(i) != i ) {
			errmsg = "i must be an integer larger than or equal 0 " + 
			( idim == 0 ?  "" : "and less than or equal to " + strofreal(idim)) 
			_error(3300, errmsg)
		}
	}
	if (tdim == 0 ) {
		if (t != . & t != 0) {
			_error(3001, "you specified t, but set tdim to 0")
		}
		else {
			t = 0
		}
	}
	else {
		if (t < 0 | t > tdim | floor(t) != t ) {
			errmsg = "t must be an integer larger than or equal to 0, less than or equal to " + 
					strofreal(tdim)
			_error(3300, errmsg)
		}	
	}
	return((r,c,t,i))
}

void abm_grid::create_agent(real scalar r, real scalar c , 
                          real scalar agent_id, | real scalar t, real scalar i )
{
	real rowvector key
	
	is_setup() 
	
	if (i == 0) {
		_error(3000, "location 0 is reserved")
	}
	key = make_key(r, c, t, i)
	universe.put(key,agent_id)
	
	key = make_key(r,c,t,0)
	universe.put(key,(universe.get(key), i))
}

real scalar abm_grid::free_spot(real scalar r, real scalar c, real scalar t)
{
	real rowvector key, taken
	real scalar    attempt , done
	
	is_setup()
	
	key = make_key(r,c,t,0)
	taken = universe.get(key)
	
	done = 0
	attempt = length(taken) 
	while (!done) {
		attempt = attempt + 1
		if (!anyof(taken,attempt)) done = 1
	}
	return(attempt)
}

real scalar abm_grid::agent_id( real scalar r, real scalar c , | real scalar t, 
                                real scalar i)
{
	real rowvector key
	
	is_setup() 
	
	if (i == 0) {
		_error(3000, "location 0 is reserved")
	}
	
	key = make_key(r, c, t, i)
	return(universe.get(key))
}

real rowvector abm_grid::agent_ids( real scalar r, real scalar c , | real scalar t)
{
	real rowvector key, loc, res
	real scalar i
	
	is_setup() 
	
	loc = agent_loc(r,c,t)
	res = J(1,cols(loc),.)
	for (i = 1 ; i <= cols(loc); i++) {
		key = make_key(r,c,t,loc[i])
		res[i] = universe.get(key)
	}
	return(res)
}

real rowvector abm_grid::agent_loc(real scalar r, real scalar c, real scalar t)
{
	real rowvector key
	
	key = make_key(r, c, t, 0)
	
	return(universe.get(key))
}

real scalar abm_grid::has_agent(real scalar r, real scalar c, | real scalar t)
{
	real rowvector key
	
	is_setup() 
		
	key = make_key(r, c, t, 0)
	
	return(universe.exists(key))
}


void abm_grid::delete_agent(real scalar r, real scalar c, | real scalar t, 
                            real scalar i)
{
	real rowvector key, key_loc, loc
	
	is_setup() 
	
	if (i == 0) {
		_error(3000, "location 0 is reserved")
	}
	
	key = make_key(r, c, t, i)
	
	if (universe.exists(key) == 0) {
		_error(3499, "no agent in cell")
	}

	loc = agent_loc(r,c,t)
	if (!anyof(loc,i)) {
		_error(3499, "location not found in i = 0")
	}
	universe.remove(key)
	loc =  select(loc,loc :!= i)
	
	key_loc = make_key(r,c,t,0)
	if (cols(loc) == 0) {
		universe.remove(key_loc)
	}
	else {
		universe.put(key_loc,loc)
	}
}

void abm_grid::delete_agents(real scalar r, real scalar c, 
                            | real scalar t)
{

	real rowvector locs
	real scalar    i
	
	locs = agent_loc(r, c, t)
	for (i = 1 ; i <= cols(locs); i++) {
		delete_agent(r, c, t, locs[i])
	}

}

void abm_grid::copy_agent(
                   real scalar ro, real scalar co ,
                   real scalar rd, real scalar cd, 
				   | real scalar to, real scalar td,
				   real scalar io, real scalar id)
{
	real rowvector keyo, keyd, toreplace, locs
	
	is_setup() 
	
	if (to != . & td == .) {
		td = to
	}
	if (io != . & id == .) {
		id = io
	}
	
	if (io == 0 | id == 0) {
		_error(3000, "location 0 is reserved")
	}
	
	keyo = make_key(ro,co,to,io)
	keyd = make_key(rd,cd,td,id)
	
	locs =  agent_loc(rd,cd,td)
	if (anyof(locs,id)) {
		_error(3000, "location " + strofreal(id) + " already populated")
	}
	
	toreplace = universe.get(keyo)
	
	universe.put(keyd, toreplace)
	
	keyd = make_key(rd,cd,td,0)
	universe.put(keyd, (locs, id))
}

void abm_grid::copy_agents(real scalar ro, real scalar co, 
                           real scalar rd, real scalar cd,
						   | real scalar to, real scalar td)
{

	real rowvector locs
	real scalar i
	
	locs = agent_loc(ro, co, to)
	for (i = 1 ; i <= cols(locs); i++) {
		copy_agent(ro, co, rd, cd, to, td, locs[i],locs[i])
	}

}


void abm_grid::copy_grid(real scalar to, real scalar td) 
{
	real scalar r, c
	
	is_setup() 
	
	for(r=1 ; r<=rdim ; r++) {
		for (c=1; c<=cdim ; c++) {
			if (has_agent(r,c, to)) {
				copy_agents(r,c, r,c, to, td)
			}
		}
	}
}

void abm_grid::move_agent(
                   real scalar ro, real scalar co,
                   real scalar rd, real scalar cd, 
				   | real scalar to, real scalar td,
				   real scalar io, real scalar id)
{
	is_setup() 

	copy_agent(ro, co, rd, cd, to, td, io, id)
	delete_agent(ro,co, to, io)
}

void abm_grid::move_agents(
                   real scalar ro, real scalar co,
                   real scalar rd, real scalar cd, 
				   | real scalar to, real scalar td)
{
	is_setup() 

	copy_agents(ro, co, rd, cd, to, td)
	delete_agents(ro,co, to)
}

end
