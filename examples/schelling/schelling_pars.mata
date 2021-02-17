
mata:
transmorphic schelling::rdim(| real scalar dim) 
{
	if (args() == 1) {
		is_posint(dim)
		universe.rdim(dim)
		rdim = dim
	}
	else {
		return(universe.rdim())
	}
}
transmorphic schelling::cdim(| real scalar dim) 
{
	if (args() == 1) {
		is_posint(dim)
		universe.cdim(dim)
		cdim = dim
	}
	else {
		return(universe.cdim())
	}
}
transmorphic schelling::tdim(| real scalar dim) 
{
	if (args() == 1) {
		is_posint(dim)
		universe.tdim(dim)
		tdim = dim
	}
	else {
		return(universe.tdim())
	}
}

transmorphic schelling::limit(| real scalar val) 
{
	if (args() == 1) {
		is_pr(val)
		limit = val
	}
	else {
		return(limit)
	}
}
transmorphic schelling::nblue(| real scalar val) 
{
	if (args() == 1) {
		is_posint(val)
		nblue = val
	}
	else {
		return(nblue)
	}
}
transmorphic schelling::nred(| real scalar val) 
{
	if (args() == 1) {
		is_posint(val)
		nred = val
	}
	else {
		return(nred)
	}
}
end
