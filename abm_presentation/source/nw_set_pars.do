include nw_locals.do

mata:

transmorphic sir_nw::N(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		N = val
	}
	else {
		return(N)
	}
}

transmorphic sir_nw::tdim(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		tdim= val
	}
	else {
		return(tdim)
	}
}


transmorphic sir_nw::outbreak(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		outbreak= val
	}
	else {
		return(outbreak)
	}
}

transmorphic sir_nw::removed(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		removed= val
	}
	else {
		return(removed)
	}
}

transmorphic sir_nw::transmissibility(| real scalar val)
{
	if ( args()==1 ) {
		is_pr(val)
		transmissibility = val
	}
	else {
		return(transmissibility)
	}
}

transmorphic sir_nw::mindur(| real scalar val)
{
	if ( args()==1 ) {
		is_posint(val)
		mindur = val
	}
	else {
		return(mindur)
	}
}

transmorphic sir_nw::meandur(| real scalar val)
{
	if ( args()==1 ) {
		if (val < 0) _error("argument must be positive")
		meandur = val
	}
	else {
		return(meandur)
	}
}

transmorphic sir_nw::pr_loss(| real scalar val)
{
	if ( args()==1 ) {
		is_pr(val)
		pr_loss = val
	}
	else {
		return(pr_loss)
	}
}

transmorphic sir_nw::degree(| real scalar val)            // <-- new
{
	if ( args()==1 ) {
		is_posint(val)
		degree = val
	}
	else {
		return(degree)
	}
}

transmorphic sir_nw::pr_long(| real scalar val)        // <-- new
{
	if ( args()==1 ) {
		is_pr(val)
		pr_long = val
	}
	else {
		return(pr_long)
	}
}


end
