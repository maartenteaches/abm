include grid_locals.do

mata:

transmorphic sir::N(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		N = val
	}
	else {
		return(N)
	}
}

transmorphic sir::tdim(| real scalar val)
{
	if (args() == 1) {
		is_posint(val)
		tdim= val
	}
	else {
		return(tdim)
	}
}


transmorphic sir::outbreak(| real scalar val)
{
	if (args() == 1) {
		is_posint(val, "zero_ok")
		outbreak= val
	}
	else {
		return(outbreak)
	}
}

transmorphic sir::removed(| real scalar val)
{
	if (args() == 1) {
		is_posint(val, "zero_ok")
		removed= val
	}
	else {
		return(removed)
	}
}

transmorphic sir::mcontacts(| real scalar val)
{
	if ( args()==1 ) {
		if ( val < 0) _error("arguments must be positive")
		mcontacts = val
	}
	else {
		return(mcontacts)
	}
}

transmorphic sir::transmissibility(| real scalar val)
{
	if ( args()==1 ) {
		is_pr(val)
		transmissibility = val
	}
	else {
		return(transmissibility)
	}
}

transmorphic sir::mindur(| real scalar val)
{
	if ( args()==1 ) {
		is_posint(val)
		mindur = val
	}
	else {
		return(mindur)
	}
}

transmorphic sir::meandur(| real scalar val)
{
	if ( args()==1 ) {
		if (val < 0) _error("argument must be positive")
		meandur = val
	}
	else {
		return(meandur)
	}
}

transmorphic sir::pr_loss(| real scalar val)
{
	if ( args()==1 ) {
		is_pr(val)
		pr_loss = val
	}
	else {
		return(pr_loss)
	}
}

transmorphic sir::vil_id(| real scalar val)
{
    if (args()==1) {
        is_posint(val)
        vil_id = val
    }
    else {
        return(vil_id)
    }
}

end
