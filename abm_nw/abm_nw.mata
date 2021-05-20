mata:

mata set matastrict on

class abm_nw extends abm_chk
{
	protected: 
		real                   vector    N_edges
		real                   vector    N_nodes
		real                   scalar    N_edges0
		real                   scalar    N_nodes0		
		real                   scalar    maxnodes
		real                   scalar    tdim
		real                   scalar    directed
		real                   scalar    weighted
		real                   scalar    nodes_set
		real                   scalar    nw_set
		real                   scalar    setup
		real                   scalar    randomit
		real                   vector    frozen
		
		class AssociativeArray scalar    network
		pointer(real vector)   vector    adjlist0
		pointer(real vector)   matrix    adjlist
		real                   vector    nodes0
		pointer(real vector)   vector    nodes
		pointer(real vector)   vector    dropped_nodes
		real                   vector    dropped_nodes0
		
		// _chks.mata
		void                             is_valid_id()
		void                             is_valid_time()
		void                             is_frozen()
		void                             is_setup()
		void                             is_nodesset()
		void                             is_symmetric()
		
		// _change_nw.mata
		void                             copy_adjlist()
		void                             copy_nodes()

		// _setup.mata
		void                             new()
	
	public:
		// _create_nw.mata
		void                             from_edgelist()
		void                             from_adjlist()
		void                             from_adjmatrix()
		void                             random()
		void                             sw()                                       //small world

		// _pars.mata
		transmorphic                     N_nodes()
		transmorphic                     tdim()
		transmorphic                     directed()
		transmorphic                     randomit()
		transmorphic                     weighted()

		// _setup.mata
		void                             setup()
       	void                             clear()

		// _change_nw.mata
		void                             copy_nw()                               // copy network from t-1 to t, also calls copy_adjlist() and copy_nodes()
		void                             add_edge()
		void                             add_node()
		void                             return_node()
		void                             remove_edge()
		void                             change_weight()
		void                             remove_node()
		void                             rewire()
		
		// _return.mata
		real                   scalar    N_edges()
		real                   rowvector neighbours()
		real                   scalar    weight()
		void                             no_edge()
		real                   scalar    edge_exists()
		real                   vector    schedule()
		
		// _export.mata
		real                   matrix    export_adjmat()
		real                   matrix    export_edgelist()
}

end

do abm_nw\_chks.mata
do abm_nw\_pars.mata
do abm_nw\_setup.mata
do abm_nw\_change_nw.mata
do abm_nw\_create_nw.mata
do abm_nw\_return.mata
do abm_nw\_export.mata
