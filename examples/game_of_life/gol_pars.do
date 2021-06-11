mata:
transmorphic gol::rdim(| real scalar val)
{
    if (args()==1) {
        is_posint(val)
        rdim = val
    }
    else{
        return(rdim)
    }
}

transmorphic gol::cdim(| real scalar val)
{
    if (args()==1) {
        is_posint(val)
        cdim = val
    }
    else {
        return(cdim)
    }
}
transmorphic gol::tdim(| real scalar val)
{
    if (args()==1) {
        is_posint(val)
        tdim = val
    }
    else {
        return(tdim)
    }
}

transmorphic gol::init_state(| real matrix val)
{
    if (args()==1) {
        is_bool(val)
        init_state = val
    }
    else {
        return(init_state)
    }
}

end
