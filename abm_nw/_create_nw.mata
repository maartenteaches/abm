mata:

void abm_nw::from_adjlist(real matrix adj)
{
	real scalar i,j, orig
	network.prepare()
	if (network.nw_set()==1) {
		_error(3000,"initial network already set")
	}
	if (network.directed()==.) _error("directed needs to be set")
	if (cols(adj) < 1) _error("number of cols needs to be 1 or higher")
	for (i=1 ; i<=rows(adj) ; i++) {
		orig = adj[i,1]
		is_valid_id(orig)
		for (j=2 ; j<= cols(adj) ; j++) {
			if (adj[i,j] != .) {
				is_valid_id(adj[i,j])
				network.add_edge(1,orig,adj[i,j])
			}
		}
	}
	network.nw_set(1)
}


void abm_nw::from_edgelist(real matrix edges)
{
	real scalar    i
	network.prepare()
	if (network.nw_set()==1) {
		_error(3000,"initial network already set")
	}
	if(cols(edges) < 2) {
		_error(3200, "edges must have at least 2 columns")
	}
	if(cols(edges) > 3) {
	    _error(3200, "edges cannot have more than 3 columns")
	}
	
	if (cols(edges)==3 & network.weighted() == 0) _error("can't add weights to unweighted network'")
	if (network.directed()==.) _error("directed needs to be set")
	if (cols(edges)==2) {
	    edges = edges , J(rows(edges),1,1)
	}
	for (i=1; i <= rows(edges); i++) {
		is_valid_id(edges[i,1])
		is_valid_id(edges[i,2])
		network.add_edge(1,edges[i,1], edges[i,2], edges[i,3])
	}
	network.nw_set(1)
}

void abm_nw::from_adjmatrix(real matrix adjmat)
{
	real scalar i, j, max
	network.prepare()

	if (network.nw_set()==1) {
		_error(3000, "initial network already set")
	}
	if (rows(adjmat) != network.N_nodes(1) | cols(adjmat) != network.N_nodes(1)) {
		_error(3000, "matrix must have N_nodes rows and columns")
	}
	if (network.directed()==0 & issymmetric(adjmat) == 0) {
		_error(3000, "matrix must be symmetric for non-directed network")
	}
	if (network.weighted() == 0 & !all((adjmat:==0):|(adjmat:==1))) {
	    _error("can't add weights to an unweighted matrix'")
	}
	for(i=1; i<= network.N_nodes(1); i++) {
		max = (network.directed() == 0 ? i: network.N_nodes(1))
		for(j=1; j<=max; j++) {
			if (adjmat[i,j]!=0 & i!=j) {
				network.add_edge(1,i,j,adjmat[i,j])
			}
		}
	}
	network.nw_set(1)
}

void abm_nw::random(real scalar pr) {                                         
	
	real scalar i, j, max

	network.prepare()
	if (network.nw_set()==1) {
		_error(3000,"initial network already set")
	}

	if (network.weighted() == .) network.weighted(0)
	if (network.weighted() == 1) _error("random makes unweighted an network")
	is_pr(pr)
	for(i=1; i<=network.N_nodes(1);i++) {
		max = ( network.directed() == 0 ? i : network.N_nodes(1) )
		for(j=1; j<=max; j++) {
			if (i!=j & runiform(1,1)<=pr) {
				network.add_edge(1,i,j)
			}
		}
	}
	network.nw_set(1)
}

void abm_nw::sw(real scalar degree, real scalar pr)
{
	real scalar left, right, i, j, alt_dest
	real vector basedest, dest

	network.prepare()
	if (network.nw_set()==1) {
		_error(3000,"initial network already set")
	}

	if (network.weighted() == .) network.weighted(0)
	if (network.weighted() == 1) _error("sw makes unweighted an network")
	is_posint(degree)
	if (network.directed()==0 & mod(degree,2)!= 0) {
		_error(3000, "in an unidirected network the degree has to be even")
	} 	
	if (degree>network.N_nodes(1)) {
		_error(3000, "degree has be less than the number of nodes")
	}
	is_pr(pr)
	
	left = -floor(degree/2)
	right = ceil(degree/2)
	
	if (network.directed() == 0) {
		basedest = 1..right
		for(i=1; i <= network.N_nodes(1) ; i++) {
			dest = basedest :+ i
			dest = mod(dest:-1, network.N_nodes(1)):+ 1
			for(j=1; j <= right; j++) {
				if (runiform(1,1)>pr) {
					add_edge(1,i,dest[j],1,"replace")
				}
				else {
					alt_dest = ceil(runiform(1,1)*(network.N_nodes(1)-1))
					alt_dest = alt_dest + (alt_dest>=i)
					add_edge(1,i,alt_dest,1,"replace")
				}
			}
		}
	}
	else {
		if (left != 0) {
			basedest = (left..-1)
		}
		else {
			basedest = J(1,0,.)
		}
		basedest = basedest , (1..right)
		for(i=1; i<= network.N_nodes(1); i++){
			dest = basedest :+ i
			dest = mod(dest :-1, network.N_nodes(1)) :+ 1
			for(j=1; j<=degree;j++){
				if (runiform(1,1)>pr) {
					add_edge(1,i,dest[j],1,"replace")
				}
				else {
					alt_dest = ceil(runiform(1,1)*(network.N_nodes(1)-1))
					alt_dest = alt_dest + (alt_dest>=i)
					add_edge(1,i,alt_dest,1,"replace")
				}
			}
		}
	}
	network.nw_set(1)
}

end
