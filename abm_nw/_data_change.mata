mata:
void nw_data::add_edge(real scalar t, real scalar orig, real scalar dest, real scalar weight, string scalar replace)
{
	real rowvector key
	real scalar change
	prepare()

	if (replace == "") no_edge(t,orig, dest)
	if (weight==0) {
		if (edge_exists(orig,dest,t)) {
			remove_edge(t,orig,dest)
			return
		}
		else {
			return
		}
	} 
	is_frozen(t)
	if (weighted == 0 & (weight != . & weight != 0 & weight != 1)){
		_error("can't set weights for unweighted network'")
	} 
	if (weight == .) weight = 1
	change = edge_exists(orig,dest,t)
	if (weighted) {
		key = t, orig, dest
		network.put(key, weight)
	}
	if (change==0) {
		adjlist[orig,t] = &(*adjlist[orig,t], dest)
		N_edges[t] = N_edges[t] + 1
	}	
	if (directed == 0) {
		if (weighted) {
			key = t, dest, orig
			network.put(key, weight)
		}
		if (change==0) {
			adjlist[dest,t] = &(*adjlist[dest,t], orig)
			N_edges[t] = N_edges[t] + 1
		}
	}
}

void nw_data::remove_edge(real scalar t, real scalar orig, real scalar dest)
{
    real rowvector key, adj, adj2

 	is_frozen(t)
    if (!edge_exists(orig,dest,t)) {
	    _error(3000, "no edge to remove")
	}
	
	if (weighted) {
		key = t, orig, dest
		network.remove(key)
	}
    adj = *adjlist[orig, t]
	adj = select(adj, adj:!=dest)
	if (cols(adj)==0) adj = J(1,0,.)
	adjlist[orig,t] = &adj
	N_edges[t] = N_edges[t] - 1

	if (directed == 0) {
		if (weighted) {
			key = t, dest, orig
			network.remove(key)
		}
		adj2 = *adjlist[dest, t]
		adj2 = select(adj2, adj2:!=orig)
		if (cols(adj2)==0) adj2 = J(1,0,.)
		adjlist[dest,t] = &adj2
		N_edges[t] = N_edges[t] - 1
	}
}

void nw_data::change_weight(real scalar t, real scalar orig, real scalar dest, real scalar val)
{
	is_frozen(t)
	if (weighted==0) _error("no weight to change")
	
    if (!edge_exists(orig,dest,t)) {
	    _error(3000, "no edge to change")
	}
	add_edge(t, orig, dest, val, "replace")
}

void nw_data::rewire(real scalar t, real scalar orig0, real scalar dest0,
    real scalar orig1, real scalar dest1)
{
    real scalar val
	
	is_frozen(t)
	if(!edge_exists(orig0,dest0,t)) {
	    _error("no edge to rewire")
	}
	
	val = weight(orig0,dest0,t)
	remove_edge(t,orig0, dest0)
	add_edge(t, orig1, dest1, val, "replace")
}

void nw_data::remove_node(real scalar t, real scalar id)
{
	real scalar i, j, count
	real vector cols
	
	is_frozen(t)

	dropped_nodes[t] = &(*dropped_nodes[t] , id)
	N_nodes[t] = N_nodes[t] - 1
	nodes[t] = &(select(*nodes[t],*nodes[t]:!=id))
	if (weighted) {
		for(i=1; i<=maxnodes; i++) {
			cols = *adjlist[i,t]
			for(j=1; j<= length(cols); j++) {
				if (i==id | cols[j] == id) {
					network.remove((t,i,cols[j]))
				}
			}
		}
	}
	adjlist[id,t] = &J(1,0,.)
	count = 0
	for(i=1;i<=maxnodes;i++) {
		adjlist[i,t] = &(select(*adjlist[i,t],*adjlist[i,t]:!=id))
		if (*adjlist[i,t] == J(0,0,.)) adjlist[i,t] = &(J(1,0,.))
		count = count + cols(*adjlist[i,t])
	}
	N_edges = count
}

void nw_data::return_node(real scalar t, real scalar id) 
{
	is_frozen(t)
    if (!anyof(*dropped_nodes[t], id)){
	    _error("a node can only be returned if it was previously dropped")
	}
    dropped_nodes[t] = &(select(*dropped_nodes[t], *dropped_nodes[t] :!= id))
	if (*dropped_nodes[t] == J(0,0,.)) dropped_nodes[t] = &J(1,0,.)
	nodes[t] = &(*nodes[t], id)
	N_nodes[t] = N_nodes[t] + 1
}

void nw_data::add_node(real scalar t)
{
    real scalar i
	pointer (real vector) vector toadd
	
	is_frozen(t)
	maxnodes = maxnodes +1
	
    nodes[t] = &(*nodes[t], maxnodes)
	for(i=1; i<t; i++) {
	    dropped_nodes[i] = &(*dropped_nodes[i], maxnodes)
	}
	N_nodes[t] = N_nodes[t] + 1
    toadd = J(1,tdim,NULL)
	for(i=1; i<=tdim; i++) {
	    toadd[i] = &J(1,0,.)
	}
	adjlist = adjlist \ toadd
}

void nw_data::copy_nodes(real scalar t0, real scalar t1)
{
	real vector orig, dropped
	real scalar n
	
	if (nodes[t1] != NULL) _error("nodes for t1 already set")
	orig    = *nodes[t0]
	n       = N_nodes[t0]
	dropped = *dropped_nodes[t0]
	nodes[t1]         = &orig
	N_nodes[t1]       = n
	dropped_nodes[t1] = &dropped
}

void nw_data::copy_adjlist(real scalar t0, real scalar t1)
{
	real scalar i

	for(i=1;i<=rows(adjlist);i++) {
		adjlist[i,t1] = &(*adjlist[i, t0])
	}		
}
void nw_data::copy_nw(real scalar t0, real scalar t1)
{
	real scalar i, j, val
	real vector cols, key0, key1

	is_frozen(t1)
	is_setup()

	copy_nodes(t0, t1)
	copy_adjlist(t0, t1)
	val = N_edges[t0]
	frozen[t0] = 1
	N_edges[t1] = val
	if (weighted) {
		for(i=1; i<=maxnodes; i++) {
			cols = *adjlist[i,t1]
			for(j=1; j <= length(cols); j++) {
				key0 = t0, i, cols[j]
				key1 = t1, i, cols[j]
				network.put(key1, network.get(key0))
			}
		}
	}
}

end
