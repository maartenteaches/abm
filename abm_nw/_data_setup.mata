mata:
void nw_data::new(){
	bc_setup()
	nw_set    = 0
	setup     = 0
	network.reinit("real",3)
	network.notfound(0)
}

void nw_data::setup()
{
	real scalar i,j
	if (tdim==.) {
	    tdim = mod_gt((0,1,0))
	}
	if (directed == .) {
	    directed = 1
	}
	if (directed == 0 ) {
		is_symmetric(1)
	}
	if (randomit == .) {
	    randomit = 0
	}
	if (weighted == .) weighted = 1
	if (N_nodes[1] == .) N_nodes[1] = 0

	N_nodes = N_nodes\J(tdim-1,1,.)
	nodes = J(tdim,1,NULL)
	if (N_nodes[1] == 0) {
		nodes[1] = &(J(1,0,.))
	}
	else {
		nodes[1] = &(1..N_nodes[1])
	}
	maxnodes = N_nodes[1]
	dropped_nodes = J(tdim,1,NULL)
	for(i=1; i<=tdim; i++) {
		dropped_nodes[i] = &(J(1,0,.))
	}
	
	adjlist = J(maxnodes, tdim, NULL)
	for(i=1; i<= maxnodes; i++) {
		for(j=1; j<=tdim; j++) {
			adjlist[i,j] = &(J(1,0,.))
		}
	}
	
	N_edges = J(tdim,1,0)
			
	frozen = J(tdim,1,0)
	frozen[1] = 1
	setup = 1
}

void nw_data::clear()
{
	if (setup==0) return

	real scalar i,j
	maxnodes = N_nodes[1]
    
	adjlist = J(maxnodes, tdim, NULL)
	nodes = nodes[1] \ J(tdim-1,1,NULL)
	N_nodes = N_nodes[1] \ J(tdim-1,1,.)
	N_edges = J(tdim,1,0)
	dropped_nodes = J(tdim,1,NULL)
	frozen = J(tdim,1,0)
	for(i=1;i<=tdim; i++) {
		dropped_nodes[i] = &(J(1,0,.))
	}
	
	adjlist = J(maxnodes, tdim, NULL)
	for(i=1; i<= maxnodes; i++) {
		for(j=1; j<=tdim; j++) {
			adjlist[i,j] = &(J(1,0,.))
		}
	}

	if (weighted==1) network.clear()
	nw_set    = 0
	setup     = 0
}

end
