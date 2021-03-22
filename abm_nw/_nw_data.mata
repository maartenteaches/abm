mata:
mata set matastrict on
class nw_data extends abm_chk
{
    protected:
		real                   vector    N_edges
		real                   vector    N_nodes
		real                   scalar    maxnodes
		real                   scalar    tdim
		real                   scalar    directed
		real                   scalar    weighted
   		real                   scalar    randomit
		real                   scalar    nw_set
		real                   scalar    setup
		real                   vector    frozen
		real                   scalar    prepared
		
		class AssociativeArray scalar    network
		pointer(real vector)   matrix    adjlist
		pointer(real vector)   vector    nodes
		pointer(real vector)   vector    dropped_nodes

		// _data_chks.mata
		void                             is_frozen()
		void                             is_setup()
		void                             is_symmetric() 

		// _data_setup.mata
		void                             new()
		void                             prepare()

		// _data_change.mata
		void                             copy_adjlist()

    public:
		// _data_pars.mata
   		transmorphic                     N_nodes()
		transmorphic                     tdim()
		transmorphic                     directed()
		transmorphic                     randomit()
		transmorphic                     weighted()  
		transmorphic                     nw_set()

		// _data_setup.mata        
		void                             setup()
       	void                             clear() 

		// _data_change.mata
		void                             add_edge()
		void                             add_node()
		void                             return_node()
		void                             remove_edge()
		void                             change_weight()
		void                             rewire()
		void                             remove_node() 
		void                             copy_nodes()   
		void                             copy_nw() 
        
		// _data_return.mata
        real                   scalar    N_edges()
		real                   rowvector neighbours()
		real                   scalar    weight()
		void                             no_edge()
		real                   scalar    edge_exists()
		real                   vector    schedule()
		real                   vector    nodes()
		real                   scalar    maxnodes()
		
		// _data_export.mata
		real                   matrix    export_adjmat()
		real                   matrix    export_edgelist()               
}
end

do abm_nw\_data_chks.mata
do abm_nw\_data_pars.mata
do abm_nw\_data_setup.mata
do abm_nw\_data_change.mata
do abm_nw\_data_return.mata
do abm_nw\_data_export.mata