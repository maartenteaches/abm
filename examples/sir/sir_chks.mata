include examples/sir/sir_locals.mata

mata:

void sir::is_id(real scalar id)
{
	is_int_inrange(id,1,N)
}

void sir::is_time(real scalar t)
{
	is_int_inrange(t,0,tdim)
}
end
