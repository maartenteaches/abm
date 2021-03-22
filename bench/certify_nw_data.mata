mata:
class nw_data_chk extends nw_data
{
    real scalar setup_value()
    real scalar prepared_value()
    real scalar nw_notfound()
    void        chk_prepare()
    real vector chk_N_nodes()
    real vector chk_dropped_nodes()
    real vector chk_frozen()
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

void nw_data_chk::chk_prepare()
{
    prepare()
}

real vector nw_data_chk::chk_N_nodes()
{
    return(N_nodes)
}

real vector nw_data_chk::chk_dropped_nodes(real scalar t)
{
    return(*dropped_nodes[t])
}

real vector nw_data_chk::chk_frozen()
{
    return(frozen)
}

foo = nw_data_chk()
// check new()
assert(foo.nw_set()==0)
assert(foo.setup_value()==0)
assert(foo.prepared_value()==0)
assert(foo.nw_notfound()==0)

foo.abm_version("0.2.0")
foo.N_nodes(1,10)
assert(foo.N_nodes(1)==10)
foo.tdim(2)
assert(foo.tdim()==2)
foo.randomit(0)
assert(foo.randomit()==0)

foo.chk_prepare()
assert(foo.prepared_value()==1)
assert(foo.chk_N_nodes() == (10 \ .))
assert(foo.schedule(1) == (1..10))
assert(foo.schedule(2) == J(1,0,.))
assert(foo.maxnodes() == 10)
assert(foo.chk_dropped_nodes(1) == J(1,0,.))
assert(foo.chk_dropped_nodes(2) == J(1,0,.))
for(i=1; i<=10; i++) {
    for(j=1; j<=2; j++) {
        assert(foo.neighbours(i,j)==J(1,0,.))
    }
}
assert(foo.N_edges(1)==0)
assert(foo.N_edges(2)==0)
assert(foo.chk_frozen()==J(2,1,0))
end