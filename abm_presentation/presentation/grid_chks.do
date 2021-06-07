include grid_locals.do

mata:

void sir_grid::is_valid_address(real rowvector address)
{
	if (cols(address) != 2) _error("an address ")
    is_int_inrange(address[1],1,rdim)
    is_int_inrange(address[2],1,cdim)
}

void sir::isid(real scalar id, real scalar from)
{
	is_int_inrange(id,from,N)
}

void sir::istime(real scalar t)
{
    is_int_inrange(t,0,tdim)
}
end
