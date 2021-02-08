mata:

transmorphic abm_grid::neumann(| real scalar newval) 
{
	if (args() == 1) {
		is_bool(newval)
		neumann = newval
		setup = 0
	}
	else {
		return(neumann)
	}
}

transmorphic abm_grid::torus(| real scalar newval) 
{
	if (args() == 1) {
		is_bool(newval)
		torus = newval
		setup = 0
	}
	else {
		return(torus)
	}
}

transmorphic abm_grid::randit(| real scalar newval) 
{
	if (args() == 1) {
		is_bool(newval)
		randit = newval
		setup = 0
	}
	else {
		return(randit)
	}
}

transmorphic abm_grid::idim(| real scalar dim) 
{
	if (args() == 1) {
		is_posint(dim, "zero_ok")
		idim = dim
		setup = 0
	}
	else {
		return(idim)
	}
}
transmorphic abm_grid::tdim(| real scalar dim) 
{
	if (args() == 1) {
		is_posint(dim, "zero_ok")
		tdim = dim
		setup = 0
	}
	else {
		return(tdim)
	}
}
transmorphic abm_grid::rdim(| real scalar dim) 
{
	if (args() == 1) {
		is_posint(dim)
		rdim = dim
		setup = 0
	}
	else {
		return(rdim)
	}
}
transmorphic abm_grid::cdim(| real scalar dim)
{
	if (args() == 1) {
		is_posint(dim)		
		cdim = dim
		setup = 0
	}
	else {
		return(cdim)
	}
}

real scalar abm_grid::size()
{
	is_setup() 

	return(size)
}

end
