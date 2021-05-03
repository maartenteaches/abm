include examples/sir_nw/nw_locals.mata

mata:
void sir_nw::is_id(real scalar id)
{
	is_int_inrange(id,1,N)
}

void sir_nw::is_time(real scalar t)
{
	is_int_inrange(t,0,tdim)
}
end
