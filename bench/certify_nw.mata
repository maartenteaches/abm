set seed 123456789

// ======================================================== setup the test class
mata:
class test_abm_nw extends abm_nw
{
	public: 
		void                             tests_is_valid_id()
		void                             tests_is_valid_time()
		void                             tests_is_frozen()
		void                             tests_is_posint()
		void                             tests_is_bool()
		void                             tests_is_pr()
		void                             tests_is_nodesset()
		void                             tests_copy_nodes()
		void                             tests_copy_adjlist()
		
		real                   scalar    get_maxnodes()
		real                   scalar    get_nodes_set()
		real                   scalar    get_nw_set()
		real                   scalar    get_setup()
		real                   vector    get_N_nodes()
		real                   scalar    get_N_nodes0() 
		real                   vector    get_N_edges()
		pointer(real vector)   vector    get_nodes()
		real                   vector    get_nodes0()
		pointer(real vector)   vector    get_adjlist0()
		pointer(real vector)   matrix    get_adjlist()	
		
		
		pointer(real vector)   vector    get_dropped_nodes()
		real                   vector    get_dropped_nodes0()
}
		
void test_abm_nw::tests_copy_nodes(real scalar t0, real scalar t1)
{
	copy_nodes(t0,t1)
}
void test_abm_nw::tests_copy_adjlist(real scalar t0, real scalar t1)
{
	copy_adjlist(t0,t1)
}		
void test_abm_nw::tests_is_valid_id(real scalar id, | real scalar time, string scalar dropped_ok)
{
	if (args()==1) {
		is_valid_id(id)
	}
	else if(args()==2) {
		is_valid_id(id,time)
	}
	else {
	    is_valid_id(id,time, dropped_ok)
	}
}
void test_abm_nw::tests_is_frozen(| real scalar t)
{
    if (args()==0) {
		is_frozen()
	} 
	else {
	    is_frozen(t)
	}
}

void test_abm_nw::tests_is_nodesset() 
{
	is_nodesset()
}
void test_abm_nw::tests_is_bool(real scalar val)
{
	is_bool(val)
}

void test_abm_nw::tests_is_pr(real scalar val)
{
	is_pr(val)
}

void test_abm_nw::tests_is_valid_time(real scalar t) {
	is_valid_time(t)
}

void test_abm_nw::tests_is_posint(real scalar val, | string scalar zero_ok)
{
	if (args()==1) {
		is_posint(val)	
	}
	else {
		is_posint(val,zero_ok)
	}
}

real vector test_abm_nw::get_N_edges() {
	return(N_edges)
}
real scalar test_abm_nw::get_maxnodes()
{
	return(maxnodes)
}
real scalar test_abm_nw::get_nodes_set()
{
	return(nodes_set)
}
real scalar test_abm_nw::get_nw_set()
{
	return(nw_set)
}
real scalar test_abm_nw::get_setup()
{
	return(setup)
}
pointer(real vector) vector test_abm_nw::get_dropped_nodes()
{
	return(dropped_nodes)
}
real vector test_abm_nw::get_dropped_nodes0()
{
	return(dropped_nodes0)
}
pointer(real vector) vector test_abm_nw::get_nodes()
{
	return(nodes)
}
real vector test_abm_nw::get_nodes0()
{
	return(nodes0)
}
pointer(real vector) vector test_abm_nw::get_adjlist0()
{
	return(adjlist0)
}
pointer(real vector) matrix test_abm_nw::get_adjlist()
{
	return(adjlist)
}
real scalar test_abm_nw::get_N_nodes0()
{
	return(N_nodes0)
}
real vector test_abm_nw::get_N_nodes()
{
	return(N_nodes)
}


end	

// ======================================================================= setup
mata:
	foo = test_abm_nw()
	// check new()
	assert(foo.get_nodes_set() == 0)
	assert(foo.get_nw_set()    == 0)
	assert(foo.get_setup()     == 0)
	assert(foo.N_edges()       == 0)
end

//---------------------------------------------------------------- is_nodesset()
rcof "mata: foo.tests_is_nodesset()" == 3000
mata:
	foo.N_nodes(0,10)
	foo.tests_is_nodesset()
	
	foo = test_abm_nw()
end

// ----------------------------------------------------------------- is_valid_id
// is_valid_id should return an error if N_nodes() has not been set
rcof "mata: foo.tests_is_valid_id(1)" == 3000

mata:
	// 10 nodes, so valid ids are 1..10
	foo.N_nodes(0,10)
	for(i=1;i<=10;i++) {
		foo.tests_is_valid_id(i)
	}
end

// invalid ids
rcof "mata: foo.tests_is_valid_id(11)" == 3000
rcof "mata: foo.tests_is_valid_id(-1)" == 3000
rcof "mata: foo.tests_is_valid_id(.5)" == 3000

mata:
	foo.remove_node(0,6)
	foo.tests_is_valid_id(6,0,"dropped_ok")
end
rcof "mata foo.tests_is_valid_id(6,0)" == 3000

mata:
	foo.tdim(10)
	foo.setup()
	foo.copy_nw(0,1)
	for(i=1;i<=10;i++) {
		if (i==6){
		    foo.tests_is_valid_id(i,1, "dropped_ok")
		}
		else {
		    foo.tests_is_valid_id(i,1)
		}
	}
end

// ----------------------------------------------------------------is_valid_time
// valid times when tdim() has not been set
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.tests_is_valid_time(.)
	foo.tests_is_valid_time(0)
end

// invalid times without first specifying tdim() 
rcof "mata: foo.tests_is_valid_time(1)" == 3000

// tdim=10, so valid times are now 0..10
mata:
	foo.tdim(10)
	for(i=0;i>=10;i++) {
		foo.tests_is_valid_time(i)
	}
end

// invalid times
rcof "mata: foo.tests_is_valid_time(11)" == 3000
rcof "mata: foo.tests_is_valid_time(-1)" == 3300
rcof "mata: foo.tests_is_valid_time(1.5)" == 3300

// ------------------------------------------------------------------- is_posint
mata:
	for(i=1; i <=100; i++) {
		foo.tests_is_posint(i)
	}
	foo.tests_is_posint(0, "zero_ok")
	foo.tests_is_posint(0, "maarten is great") // any (silly) string will make zero ok
end
rcof "mata: foo.tests_is_posint(0)" == 3300
rcof "mata: foo.tests_is_posint(1.3)" == 3300
rcof "mata: foo.tests_is_posint(-1)" == 3300

// --------------------------------------------------------------------- is_bool
mata:
	foo.tests_is_bool(0)
	foo.tests_is_bool(1)
end
rcof "mata: foo.tests_is_bool(-1)" == 3300
rcof "mata: foo.tests_is_bool(2)" == 3300
rcof "mata: foo.tests_is_bool(0.5)" == 3300

// ----------------------------------------------------------------------- is_pr
mata:
for(i=0; i<=100; i++) {
	foo.tests_is_pr(i/100)
}
end

rcof "mata: foo.tests_is_pr(-1)"==3300
rcof "mata: foo.tests_is_pr(1.0000000001)"==3300

// -------------------------------------------------------------------- directed
mata:
	assert(foo.directed()==.)
	foo.directed(0)
	assert(foo.directed()==0)
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.directed(1)
	assert(foo.directed()==1)
end
rcof "mata: foo.directed(.5)" == 3300

// ------------------------------------------------------------------------ tdim
mata:
	assert(foo.tdim()==.)
	foo.tdim(10)
	assert(foo.tdim() == 10)
	assert(foo.get_nodes() == J(10,1,NULL))
	assert(foo.get_N_nodes()==J(10,1,.))
	for(i=1; i<=10; i++) { // nodes
		for(j=1; j<=10; j++) { // times
			assert(*(foo.get_adjlist()[i,j])==J(1,0,.))
		}
	}
	for(i=1; i<=10; i++) {
		assert(*(foo.get_dropped_nodes()[i])==J(1,0,.))
	}
	assert(foo.get_N_edges()==J(10,1,0))
end

// ------------------------------------------------------------- is_frozen setup
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.tdim(3)
	foo.tests_is_frozen(1)
	foo.tests_is_frozen(0)
	assert(foo.directed() == .)
	assert(foo.randomit() == .)
	assert(foo.weighted() == .)
	foo.setup()
	assert(foo.directed() == 1)
	assert(foo.randomit() == 0)
	assert(foo.weighted() == 1)
end
rcof "mata : foo.tests_is_frozen(0)" == 3498
mata:
	foo.copy_nw(0,1)
	foo.copy_nw(1,2)
end
rcof "mata: foo.tests_is_frozen(1)" == 3498
rcof "mata : foo.copy_nw(2,1)" == 3498
rcof "mata : foo.add_node(1)" == 3498
rcof "mata: foo.add_edge(1,1,2)" == 3498

// ------------------------------------------------------------- N_nodes N_nodes
mata:
	foo = test_abm_nw()
	assert(foo.N_nodes(0)==.)
	foo.N_nodes(0,10)
	assert(foo.N_nodes(0)==10)
	assert(foo.get_nodes0() == (1..10))
	for(i=1; i<= 10; i++){
		assert(*(foo.get_adjlist0()[i])==J(1,0,.))
	}
	assert(foo.get_maxnodes()==10)
	assert(foo.get_dropped_nodes0()==J(1,0,.))
	assert(foo.get_nodes_set()==1)
end


// ----------------------------------- add_edge, neighbours, weight, and N_edges
mata:
	// directed graph
	assert(foo.N_edges() == 0)
	foo.weighted(1)
	foo.add_edge(0,1,2)
	assert(foo.weight(1,2) == 1)
	assert(foo.neighbours(1)==2)
	assert(foo.weight(2,1) == 0)
	for(i=2; i<= 10 ; i++) {
		assert(	foo.neighbours(i)==J(1,0,.))
	}
	assert(foo.N_edges() == 1)
	
	// undirected graph
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.directed(0)
	foo.weighted(1)
	foo.add_edge(0,1,3)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,1) == 1)
	assert(foo.neighbours(1) == 3)
	assert(foo.neighbours(2) == J(1,0,.))
	assert(foo.neighbours(3) == 1)
	for(i=4; i <= 10 ; i++) {
		assert(	foo.neighbours(i)==J(1,0,.))
	}
	assert(foo.N_edges() == 2)
	
	// weight
	foo.add_edge(0,1,4,2)
	assert(foo.weight(1,4)==2)
	assert(foo.weight(4,1)==2)
	
	// replace
	foo.add_edge(0,1,4,3,"replace")
	assert(foo.weight(1,4)==3)
	assert(foo.weight(4,1)==3)
	
	// weighted
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.directed(0)
	foo.weighted(0)
end	
rcof "mata: foo.add_edge(0,1,3,2)" == 3498

mata:
	foo.add_edge(0,1,3)
	foo.add_edge(0,1,4,0)
	foo.add_edge(0,1,5,1)
	assert(foo.weight(1,3) == 1)
	assert(foo.edge_exists(1,3)==1)
	assert(foo.weight(1,4) == 0)
	assert(foo.edge_exists(1,4) == 0)
	assert(foo.weight(1,5)==1)
	assert(foo.edge_exists(1,5)==1)
end
// ------------------------------------------- export_adjmat and export_edgelist	

mata:	
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.directed(1)
	foo.weighted(1)
	foo.add_edge(0,1,3)
	foo.add_edge(0,1,4,3,"replace")
	
	true = (1,3,1 \  
            1,4,3 )  
			
	assert( foo.export_edgelist()  == true)
	
	true = true \ ((2..10)', J(9,2,.))
	assert(foo.export_edgelist(0,"ego_all") == true)
	
    true = J(10,10,0)
	true[1,3] = 1
	true[1,4] = 3
	assert(foo.export_adjmat()	== true)	
	
// unweighted
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.directed(1)
	foo.weighted(0)
	foo.add_edge(0,1,3)
	foo.add_edge(0,1,4,)
	
	true = (1,3,1 \  
            1,4,1 )  
			
	assert( foo.export_edgelist()  == true)
	
    true = J(10,10,0)
	true[1,3] = 1
	true[1,4] = 1
	assert(foo.export_adjmat()	== true)	
end

// --------------------------------------------------------------------- no_edge

mata:
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.directed(0)
	foo.weighted(1)
	foo.add_edge(0,1,3)
	foo.add_edge(0,1,4,3,"replace")
for(i=1; i<=10; i++) {
	for(j=1; j<=10; j++) {
		hasedge = 0
		hasedge = hasedge + (i==3 & j== 1)
		hasedge = hasedge + (i==1 & j== 3)
		hasedge = hasedge + (i==4 & j== 1)
		hasedge = hasedge + (i==1 & j== 4)
		if (hasedge==0) foo.no_edge(0,i,j)
	}
}
end

rcof "mata : foo.no_edge(0,3,1)" == 3000
rcof "mata : foo.no_edge(0,1,3)" == 3000
rcof "mata : foo.no_edge(0,4,1)" == 3000
rcof "mata : foo.no_edge(0,1,4)" == 3000

// ----------------------------------------------------------------- edge_exists          
mata:	
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	foo.weighted(1)
	foo.tdim(2)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	foo.setup()
	assert(foo.edge_exists(1,2)==1)
	assert(foo.edge_exists(1,2,0)==1)
	assert(foo.edge_exists(1,2,0, "fast")==1)	
	assert(foo.edge_exists(2,1)==0)
	assert(foo.edge_exists(2,1,0)==0)
	assert(foo.edge_exists(2,1,0, "fast")==0)	
	foo.copy_nw(0,1)
	assert(foo.edge_exists(1,2,1)==1)
	assert(foo.edge_exists(1,2,1, "fast")==1)
	assert(foo.edge_exists(2,1,1)==0)
	assert(foo.edge_exists(2,1,1, "fast")==0)	
end
rcof "mata foo.edge_exists(1,6)" == 3000
rcof "mata foo.edge_exists(1,6,0)" == 3000
rcof "mata foo.edge_exists(1,6,1)" == 3000

// --------------------------------------------------------------- from_edgelist
mata:	
	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(2,1) == .5)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,1) == 1)
	assert(foo.weight(3,5) == 2)
	assert(foo.weight(5,3) == 2)
	assert(foo.weight(2,4) == .25)   
	assert(foo.weight(4,2) == .25)
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==2 & j==1)
			filled = filled + (i==3 & j==1)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			filled = filled + (i==2 & j==4)
			filled = filled + (i==4 & j==2)
			if (!filled) {
				assert(foo.weight(i,j) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	assert(*(foo.get_adjlist0()[1]) == (2,3))
	assert(*(foo.get_adjlist0()[2]) == (1,4))
	assert(*(foo.get_adjlist0()[3]) == (1,5))
	assert(*(foo.get_adjlist0()[4]) == 2    )
	assert(*(foo.get_adjlist0()[5]) == 3    )
	
	// directed
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	foo.from_edgelist(bar)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,5) == 2)
	assert(foo.weight(2,4) == .25)   
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==2 & j==4)
			if (!filled) {
				assert(foo.weight(i,j) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	assert(*(foo.get_adjlist0()[1]) == (2,3))
	assert(*(foo.get_adjlist0()[2]) == (4))
	assert(*(foo.get_adjlist0()[3]) == (5))
	assert(*(foo.get_adjlist0()[4]) == J(1,0,.) )
	assert(*(foo.get_adjlist0()[5]) == J(1,0,.) )
end

mata:	
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.weighted(0)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
end
rcof "mata : foo.from_edgelist(bar)" == 3498

// non-weighted
mata:
	bar = (1,2 \ 
	       1,3 \
	       3,5 \
	       2,4 )
	foo.from_edgelist(bar)	   
	assert(foo.weight(1,2) == 1)
	assert(foo.weight(2,1) == 1)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,1) == 1)
	assert(foo.weight(3,5) == 1)
	assert(foo.weight(5,3) == 1)
	assert(foo.weight(2,4) == 1)   
	assert(foo.weight(4,2) == 1)
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==2 & j==1)
			filled = filled + (i==3 & j==1)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			filled = filled + (i==2 & j==4)
			filled = filled + (i==4 & j==2)
			if (!filled) {
				assert(foo.weight(i,j) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	assert(*(foo.get_adjlist0()[1]) == (2,3))
	assert(*(foo.get_adjlist0()[2]) == (1,4))
	assert(*(foo.get_adjlist0()[3]) == (1,5))
	assert(*(foo.get_adjlist0()[4]) == 2    )
	assert(*(foo.get_adjlist0()[5]) == 3    )
end

// ---------------------------------------------------------------- from_adjlist
mata:
// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	bla = 1,2,3 \
	      3,5,. \
		  2,4,.
	foo.from_adjlist(bla)
	assert(foo.weight(1,2) == 1)
	assert(foo.weight(2,1) == 1)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,1) == 1)
	assert(foo.weight(3,5) == 1)
	assert(foo.weight(5,3) == 1)
	assert(foo.weight(2,4) == 1)   
	assert(foo.weight(4,2) == 1)
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==2 & j==1)
			filled = filled + (i==3 & j==1)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			filled = filled + (i==2 & j==4)
			filled = filled + (i==4 & j==2)
			if (!filled) {
				assert(foo.weight(i,j) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	assert(*(foo.get_adjlist0()[1]) == (2,3))
	assert(*(foo.get_adjlist0()[2]) == (1,4))
	assert(*(foo.get_adjlist0()[3]) == (1,5))
	assert(*(foo.get_adjlist0()[4]) == 2    )
	assert(*(foo.get_adjlist0()[5]) == 3    )

//directed	
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	foo.from_adjlist(bla)
	assert(foo.weight(1,2) == 1)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,5) == 1)
	assert(foo.weight(2,4) == 1)   
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==2 & j==4)
			if (!filled) {
				assert(foo.weight(i,j) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	assert(*(foo.get_adjlist0()[1]) == (2,3))
	assert(*(foo.get_adjlist0()[2]) == (4))
	assert(*(foo.get_adjlist0()[3]) == (5))
	assert(*(foo.get_adjlist0()[4]) == J(1,0,.) )
	assert(*(foo.get_adjlist0()[5]) == J(1,0,.) )
end

// -------------------------------------------------------------- from_adjmatrix
mata:
//undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	adj = J(5,5,0)
	adj[1,2] = .5
	adj[2,1] = .5
	adj[1,3] = 1
	adj[3,1] = 1
	adj[3,5] = 2
	adj[5,3] = 2
	adj[2,4] = .25
	adj[4,2] = .25
	foo.from_adjmatrix(adj)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(2,1) == .5)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,1) == 1)
	assert(foo.weight(3,5) == 2)
	assert(foo.weight(5,3) == 2)
	assert(foo.weight(2,4) == .25)   
	assert(foo.weight(4,2) == .25)
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==2 & j==1)
			filled = filled + (i==3 & j==1)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			filled = filled + (i==2 & j==4)
			filled = filled + (i==4 & j==2)
			if (!filled) {
				assert(foo.weight(i,j) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	assert(*(foo.get_adjlist0()[1]) == (2,3))
	assert(*(foo.get_adjlist0()[2]) == (1,4))
	assert(*(foo.get_adjlist0()[3]) == (1,5))
	assert(*(foo.get_adjlist0()[4]) == 2    )
	assert(*(foo.get_adjlist0()[5]) == 3    )

//directed
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	adj = J(5,5,0)
	adj[1,2] = .5
	adj[1,3] = 1
	adj[3,5] = 2
	adj[2,4] = .25
	foo.from_adjmatrix(adj)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,5) == 2)
	assert(foo.weight(2,4) == .25)   
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==2 & j==4)
			if (!filled) {
				assert(foo.weight(i,j) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	assert(*(foo.get_adjlist0()[1]) == (2,3))
	assert(*(foo.get_adjlist0()[2]) == 4)
	assert(*(foo.get_adjlist0()[3]) == 5)
	assert(*(foo.get_adjlist0()[4]) == J(1,0,.) )
	assert(*(foo.get_adjlist0()[5]) == J(1,0,.) )
end



// an undirected network needs to be symmetric
mata:	
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)	
end
rcof "mata: foo.from_adjmatrix(adj)" == 3000

// weighted
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	foo.weighted(0)
	adj = J(5,5,0)
	adj[1,2] = .5
	adj[1,3] = 1
	adj[3,5] = 2
	adj[2,4] = .25
end
rcof "mata: foo.from_adjmatrix(adj)" == 3498

mata:
	adj[1,2] = 1
	adj[1,3] = 1
	adj[3,5] = 1
	adj[2,4] = 1
	foo.from_adjmatrix(adj)
	assert(foo.weight(1,2) == 1)
	assert(foo.weight(1,3) == 1)
	assert(foo.weight(3,5) == 1)
	assert(foo.weight(2,4) == 1)   
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==2 & j==4)
			if (!filled) {
				assert(foo.weight(i,j) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	assert(*(foo.get_adjlist0()[1]) == (2,3))
	assert(*(foo.get_adjlist0()[2]) == 4)
	assert(*(foo.get_adjlist0()[3]) == 5)
	assert(*(foo.get_adjlist0()[4]) == J(1,0,.) )
	assert(*(foo.get_adjlist0()[5]) == J(1,0,.) )

end
	
// -------------------------------------------------------------------------- sw
// unidirected
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.sw(2,0)
	assert(	foo.weighted()==0)
	for(i=1; i<=4; i++) {
		assert(foo.weight(i, i+1)==1)
	}
	assert(foo.weight(5,1)==1)
	assert(foo.weight(1,5)==1)
	for(i=2; i<=5; i++) {
		assert(foo.weight(i,i-1)==1)
	}
	assert(foo.weight(3,1)==0)
	assert(foo.weight(4,1)==0)
	assert(foo.weight(4,2)==0)
	assert(foo.weight(5,2)==0)
	assert(foo.weight(5,3)==0)
	assert(foo.weight(1,3)==0)
	assert(foo.weight(1,4)==0)
	assert(foo.weight(2,4)==0)
	assert(foo.weight(2,5)==0)
	assert(foo.weight(3,5)==0)
	for(i=1;i<=5;i++){
		assert(foo.weight(i,i)==0)
	}
	assert(*foo.get_adjlist0()[1]==(2,5))
	assert(*foo.get_adjlist0()[2]==(1,3))
	assert(*foo.get_adjlist0()[3]==(2,4))
	assert(*foo.get_adjlist0()[4]==(3,5))
	assert(*foo.get_adjlist0()[5]==(4,1))
end

// undirected network needs an even degree
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
end
rcof "mata: foo.sw(3,0)" == 3000

// directed network can have an odd degree
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	foo.sw(3,0)
end

// ----------------------------------------------------------------- remove_edge
mata:	
	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(2,1) == .5)
	assert(foo.N_edges(0)==8)
	assert(*foo.get_adjlist0()[1] == (2,3) )
	assert(*foo.get_adjlist0()[2] == (1,4) )
	assert(*foo.get_adjlist0()[3] == (1,5) )
	assert(*foo.get_adjlist0()[4] == 2 )
	assert(*foo.get_adjlist0()[5] == 3 )
	
	foo.remove_edge(0,1,2)
	assert(foo.weight(1,2) == 0)
	assert(foo.weight(2,1) == 0)
	foo.no_edge(0,1,2)
	foo.no_edge(0,2,1)
	assert(foo.N_edges(0) == 6)
	assert(*foo.get_adjlist0()[1] == (3) )
	assert(*foo.get_adjlist0()[2] == (4) )
	assert(*foo.get_adjlist0()[3] == (1,5) )
	assert(*foo.get_adjlist0()[4] == 2 )
	assert(*foo.get_adjlist0()[5] == 3 )
	
	// directed
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	bar = (1,2, .5 \ 
	       2,1, 3 \
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(2,1) == 3)	
	assert(foo.N_edges(0)==5)
	assert(*foo.get_adjlist0()[1] == (2,3))
	assert(*foo.get_adjlist0()[2] == (1,4))
	assert(*foo.get_adjlist0()[3] == 5)
	assert(*foo.get_adjlist0()[4] == J(1,0,.))
	assert(*foo.get_adjlist0()[5] == J(1,0,.))
	
	foo.remove_edge(0,1,2)
	assert(foo.weight(1,2) == 0)
	assert(foo.weight(2,1) == 3)
	foo.no_edge(0,1,2)
	assert(foo.N_edges(0)==4)
	assert(*foo.get_adjlist0()[1] == (3))
	assert(*foo.get_adjlist0()[2] == (1,4))
	assert(*foo.get_adjlist0()[3] == 5)
	assert(*foo.get_adjlist0()[4] == J(1,0,.))
	assert(*foo.get_adjlist0()[5] == J(1,0,.))
end

// ------------------------------------------------------------ change_weight
mata:	
	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(2,1) == .5)
	foo.change_weight(0,1,2,4)
	assert(foo.weight(1,2) == 4)
	assert(foo.weight(2,1) == 4)

	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(2,1) == 0)
	foo.change_weight(0,1,2,4)
	assert(foo.weight(1,2) == 4)
	assert(foo.weight(2,1) == 0)	
end

// an edge needs to exist before changing the weight
rcof "mata : foo.change_weight(0,2,1,5)" == 3000

// ----------------------------------------------------------------- rewire
mata:
	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(2,1) == .5)
	foo.rewire(0,1,2,1,5)
	assert(foo.weight(1,2) == 0)
	assert(foo.weight(2,1) == 0)
	assert(foo.weight(1,5) == .5)
	assert(foo.weight(5,1) == .5)
	assert(foo.N_edges(0) == 8)
	assert(*foo.get_adjlist0()[1] == (3,5))
	assert(*foo.get_adjlist0()[2] == (4))
	assert(*foo.get_adjlist0()[3] == (1,5))
	assert(*foo.get_adjlist0()[4] == 2)
	assert(*foo.get_adjlist0()[5] == (3,1))	

	// directed
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.weight(1,2) == .5)
	assert(foo.weight(2,1) == 0)
	foo.rewire(0,1,2,1,5)
	assert(foo.weight(1,2) == 0)
	assert(foo.weight(2,1) == 0)
	assert(foo.weight(1,5) == .5)
	assert(foo.weight(5,1) == 0)
	assert(foo.N_edges(0) == 4)
	assert(*foo.get_adjlist0()[1] == (3,5))
	assert(*foo.get_adjlist0()[2] == (4))
	assert(*foo.get_adjlist0()[3] == (5))
	assert(*foo.get_adjlist0()[4] == J(1,0,.))
	assert(*foo.get_adjlist0()[5] == J(1,0,.))		
end

// ------------------------------------------------------------------ copy_nodes
mata:
	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.tdim(5)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert( foo.get_nodes()[1] == NULL)
	assert( foo.get_N_nodes()[1]==.)
	foo.tests_copy_nodes(0,1)
	assert( *foo.get_nodes()[1] == (1..5))
	assert(foo.get_N_nodes()[1]==5)
end

// ---------------------------------------------------------------- copy_adjlist
mata:
	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.tdim(5)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[2,1] == J(1,0,.))
	assert(*foo.get_adjlist()[3,1] == J(1,0,.))
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == J(1,0,.))
	foo.tests_copy_adjlist(0,1)
	assert(*foo.get_adjlist()[1,1] == (2,3))
	assert(*foo.get_adjlist()[2,1] == (1,4))
	assert(*foo.get_adjlist()[3,1] == (1,5))
	assert(*foo.get_adjlist()[4,1] == 2)
	assert(*foo.get_adjlist()[5,1] == 3)
	
	// directed
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	foo.tdim(5)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[2,1] == J(1,0,.))
	assert(*foo.get_adjlist()[3,1] == J(1,0,.))
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == J(1,0,.))
	foo.tests_copy_adjlist(0,1)
	assert(*foo.get_adjlist()[1,1] == (2,3))
	assert(*foo.get_adjlist()[2,1] == (4))
	assert(*foo.get_adjlist()[3,1] == (5))
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == J(1,0,.))	
end

// --------------------------------------------------------------------- copy_nw
mata:
	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.tdim(5)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	foo.setup()
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[2,1] == J(1,0,.))
	assert(*foo.get_adjlist()[3,1] == J(1,0,.))
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == J(1,0,.))
	assert( foo.get_nodes()[1] == NULL)
	assert( foo.get_N_nodes()[1]==.)
	assert(foo.get_N_edges() == (0\0\0\0\0))
	
	foo.copy_nw(0,1)
	
	assert(*foo.get_adjlist()[1,1] == (2,3))
	assert(*foo.get_adjlist()[2,1] == (1,4))
	assert(*foo.get_adjlist()[3,1] == (1,5))
	assert(*foo.get_adjlist()[4,1] == 2)
	assert(*foo.get_adjlist()[5,1] == 3)	
	assert( *foo.get_nodes()[1] == (1..5))
	assert(foo.get_N_nodes()[1]==5)
	assert(foo.weight(1,2,1) == .5)
	assert(foo.weight(2,1,1) == .5)
	assert(foo.weight(1,3,1) == 1)
	assert(foo.weight(3,1,1) == 1)
	assert(foo.weight(3,5,1) == 2)
	assert(foo.weight(5,3,1) == 2)
	assert(foo.weight(2,4,1) == .25)   
	assert(foo.weight(4,2,1) == .25)
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==2 & j==1)
			filled = filled + (i==3 & j==1)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			filled = filled + (i==2 & j==4)
			filled = filled + (i==4 & j==2)
			if (!filled) {
				assert(foo.weight(i,j,1) == 0)
				foo.no_edge(1,i,j)
			}
		}
	}
	assert(foo.get_N_edges() == (8\0\0\0\0))
	
	// directed
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	foo.tdim(5)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	foo.setup()
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[2,1] == J(1,0,.))
	assert(*foo.get_adjlist()[3,1] == J(1,0,.))
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == J(1,0,.))
	assert( foo.get_nodes()[1] == NULL)
	assert( foo.get_N_nodes()[1]==.)
	assert(foo.get_N_edges() == (0\0\0\0\0))

	assert(foo.weight(1,2,0) == .5)
	assert(foo.weight(1,3,0) == 1)
	assert(foo.weight(3,5,0) == 2)
	assert(foo.weight(2,4,0) == .25)   
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==2 & j==4)
			if (!filled) {
				assert(foo.weight(i,j,0) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	foo.copy_nw(0,1)
	
	assert(*foo.get_adjlist()[1,1] == (2,3))
	assert(*foo.get_adjlist()[2,1] == (4))
	assert(*foo.get_adjlist()[3,1] == (5))
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == J(1,0,.))	
	assert( *foo.get_nodes()[1] == (1..5))
	assert(foo.get_N_nodes()[1]==5)	
	assert(foo.weight(1,2,1) == .5)
	assert(foo.weight(1,3,1) == 1)
	assert(foo.weight(3,5,1) == 2)
	assert(foo.weight(2,4,1) == .25)   
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==2 & j==4)
			if (!filled) {
				assert(foo.weight(i,j,1) == 0)
				foo.no_edge(1,i,j)
			}
		}
	}
	assert(foo.get_N_edges() == (4\0\0\0\0))
end

// non-weighted
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(1)
	foo.tdim(5)
	foo.weighted(0)
	bar = (1,2 \ 
	       1,3 \
	       3,5 \
	       2,4)
	foo.from_edgelist(bar)
	foo.setup()
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[2,1] == J(1,0,.))
	assert(*foo.get_adjlist()[3,1] == J(1,0,.))
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == J(1,0,.))
	assert( foo.get_nodes()[1] == NULL)
	assert( foo.get_N_nodes()[1]==.)
	assert(foo.get_N_edges() == (0\0\0\0\0))

	assert(foo.weight(1,2,0) == 1)
	assert(foo.weight(1,3,0) == 1)
	assert(foo.weight(3,5,0) == 1)
	assert(foo.weight(2,4,0) == 1)   
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==2 & j==4)
			if (!filled) {
				assert(foo.weight(i,j,0) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
	foo.copy_nw(0,1)
	
	assert(*foo.get_adjlist()[1,1] == (2,3))
	assert(*foo.get_adjlist()[2,1] == (4))
	assert(*foo.get_adjlist()[3,1] == (5))
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == J(1,0,.))	
	assert( *foo.get_nodes()[1] == (1..5))
	assert(foo.get_N_nodes()[1]==5)	
	assert(foo.weight(1,2,1) == 1)
	assert(foo.weight(1,3,1) == 1)
	assert(foo.weight(3,5,1) == 1)
	assert(foo.weight(2,4,1) == 1)   
	for (i=1; i<=5;i++) {
		for(j=1; j<=5; j++) {
			filled =          (i==1 & j==2)
			filled = filled + (i==1 & j==3)
			filled = filled + (i==3 & j==5)
			filled = filled + (i==2 & j==4)
			if (!filled) {
				assert(foo.weight(i,j,1) == 0)
				foo.no_edge(1,i,j)
			}
		}
	}
	assert(foo.get_N_edges() == (4\0\0\0\0))
end

// ----------------------------------------------------------------- remove_node
mata:
	// undirected
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.tdim(5)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(*foo.get_adjlist0()[1] == (2,3))
	assert(*foo.get_adjlist0()[2] == (1,4))
	assert(*foo.get_adjlist0()[3] == (1,5))
	assert(*foo.get_adjlist0()[4] == 2)
	assert(*foo.get_adjlist0()[5] == 3)
	foo.remove_node(0,1)
	assert(foo.get_N_nodes0() == 4)
	assert(foo.get_nodes0() == (2..5))
	assert(foo.get_dropped_nodes0()==1)
	assert(*foo.get_adjlist0()[1] == J(1,0,.))
	assert(*foo.get_adjlist0()[5] == 3 )	
	assert(*foo.get_adjlist0()[2] == 4 )
	assert(*foo.get_adjlist0()[3] == 5 )
	assert(*foo.get_adjlist0()[4] == 2 )
	assert(foo.weight(3,5,0) == 2)
	assert(foo.weight(5,3,0) == 2)
	assert(foo.weight(2,4,0) == .25)
	assert(foo.weight(4,2,0) == .25)
	for (i=2; i<=5;i++) {
		for(j=2; j<=5; j++) {
			filled =          (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			filled = filled + (i==2 & j==4)
			filled = filled + (i==4 & j==2)
			if (!filled) {
				assert(foo.weight(i,j,0) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}

	foo.setup()
	foo.copy_nw(0,1)
	assert(*foo.get_dropped_nodes()[1]==1)
	assert(*foo.get_nodes()[1]==(2..5))
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == 3 )	
	assert(*foo.get_adjlist()[2,1] == 4 )
	assert(*foo.get_adjlist()[3,1] == 5 )
	assert(*foo.get_adjlist()[4,1] == 2 )
	foo.remove_node(1,2)
	assert(foo.get_N_nodes()[1] == 3)
	assert(*foo.get_dropped_nodes()[1] == (1,2))
	assert(*foo.get_nodes()[1] == (3..5))
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[2,1] == J(1,0,.))
	assert(*foo.get_adjlist()[3,1] == 5)
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
 	assert(*foo.get_adjlist()[5,1] == 3)
	assert(foo.weight(3,5,1) == 2)
	assert(foo.weight(5,3,1) == 2)
	for (i=3; i<=5;i++) {
		for(j=3; j<=5; j++) {
			filled =          (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			if (!filled) {
				assert(foo.weight(i,j,0) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
end
rcof "mata foo.tests_is_valid_id(1,0)" == 3000
rcof "mata foo.tests_is_valid_id(1,1)" == 3000
rcof "mata foo.tests_is_valid_id(2,1)" == 3000

// non-weighted
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.weighted(0)
	foo.tdim(5)
	bar = (1,2 \ 
	       1,3 \
	       3,5 \
	       2,4 )
	foo.from_edgelist(bar)
	assert(*foo.get_adjlist0()[1] == (2,3))
	assert(*foo.get_adjlist0()[2] == (1,4))
	assert(*foo.get_adjlist0()[3] == (1,5))
	assert(*foo.get_adjlist0()[4] == 2)
	assert(*foo.get_adjlist0()[5] == 3)
	foo.remove_node(0,1)
	assert(foo.get_N_nodes0() == 4)
	assert(foo.get_nodes0() == (2..5))
	assert(foo.get_dropped_nodes0()==1)
	assert(*foo.get_adjlist0()[1] == J(1,0,.))
	assert(*foo.get_adjlist0()[5] == 3 )	
	assert(*foo.get_adjlist0()[2] == 4 )
	assert(*foo.get_adjlist0()[3] == 5 )
	assert(*foo.get_adjlist0()[4] == 2 )
	assert(foo.weight(3,5,0) == 1)
	assert(foo.weight(5,3,0) == 1)
	assert(foo.weight(2,4,0) == 1)
	assert(foo.weight(4,2,0) == 1)
	for (i=2; i<=5;i++) {
		for(j=2; j<=5; j++) {
			filled =          (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			filled = filled + (i==2 & j==4)
			filled = filled + (i==4 & j==2)
			if (!filled) {
				assert(foo.weight(i,j,0) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}

	foo.setup()
	foo.copy_nw(0,1)
	assert(*foo.get_dropped_nodes()[1]==1)
	assert(*foo.get_nodes()[1]==(2..5))
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[5,1] == 3 )	
	assert(*foo.get_adjlist()[2,1] == 4 )
	assert(*foo.get_adjlist()[3,1] == 5 )
	assert(*foo.get_adjlist()[4,1] == 2 )
	foo.remove_node(1,2)
	assert(foo.get_N_nodes()[1] == 3)
	assert(*foo.get_dropped_nodes()[1] == (1,2))
	assert(*foo.get_nodes()[1] == (3..5))
	assert(*foo.get_adjlist()[1,1] == J(1,0,.))
	assert(*foo.get_adjlist()[2,1] == J(1,0,.))
	assert(*foo.get_adjlist()[3,1] == 5)
	assert(*foo.get_adjlist()[4,1] == J(1,0,.))
 	assert(*foo.get_adjlist()[5,1] == 3)
	assert(foo.weight(3,5,1) == 1)
	assert(foo.weight(5,3,1) == 1)
	for (i=3; i<=5;i++) {
		for(j=3; j<=5; j++) {
			filled =          (i==3 & j==5)
			filled = filled + (i==5 & j==3)
			if (!filled) {
				assert(foo.weight(i,j,0) == 0)
				foo.no_edge(0,i,j)
			}
		}
	}
end

// ----------------------------------------------------------------- return_node
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.tdim(5)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	foo.setup()
	foo.copy_nw(0,1)
	foo.remove_node(1,2)
	foo.copy_nw(1,2)           
	foo.return_node(2,2)
	assert(*foo.get_nodes()[1] == (1,3, 4,5))
	assert(*foo.get_nodes()[2] == (1,3,4,5,2))
	assert(*foo.get_dropped_nodes()[1] == 2)
	assert(*foo.get_dropped_nodes()[2] == J(1,0,.))
	assert(foo.get_N_nodes() == (4 \ 5 \ . \ . \ .))
end
rcof "mata: foo.return_node(2,6)" == 3498
rcof "mata: foo.return_node(2,5)" == 3498

// -------------------------------------------------------------------- add_node
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.tdim(5)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.get_nodes0()==(1..5))
	assert(foo.get_N_nodes0() == 5)
	assert(length(foo.get_adjlist0()) == 5)
	assert(rows(foo.get_adjlist())==5)
	foo.add_node(0)
	assert(foo.get_nodes0()==(1..6))
	assert(foo.get_N_nodes0() == 6)
	assert(length(foo.get_adjlist0()) == 6)
	assert(rows(foo.get_adjlist())==6)
	foo.setup()
	foo.copy_nw(0,1)
	foo.add_node(1)
	assert(*foo.get_nodes()[1]==(1..7))
	assert(foo.get_N_nodes()[1] == 7)
	assert(length(foo.get_adjlist0()) == 7)
	assert(rows(foo.get_adjlist())==7)	
end

// ------------------------------------------------------- randomit and schedule
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.tdim(5)
	foo.randomit(0)
	assert(foo.randomit()==0)
	bar = (1,2, .5 \ 
	       1,3, 1 \
	       3,5, 2 \
	       2,4, .25)
	foo.from_edgelist(bar)
	assert(foo.schedule() == (1..5))
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.randomit(1)
	assert(foo.schedule() == ( 2,3,5,1,4 ))
	assert(foo.schedule() == ( 2,1,5,3,4 ))
end

// -------------------------------------------------------------------- weighted 
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,5)
	foo.directed(0)
	foo.tdim(5)
	foo.weighted(0)
	assert(foo.weighted()==0)
end
rcof "mata: foo.weighted(.5)"==3300
rcof "mata: foo.weighted(2)"==3300
rcof "mata: foo.weighted(-1)"==3300


// ----------------------------------------------------------------------- clear
mata:
	foo = test_abm_nw()
	foo.N_nodes(0,10)
	foo.directed(0)
	foo.tdim(0)
	foo.weighted(0)
	foo.sw(2,0.05)
	foo.setup()
	true = 
  1 ,   2 ,   1  \
  2 ,   3 ,   1  \
  3 ,   4 ,   1  \
  4 ,   5 ,   1  \
  5 ,   6 ,   1  \
  6 ,   7 ,   1  \
  7 ,   8 ,   1  \
  8 ,   9 ,   1  \
  8 ,  10 ,   1  \
  9 ,  10 ,   1  

	assert(foo.export_edgelist() == true)
	foo.clear()
	foo.sw(2,0.05)
	true = 
  1 ,   2 ,   1  \
  1 ,  10 ,   1  \
  2 ,   3 ,   1  \
  3 ,   4 ,   1  \
  4 ,   5 ,   1  \
  5 ,   6 ,   1  \
  6 ,   7 ,   1  \
  7 ,   8 ,   1  \
  8 ,   9 ,   1  \
  9 ,  10 ,   1  

  assert(foo.export_edgelist() == true)
  
  foo.clear()
  foo.weighted(1)
  
end
