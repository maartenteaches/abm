include grid_locals.do

mata:

transmorphic sir_grid::prop_close(| real scalar val)
{
	if (args() == 1) {
		is_pr(val)
		prop_close = val
	}
	else {
		return(prop_close)
	}
}

transmorphic sir_grid::prop_medium(| real scalar val)
{
	if (args() == 1) {
		is_pr(val)
		prop_medium = val
	}
	else {
		return(prop_medium)
	}
}

transmorphic sir_grid::prop_far(| real scalar val)
{
	if (args() == 1) {
		is_pr(val)
		prop_far = val
	}
	else {
		return(prop_far)
	}
}

transmorphic sir_grid::rdim(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		rdim = val
	}
	else {
		return(rdim)
	}
}

transmorphic sir_grid::cdim(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		cdim = val
	}
	else {
		return(cdim)
	}
}

transmorphic sir_grid::N(| real matrix val)
{
	if (args() == 1) {
		is_posint(val)
		N = val
	}
	else {
		return(N)
	}
}


transmorphic sir_grid::tdim(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		tdim= val
	}
	else {
		return(tdim)
	}
}


transmorphic sir_grid::outbreak(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		outbreak= val
	}
	else {
		return(outbreak)
	}
}

transmorphic sir_grid::removed(| real matrix val)
{
	if (args() == 1) {
		is_posint(val)
		removed= val
	}
	else {
		return(removed)
	}
}

transmorphic sir_grid::mcontacts(| real matrix val)
{
	if ( args()==1 ) {
		if ( val < 0) _error("arguments must be positive")
		mcontacts = val
	}
	else {
		return(mcontacts)
	}
}

transmorphic sir_grid::transmissibility(| real scalar val)
{
	if ( args()==1 ) {
		is_pr(val)
		transmissibility = val
	}
	else {
		return(transmissibility)
	}
}

transmorphic sir_grid::mindur(| real scalar val)
{
	if ( args()==1 ) {
		is_posint(val)
		mindur = val
	}
	else {
		return(mindur)
	}
}

transmorphic sir_grid::meandur(| real scalar val)
{
	if ( args()==1 ) {
		if (val < 0) _error("argument must be positive")
		meandur = val
	}
	else {
		return(meandur)
	}
}

transmorphic sir_grid::pr_loss(| real scalar val)
{
	if ( args()==1 ) {
		is_pr(val)
		pr_loss = val
	}
	else {
		return(pr_loss)
	}
}


end
