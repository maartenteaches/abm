mata:

void abm_grid::basecoords()
{	
	real scalar k, r, c
	
	basecoords =J(rdim*cdim,2,.)

	k=1
	for(r=1; r<=rdim; r++) {
		for(c=1 ; c<=cdim; c++) {
			basecoords[k,.] = r, c
			k = k + 1
		}
	}
}

real rowvector abm_grid::random_cell(real scalar k) {
	is_setup() 
	
	return(ceil(runiform(k,2):*(rdim,cdim)))
}

real matrix abm_grid::schedule()
{
	is_setup() 
	
	if (randit) {
		_jumble(basecoords)
	}
	return(basecoords)
}

end
