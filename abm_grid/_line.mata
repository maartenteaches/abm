mata:

real rowvector abm_grid::lerp(real rowvector orig, real rowvector dest, real scalar t)
{
	return(round(orig :+ t:*(dest:-orig)))
}

real matrix abm_grid::torus_closest(real rowvector orig, real rowvector dest)
{
	real rowvector dist
		
	if (torus== 1) {
		dist = abs(dest:-orig)
		if (dist[1] > .5*cdim) {
			if (orig[1] < dest[1]) {
				orig[1] = orig[1] + cdim
			}
			else {
				dest[1] = dest[1] + cdim
			}
		}
		if (dist[2] > .5*rdim) {
			if (orig[2] < dest[2]) {
				orig[2] = orig[2] + rdim
			}
			else {
				dest[2] = dest[2] + rdim
			}
		}		
	}
	return(orig\dest)
}

real scalar abm_grid::dist(real rowvector orig, real rowvector dest, | string scalar what)
{
	real rowvector dist
	string scalar errmsg
	real matrix points

	is_valid_cell((orig\dest))
	
	points = torus_closest(orig, dest)
	orig = points[1,.]
	dest = points[2,.]
	dist = abs(dest :- orig)
	
	if ( (args()==2 & neumann == 0) | usubstr(what,1, 4) == "cheb" ) {
		return(max(dist))
	}
	else if ((args() == 2 & neumann == 1)| usubstr(what,1,3) == "man" ) {
		return(sum(dist))
	}
	else if (usubstr(what,1,4) == "eucl"){
		return(sqrt(sum(dist:^2)))
	}
	else {
		errmsg = "what can contain either chebyshev, manhattan, or eucledian"
		_error(errmsg)
	}
}

real matrix abm_grid::comp_line(real rowvector orig, real rowvector dest, string scalar what)
{
	string scalar    dist_type
	real   scalar    n, i, t, sign_x, sign_y, ix, iy
	real   rowvector dist
	real   matrix    res
	
	dist_type = (what == "inter" ? "chebyshev" : "manhattan")
	n = dist(orig, dest, dist_type)
	res = J(n+1,2,.)

	if (what == "ortho") {
		dist = dest :- orig
		sign_x = (dist[2]>=0 ? 1: -1)
		sign_y = (dist[1]>=0 ? 1: -1)
		dist = abs(dist)
		res[1, .] = orig
		
		ix = iy = 0
		
		for (i=1; i <= n ; i++) {
			res[i+1,.] = res[i,.]
			if ((0.5+ix) / dist[2] < (0.5+iy) / dist[1]) {
				res[i+1,2] = res[i+1,2] + sign_x
				ix = ix + 1
			}
			else {
				res[i+1,1] = res[i+1,1] + sign_y
				iy = iy + 1			
			}
		}
	}
	else {
		for(i=0 ; i <= n ; i++) {
			t = (i==0 ? 0 : i/n)
			res[i+1,.] = lerp(orig, dest, t)
		}
	}
	return(res)
}

real matrix abm_grid::find_line(real rowvector orig, real rowvector dest,| string scalar what)
{
	string scalar    errmsg
	real   matrix    res, points

	is_valid_cell((orig\dest))
	
	if (args()<3) {
		if (neumann == 0) {
			what = "inter"
		}
		else {
			what = "ortho"
		}
	}
	else {
		what = usubstr(what,1,5)
	}
	
	if (what != "inter" & what != "ortho") {
		errmsg = "what can contain either interpolate or orthogonal"
		_error(errmsg)
	}

	points = torus_closest(orig, dest)
	orig = points[1,.]
	dest = points[2,.]
	
	res = comp_line(orig, dest, what)

	return(torus_adj(res))
}

end
