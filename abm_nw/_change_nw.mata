mata:
void abm_nw::add_edge(real scalar t, real scalar orig, real scalar dest,| real scalar weight, string scalar replace)
{
	t = parse_t(t)
	is_valid_id(orig,t)  // also checks if t is valid
	is_valid_id(dest,t)

	network.add_edge(t, orig, dest, weight, replace)
}

void abm_nw::remove_edge(real scalar t, real scalar orig, real scalar dest)
{
	t = parse_t(t)
    is_valid_id(orig,t)
	is_valid_id(dest,t)

	network.remove_edge(t, orig, dest)
}

void abm_nw::change_weight(real scalar t, real scalar orig, real scalar dest, real scalar val)
{
	t = parse_t(t)
	is_valid_id(orig,t)
	is_valid_id(dest,t)

	network.change_weight(t,orig,dest, val)
}

void abm_nw::rewire(real scalar t, real scalar orig0, real scalar dest0,
    real scalar orig1, real scalar dest1)
{
	t = parse_t(t)
    is_valid_id(orig0,t)
	is_valid_id(orig1,t)
	is_valid_id(dest0,t)
	is_valid_id(dest1,t)

	network.rewire(t, orig0, dest0, orig1, dest1)
}

void abm_nw::remove_node(real scalar t, real scalar id)
{
	t = parse_t(t)	
	is_valid_id(id,t)
	network.remove_node(t,id)
}

void abm_nw::return_node(real scalar t, real scalar id) 
{
	t = parse_t(t)
    is_valid_time(t)
	
	network.return_node(t,id)
}

void abm_nw::add_node(real scalar t)
{
	t = parse_t(t)
    is_valid_time(t)
	
	network.add_node(t)
}

void abm_nw::copy_nodes(real scalar t0, real scalar t1)
{
	t0 = parse_t(t0)
	t1 = parse_t(t1)
	is_valid_time(t0)
	is_valid_time(t1)

	network.copy_nodes(t0, t1)
}

void abm_nw::copy_adjlist(real scalar t0, real scalar t1)
{
	t0 = parse_t(t0)
	t1 = parse_t(t1)
	is_valid_time(t0)
	is_valid_time(t1)

	network.copy_adjlist(t0,t1)
}

void abm_nw::copy_nw(real scalar t0, real scalar t1)
{
	t0 = parse_t(t0)
	t1 = parse_t(t1)
	is_valid_time(t0)
	is_valid_time(t1)

	network.copy_nw(t0,t1)
}

end
