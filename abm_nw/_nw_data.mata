mata:
mata set matastrict on
class nw_data
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
   		real                   scalar    randomit
		real                   scalar    nodes_set
		real                   scalar    nw_set
		real                   scalar    setup
		real                   vector    frozen
		
		class AssociativeArray scalar    network
		pointer(real vector)   vector    adjlist0
		pointer(real vector)   matrix    adjlist
		real                   vector    nodes0
		pointer(real vector)   vector    nodes
		pointer(real vector)   vector    dropped_nodes
		real                   vector    dropped_nodes0

 		void                             is_frozen()
		void                             is_setup()
		void                             is_nodesset()
		void                             is_symmetric() 

		void                             new()

    public:
   		transmorphic                     N_nodes()
		transmorphic                     tdim()
		transmorphic                     directed()
		transmorphic                     randomit()
		transmorphic                     weighted()  
		transmorphic                     randomit()            
		void                             setup()
       	void                             clear() 
		void                             add_edge()
		void                             add_node()
		void                             return_node()
		void                             remove_edge()
		void                             change_weight()
		void                             remove_node()     
        
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
