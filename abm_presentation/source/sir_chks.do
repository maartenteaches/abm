include sir_locals.do

mata:

void sir::isid(real scalar id)
{
	is_int_inrange(id,1,N)
}

void sir::istime(real scalar t)
{
    is_int_inrange(t,0,tdim)
}
end
