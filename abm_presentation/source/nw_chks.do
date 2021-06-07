include nw_locals.do

mata:
void sir_nw::isid(real scalar id)
{
    is_int_inrange(id,1,N)
}

void sir_nw::istime(real scalar t)
{
    is_int_inrange(t,0,tdim)
}
end
