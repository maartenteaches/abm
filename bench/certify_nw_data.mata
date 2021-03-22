mata:
class nw_data_chk extends nw_data
{
    real scalar setup_value()
    real scalar prepared_value()
    real scalar nw_notfound()
    void        chk_prepare()
}

real scalar nw_data_chk::setup_value()
{
    return(setup)
}

real scalar nw_data_chk::prepared_value()
{
    return(prepared)
}

real scalar nw_data_chk::nw_notfound()
{
    return(network.notfound())
}

void chk_prepare()
{
    prepare()
}

foo = nw_data_chk()
// check new()
assert(foo.nw_set()==0)
assert(foo.setup_value()==0)
assert(foo.prepared_value()==0)
assert(foo.nw_notfound()==0)

foo.chk_prepare()

foo.abm_version("0.2.0")
foo.N_nodes(1,10)
assert(foo.N_nodes(1)==10)
foo.tdim(1)
assert(foo.tdim()==1)
end