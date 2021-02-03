mata:
void abm_nw::add_edge(real scalar t, real scalar orig, real scalar dest,| real scalar weight, string scalar replace, string scalar fast)
{
	real rowvector key
	real scalar change
	
	if (weight==0) return
	
	if (args()!=6) {
		is_valid_id(orig,t)  // also checks if t is valid
		is_valid_id(dest,t)
		is_frozen(t)
		if (weighted == 0 & (weight != . & weight != 0 & weight != 1)){
			_error("can't set weights for unweighted network'")
		} 
		if (args() <= 4) no_edge(t,orig, dest)
		if (args() == 3) weight = 1
	}
	change = edge_exists(orig,dest,t, "fast")
	if (weighted) {
		key = t, orig, dest
		network.put(key, weight)
	}
	if (change==0) {
		if (t == 0) {
			adjlist0[orig] = &(*adjlist0[orig], dest)
			N_edges0 = N_edges0 + 1
		}
		else {
			adjlist[orig,t] = &(*adjlist[orig,t], dest)
			N_edges[t] = N_edges[t] + 1
			
		}
	}	
	if (directed == 0) {
		change = edge_exists(dest,orig,t, "fast")
		if (weighted) {
			key = t, dest, orig
			network.put(key, weight)
		}
		if (change==0) {
			if (t == 0) {
				adjlist0[dest] = &(*adjlist0[dest], orig)
				N_edges0 = N_edges0 + 1
			}
			else {
				adjlist[dest,t] = &(*adjlist[dest,t], orig)
				N_edges[t] = N_edges[t] + 1
			}		
		}
	}
}

void abm_nw::remove_edge(real scalar t, real scalar orig, real scalar dest)
{
    real rowvector key, adj, adj2
	
    is_valid_id(orig,t)
	is_valid_id(dest,t)
	is_frozen(t)
    if (!edge_exists(orig,dest,t, "fast")) {
	    _error(3000, "no edge to remove")
	}
	
	if (weighted) {
		key = t, orig, dest
		network.remove(key)
	}
	if (t==0) {
	    adj = *adjlist0[orig]
		adj = select(adj, adj:!=dest)
		adjlist0[orig] = &adj
		N_edges0 = N_edges0 - 1
	}
	else {
	    adj = *adjlist[orig, t]
		adj = select(adj, adj:!=dest)
		adjlist[orig,t] = &adj
		N_edges[t] = N_edges[t] - 1
	}
	if (directed == 0) {
		if (weighted) {
			key = t, dest, orig
			network.remove(key)
		}
		if (t==0) {
			adj2 = *adjlist0[dest]
			adj2 = select(adj2, adj2:!=orig)
			adjlist0[dest] = &adj2
			N_edges0 = N_edges0 - 1
		}
		else {
			adj2 = *adjlist[dest, t]
			adj2 = select(adj2, adj2:!=orig)
			adjlist[dest,t] = &adj2
			N_edges[t] = N_edges[t] - 1
		}	    
	}
}

void abm_nw::change_weight(real scalar t, real scalar orig, real scalar dest, real scalar val)
{
	is_valid_id(orig,t)
	is_valid_id(dest,t)
	is_frozen(t)
	if (weighted==0) _error("no weight to change")
	
    if (!edge_exists(orig,dest,t, "fast")) {
	    _error(3000, "no edge to change")
	}
	add_edge(t, orig, dest, val, "replace", "fast")
}

void abm_nw::rewire(real scalar t, real scalar orig0, real scalar dest0,
    real scalar orig1, real scalar dest1)
{
    real scalar val
	
    is_valid_id(orig0,t)
	is_valid_id(orig1,t)
	is_valid_id(dest0,t)
	is_valid_id(dest1,t)
	is_frozen(t)
	if(!edge_exists(orig0,dest0,t, "fast")) {
	    _error("no edge to rewire")
	}
	
	val = weight(orig0,dest0,t)
	remove_edge(t,orig0, dest0)
	add_edge(t, orig1, dest1, val, "replace")
}

void abm_nw::remove_node(real scalar t, real scalar id)
{
	real scalar i, j
	real vector cols
	
	is_valid_id(id,t)
	is_frozen(t)
	if (t==0) {
		dropped_nodes0 = dropped_nodes0, id
		N_nodes0 = N_nodes0 - 1
		nodes0 = select(nodes0, nodes0:!=id)
		if (weighted){
			for(i=1; i<=maxnodes; i++) {
				cols = *adjlist0[i]
				for(j=1; j<= length(cols); j++) {
					if (i==id | cols[j] == id) {
						network.remove((t,i,cols[j]))
					}
				}
			}
		}
		adjlist0[id] = &(J(1,0,.))
		for(i=1;i<=maxnodes;i++) {
			adjlist0[i] = &(select(*adjlist0[i],*adjlist0[i]:!=id))
			if (*adjlist0[i] == J(0,0,.)) adjlist0 = &(J(1,0,.))
		}
	}
	else {
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
		for(i=1;i<=maxnodes;i++) {
			adjlist[i,t] = &(select(*adjlist[i,t],*adjlist[i,t]:!=id))
			if (*adjlist[i,t] == J(0,0,.)) adjlist[i,t] = &(J(1,0,.))
		}
	}
}

void abm_nw::return_node(real scalar t, real scalar id) 
{
    is_valid_time(t)
	is_frozen(t)
    if (t==0) {
	    if (!anyof(dropped_nodes0,id)) {
		    _error("a node can only be returned if it was previously dropped")
		}
	}
	else {
	    if (!anyof(*dropped_nodes[t], id)){
		    _error("a node can only be returned if it was previously dropped")
		}
	}
	if (t==0) {
	    dropped_nodes0 = select(dropped_nodes0, dropped_nodes0:!=id)
		if ( dropped_nodes0 == J(0,0,.) ) dropped_nodes0 = J(1,0,.)
		nodes0 = nodes0 , id
		N_nodes0 = N_nodes0 + 1
	}
	else {
	    dropped_nodes[t] = &(select(*dropped_nodes[t], *dropped_nodes[t] :!= id))
		if (*dropped_nodes[t] == J(0,0,.)) dropped_nodes[t] = &J(1,0,.)
		nodes[t] = &(*nodes[t], id)
		N_nodes[t] = N_nodes[t] + 1
	}
	
}

void abm_nw::add_node(real scalar t)
{
    real scalar i
	pointer (real vector) vector toadd
	
    is_valid_time(t)
	is_frozen(t)
	maxnodes = maxnodes +1
	
	if (t== 0) {
	    nodes0 = nodes0 , maxnodes
		N_nodes0 = N_nodes0 + 1
	}
	else {
	    nodes[t] = &(*nodes[t], maxnodes)
		dropped_nodes0 = dropped_nodes0, maxnodes
		for(i=1; i<t; i++) {
		    dropped_nodes[i] = &(*dropped_nodes[i], maxnodes)
		}
		N_nodes[t] = N_nodes[t] + 1
	}
	adjlist0 = adjlist0 \ &J(1,0,.)
	if (tdim>0) {
	    toadd = J(1,tdim,NULL)
		for(i=1; i<=tdim; i++) {
		    toadd[i] = &J(1,0,.)
		}
		adjlist = adjlist \ toadd
	}
}

void abm_nw::copy_nodes(real scalar t0, real scalar t1)
{
	real vector orig, dropped
	real scalar n
	
	is_valid_time(t0)
	is_valid_time(t1)
	if (nodes[t1] != NULL) _error("nodes for t1 already set")
	if (t0==0) {
		orig    = nodes0
		n       = N_nodes0
		dropped = dropped_nodes0
	}
	else {
		orig    = *nodes[t0]
		n       = N_nodes[t0]
		dropped = *dropped_nodes[t0]
	}
	nodes[t1]         = &orig
	N_nodes[t1]       = n
	dropped_nodes[t1] = &dropped
}

void abm_nw::copy_adjlist(real scalar t0, real scalar t1)
{
	real scalar i
	
	is_valid_time(t0)
	is_valid_time(t1)

	if(t0==0){
		for(i=1;i<=rows(adjlist0);i++) {
			adjlist[i,t1] = &(*adjlist0[i])
		}
	}
	else {
		for(i=1;i<=rows(adjlist);i++) {
			adjlist[i,t1] = &(*adjlist[i, t0])
		}		
	}
}
void abm_nw::copy_nw(real scalar t0, real scalar t1)
{
	real scalar i, j, val
	real vector cols, key0, key1
	
	is_valid_time(t0)
	is_valid_time(t1)
	is_frozen(t1)
	is_setup()

	copy_nodes(t0, t1)
	copy_adjlist(t0, t1)
	if (t0==0) {
		val = N_edges0
	}
	else{
		val = N_edges[t0]
		frozen[t0] = 1
	}
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
