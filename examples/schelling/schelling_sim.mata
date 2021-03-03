
mata:
void schelling::step(real scalar t, real scalar r, real scalar c) 
{
	if (is_happy(t,r,c,t,r,c)==0) {
		move(t,r,c)
	}
}

void schelling::run() {
	real scalar  t, k, r, c
	real matrix coords
	
	setup_universe()
	setup_agents()
	populate_universe()
	
	for(t=1; t < universe.tdim() ; t++) {
		universe.copy_grid(t, t+1)
		coords = universe.schedule()
		for(k=1; k <= rows(coords); k++){
			r = coords[k,1]
			c = coords[k,2]
			if (universe.has_agent(r,c,t)) {
				step(t, r, c)
			}
		}
	}
}

void schelling::move(real scalar t, real scalar r, real scalar c)
{
	real scalar    radius, i, maxradius, rd, cd, stop
	real matrix    neigh
	
	stop = 0
	maxradius = max( ( rdim-r, r-1, cdim-c, c-1 ) )

	for (radius = 1 ; radius <= maxradius ; radius ++) {
		neigh = universe.find_ring(r,c,radius)
		for (i = 1; i <= rows(neigh); i++) {
			rd = neigh[i,1]
			cd = neigh[i,2]
			if (universe.has_agent(rd,cd, t+1) == 0) {
				if ( is_happy(t+1, rd, cd, t, r, c) ) {
					universe.move_agent(r,c, rd, cd, t+1)
					stop = 1
					break
				}
			}
		}
		if (stop == 1) break
	}
}

string scalar schelling::get_color(real scalar t, real scalar r, real scalar c)
{
	real scalar    id
	
	if (universe.has_agent(r,c,t)) {
		id = universe.agent_id(r, c,t)
	}
	else {
		_error(3300, "no agent in this cell")
	}
	return(agents[id])
}

real scalar schelling::sum_neighbours(
                                real scalar t, real scalar r, real scalar c, 
								real scalar ts, real scalar rs, real scalar cs) 
{
	real   scalar    k, s, i, j, l, isself
	real   matrix    neigh
	string scalar    self
	
	self = get_color(ts,rs,cs)
	
	neigh = universe.find_ring(r,c,1)
	k = 0
	s = 0
	for (l=1 ; l <=rows(neigh) ; l++) {
		i = neigh[l,1]
		j = neigh[l,2]
		isself = (i==rs & j==cs)
		if (universe.has_agent(i,j,t) & !isself) {
			k = k + 1
			s = s + (get_color(t,i,j)==self)
		}
	}
	return((k==0 ? 1 : s/k))
}

real scalar schelling::is_happy(
	real scalar t , real scalar r , real scalar c , 
	real scalar ts, real scalar rs, real scalar cs)
{
	real   scalar prop
		
	prop   = sum_neighbours(t,r,c,ts,rs,cs)
	
	return(prop >= limit)
}

void schelling::setup_agents() 
{
	real   scalar i, k
	string scalar errmsg
	
	if (limit == .) {
		_error(3300, "limit has not been set")
	}
	if (nblue == .) {
		_error(3300, "number of blue agents has not been set")
	}
	if (nred == .) {
		_error(3300, "number of red agents has not been set")
	}
	nagents = nred + nblue
	if (nagents > universe.size()) {
		errmsg = "you specified " + strofreal(nagents) + " agents on a " +
		         strofreal(rdim()) + " by " + strofreal(cdim()) + " grid"
		_error(3300, errmsg)
	}
	agents = J(nagents,1,"")
	
	k = 0
	for (i = 1 ; i <= nred ; i++) {
		k = k +1
		agents[k]= "red"
	}
	for (i = 1 ; i <= nblue ; i++) {
		k = k +1
		agents[k] = "blue"
	}
}

void schelling::populate_universe(){
	real matrix grid0
	real scalar i, r, c
	
	grid0 = universe.schedule()
	_jumble(grid0)
	for(i = 1 ; i <= nagents ; i++) {
		r = grid0[i,1]
		c = grid0[i,2]

		universe.create_agent(r,c,i,1)
	}
}

void schelling::setup_universe()
{
	if (tdim()==.) {
		_error(3000, "tdim must be set first")
	}
	universe.abm_version("0.2.0")
	universe.setup()
}	

end
