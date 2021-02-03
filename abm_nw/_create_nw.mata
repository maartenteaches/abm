mata:

void abm_nw::from_adjlist(real matrix adj)
{
	real scalar i,j, orig
	
	if (nw_set==1) {
		_error(3000,"initial network already set")
	}
	if (dropped_nodes0!=J(1,0,.)) _error("nodes have been dropped")
	if (directed==.) _error("directed needs to be set")
	if (cols(adj) < 1) _error("number of cols needs to be 1 or higher")
	for (i=1 ; i<=rows(adj) ; i++) {
		orig = adj[i,1]
		for (j=2 ; j<= cols(adj) ; j++) {
			if (adj[i,j] != .) {
				add_edge(0,orig,adj[i,j])
			}
		}
	}
	nw_set = 1
}


void abm_nw::from_edgelist(real matrix edges)
{
	real scalar    i

	if (nw_set==1) {
		_error(3000,"initial network already set")
	}
	if (dropped_nodes0!=J(1,0,.)) _error("nodes have been dropped")
	if(cols(edges) < 2) {
		_error(3200, "edges must have at least 2 columns")
	}
	if(cols(edges) > 3) {
	    _error(3200, "edges cannot have more than 3 columns")
	}
	
	if (cols(edges)==3 & weighted == 0) _error("can't add weights to unweighted network'")
	if (directed==.) _error("directed needs to be set")
	if (cols(edges)==2) {
	    edges = edges , J(rows(edges),1,1)
	}
	for (i=1; i <= rows(edges); i++) {
		add_edge(0,edges[i,1], edges[i,2], edges[i,3])
	}
	nw_set = 1
}

void abm_nw::from_adjmatrix(real matrix adjmat)
{
	real scalar i, j, max

	if (nw_set==1) {
		_error(3000, "initial network already set")
	}
	if (dropped_nodes0!=J(1,0,.)) _error("nodes have been dropped")
	if (rows(adjmat) != N_nodes0 | cols(adjmat) != N_nodes0) {
		_error(3000, "matrix must have N_nodes0 rows and columns")
	}
	if (directed==0 & issymmetric(adjmat) == 0) {
		_error(3000, "matrix must be symmetric for non-directed network")
	}
	if (weighted == 0 & !all((adjmat:==0):|(adjmat:==1))) {
	    _error("can't add weights to an unweighted matrix'")
	}
	for(i=1; i<=N_nodes0; i++) {
		max = (directed == 0 ? i: N_nodes0)
		for(j=1; j<=max; j++) {
			if (adjmat[i,j]!=0 & i!=j) {
				add_edge(0,i,j,adjmat[i,j])
			}
		}
	}
	nw_set = 1
}

void abm_nw::random(real scalar pr) {                                         
	
	real scalar i, j, max
	
	if (nw_set==1) {
		_error(3000,"initial network already set")
	}
	is_nodesset()
	if (dropped_nodes0!=J(1,0,.)) _error("nodes have been dropped")
	if (weighted == .) weighted = 0
	if (weighted == 1) _error("random makes unweighted an network")
	is_pr(pr)
	for(i=1; i<=N_nodes0;i++) {
		max = ( directed == 0 ? i : N_nodes0 )
		for(j=1; j<=max; j++) {
			if (i!=j & runiform(1,1)<=pr) {
				add_edge(0,i,j)
			}
		}
	}
	nw_set = 1
}

void abm_nw::sw(real scalar degree, real scalar pr)
{
	real scalar left, right, i, j, alt_dest
	real vector basedest, dest

	if (nw_set==1) {
		_error(3000,"initial network already set")
	}
	is_nodesset()
	if (dropped_nodes0!=J(1,0,.)) _error("nodes have been dropped")
	if (weighted == .) weighted = 0
	if (weighted == 1) _error("sw makes unweighted an network")
	is_posint(degree)
	if (directed==0 & mod(degree,2)!= 0) {
		_error(3000, "in an unidirected network the degree has to be even")
	} 	
	if (degree>N_nodes0) {
		_error(3000, "degree has be less than the number of nodes")
	}
	is_pr(pr)
	
	left = -floor(degree/2)
	right = ceil(degree/2)
	
	if (directed == 0) {
		basedest = 1..right
		for(i=1; i <= N_nodes0 ; i++) {
			dest = basedest :+ i
			dest = mod(dest:-1, N_nodes0):+ 1
			for(j=1; j <= right; j++) {
				if (runiform(1,1)>pr) {
					add_edge(0,i,dest[j],1,"replace", "fast")
				}
				else {
					alt_dest = ceil(runiform(1,1)*(N_nodes0-1))
					alt_dest = alt_dest + (alt_dest>=i)
					add_edge(0,i,alt_dest,1,"replace", "fast")
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
		for(i=1; i<= N_nodes0; i++){
			dest = basedest :+ i
			dest = mod(dest :-1, N_nodes0) :+ 1
			for(j=1; j<=degree;j++){
				if (runiform(1,1)>pr) {
					add_edge(0,i,dest[j],1,"replace", "fast")
				}
				else {
					alt_dest = ceil(runiform(1,1)*(N_nodes0-1))
					alt_dest = alt_dest + (alt_dest>=i)
					add_edge(0,i,alt_dest,1,"replace", "fast")
				}
			}
		}
	}
	nw_set=1
}

end
