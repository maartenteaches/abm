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

void abm_grid::neumannring2(real scalar radius) 
{
	real matrix basering
	real rowvector pos, change
	real scalar i
	
	pos = (radius, 0)
	basering = J(radius*4,2,.)
	basering[1,.] = pos
	change = (-1,1)
	i = 1
	while (pos[1] != 0) {
		pos = pos + change
		basering[i++,.] = pos
	}
	change = (-1,-1)
	while (pos[2] != 0) {
		pos = pos + change
		basering[i++,.] = pos 
	}
	change = (1,-1)
	while (pos[1] != 0) {
		pos = pos + change
		basering[i++,.] = pos
	}
	change = (1,1)
	while (pos[2] != -1) {
		pos = pos + change
		basering[i++,.] = pos 
	}
	baserings2[radius] = &basering
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

void abm_grid::moorering2(real scalar radius)
{
	real matrix basering
	real rowvector pos, change
	real scalar i
	
	pos = (radius, radius)
	basering = J(radius*8,2, .)
	basering[1,.] = pos
	change = (-1,0)
	i = 1
	while (pos[1] != -radius) {
		pos = pos + change
		basering[++i,.] = pos
	}
	change = (0,-1)
	while (pos[2] != -radius) {
		pos = pos + change
		basering[++i,.] = pos
	}
	change = (1,0)
	while (pos[1] != radius) {
		pos = pos + change
		basering[++i,.] = pos
	}
	change = (0,1)
	while (pos[2] != radius-1) {
		pos = pos + change
		basering[++i,.] = pos
	}
	baserings2[radius] = &basering
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

void abm_grid::baserings2() 
{
	real scalar radius, max
	real matrix basering
	
	max = max((rdim,cdim))
	baserings2 = J(max-1,1,NULL)
	radius = max 
	if (neumann == 0) { 
		while (--radius) {
			moorering2(radius)
		}
	}
	else { 
		while(--radius) {
			neumannring2(radius)
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

real matrix abm_grid::basering2(real scalar radius) 
{
	is_setup()
	
	if ( radius >= max((rdim,cdim)) ) {
	 _error(3300, "radius must be less than to max(rdim,cdim)")
	}
	
	return(*baserings2[radius])
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

real matrix abm_grid::find_ring2(real scalar r, real scalar c, 
                                real scalar radius)
{
	real matrix res, base
	real scalar i
	real rowvector neigh_pos, pos
	
	is_setup() 
	
	pos = r, c
	
	base = basering2(radius)
	i = rows(base) + 1
	if (torus) {
		res = J((8-neumann*4)*radius,2,.)
		while(--i) {
			neigh_pos = base[i,.] :+ pos
			neigh_pos = torus_adj(neigh_pos)
			res[i,.] = neigh_pos
		}
	}
	else {
		res = J(0,2,.)
		while(--i) {
			neigh_pos = base[i,.] :+ pos
			if ( out_of_bounds(neigh_pos) ) {
				continue
			}
			res = res \ neigh_pos
		}
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
