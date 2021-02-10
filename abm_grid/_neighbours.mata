mata:
real matrix abm_grid::neumannring(real scalar radius) 
{
	real matrix basering
	real rowvector pos, change
	
	pos = (radius, 0)
	basering = pos
	change = (-1,1)
	while (pos[1] != 0) {
		pos = pos + change
		basering = basering \ pos
	}
	change = (-1,-1)
	while (pos[2] != 0) {
		pos = pos + change
		basering = basering \ pos
	}
	change = (1,-1)
	while (pos[1] != 0) {
		pos = pos + change
		basering = basering \ pos
	}
	change = (1,1)
	while (pos[2] != -1) {
		pos = pos + change
		basering = basering \ pos
	}
	return(basering)
}

real matrix abm_grid::moorering(real scalar radius)
{
	real matrix basering
	real rowvector pos, change
	
	pos = (radius, radius)
	basering = pos
	change = (-1,0)
	while (pos[1] != -radius) {
		pos = pos + change
		basering = basering \ pos
	}
	change = (0,-1)
	while (pos[2] != -radius) {
		pos = pos + change
		basering = basering \ pos
	}
	change = (1,0)
	while (pos[1] != radius) {
		pos = pos + change
		basering = basering \ pos
	}
	change = (0,1)
	while (pos[2] != radius-1) {
		pos = pos + change
		basering = basering \ pos
	}
	return(basering)
}

void abm_grid::baserings() 
{
	real scalar radius
	real matrix basering
	
	baserings.reinit("real")
	
	
	if (neumann == 0) { 
		for(radius = 1; radius <= max((rdim,cdim)); radius++) {
			basering = moorering(radius)
			baserings.put(radius, basering)
		}
	}
	else { 
		for(radius = 1; radius <= max((rdim,cdim)); radius++) {
			basering = neumannring(radius)
			baserings.put(radius, basering)
		}
	}
}

real matrix abm_grid::basering(real scalar radius) 
{
	is_setup()
	
	if ( radius > max((rdim,cdim)) ) {
	 _error(3300, "radius must be less than or equal to max(rdim,cdim)")
	}
	
	return(baserings.get(radius))
}

real matrix abm_grid::torus_adj(real matrix pos)
{
	is_setup() 
	if (any(floor(pos):!=pos)) {
		_error("pos must contain integers")
	}
	if (cols(pos)!= 2) {
		_error("pos must contain two columns")
	}
	if (torus==0 & any(out_of_bounds(pos))) {
		_error("coordinates in pos are out of bounds")
	}
	return( mod( (pos:-1) , (rdim,cdim) ) :+ 1 )
}

real colvector abm_grid::out_of_bounds(real matrix pos) 
{
	is_setup() 
	is_int(pos)
	if (cols(pos)!= 2) {
		_error("pos must contain two columns")
	}
	return(rowsum(pos :<= 0) :| rowsum(pos:>(rdim,cdim)))
}

real matrix abm_grid::find_ring(real scalar r, real scalar c, 
                                real scalar radius)
{
	real matrix res, base
	real scalar i
	real rowvector neigh_pos, pos
	
	is_setup() 
	
	pos = r, c
	
	res = J(0,2,.)

	base = basering(radius)

	for(i=1; i<= rows(base) ; i++) {
		neigh_pos = base[i,.] :+ pos
		if (torus) {
			neigh_pos = torus_adj(neigh_pos)
		}
		else if ( out_of_bounds(neigh_pos) ) {
			continue
		}
		res = res \ neigh_pos
	}
	return(res)	
}

real matrix abm_grid::find_spiral(real scalar r, real scalar c, real scalar radius)
{
	real matrix res
	real scalar i
	
	is_setup() 
	
	res = J(0,2,.)
	for(i = 1 ; i <= radius ; i++) {
		res = res \ find_ring(r,c,i)
	}
	return(res)
}


end
