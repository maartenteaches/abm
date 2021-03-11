mata:
void nw_data::new(){
	bc_setup()
    nodes_set = 0
	nw_set    = 0
	setup     = 0
	N_edges0   = 0
	network.reinit("real",3)
	network.notfound(0)
}

void abm_nw::setup()
{
	if (tdim==.) {
	    tdim = mod_gt((0,1,0))
	}
	if (directed == .) {
	    directed = 1
	}
	if (directed == 0 ) {
		is_symmetric()
	}
	if (randomit == .) {
	    randomit = 0
	}
	if (weighted == .) weighted = 1
	if (mod_gt((0,1,0))){
		if (N_nodes[1] == .) N_nodes[1] = 0
        frozen[1] = 1
	}
	else {
		if (N_nodes0 == .) N_nodes0 = 0
	}
	
	setup = 1
}

void abm_nw::clear()
{
	if (setup==0) return
	
	real scalar i,j
	if (mod_leq((0,1,0))) {
		adjlist0 = J(N_nodes0,1,NULL)
		for(i=1; i<=N_nodes0; i++) {
			adjlist0[i] = &(J(1,0,.))
		}
		nodes0 = 1..N_nodes0
		maxnodes = N_nodes0

		dropped_nodes0 = J(1,0,.)
	}
    else {
        maxnodes = N_nodes[1]
    }
	
	if (tdim > 0 ) {
		adjlist = J(maxnodes, tdim, NULL)
		nodes = J(tdim,1,NULL)
        if (mod_gt((0,1,0))) nodes[1] = &(1..N_nodes[1])
		N_nodes = N_nodes[1] \ J(tdim-1,1,.)
		N_edges = J(tdim,1,0)
		dropped_nodes = J(tdim,1,NULL)
		frozen = J(tdim,1,0)
		for(i=1;i<=tdim; i++) {
			dropped_nodes[i] = &(J(1,0,.))
		}
		
		for(i=1; i<= maxnodes; i++) {
			for(j=1; j<=tdim; j++) {
				adjlist[i,j] = &(J(1,0,.))
			}
		}
	}
	if (weighted==1) network.clear()
	nw_set    = 0
	setup     = 0

}

end
