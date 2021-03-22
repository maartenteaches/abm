version 16.1

mata:

mata set matastrict on

class abm_nw extends abm_chk
{
	protected: 
		class nw_data          scalar    network
				
		// _chks.mata
		void                             is_valid_id()
		void                             is_valid_time()
		real                   scalar    parse_t()

		// _setup.mata
		void                             new()

		// _change_nw.mata
		void                            copy_nodes()
		void                            copy_adjlist()
	
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

do abm_nw\_nw_data.mata
do abm_nw\_chks.mata
do abm_nw\_pars.mata
do abm_nw\_setup.mata
do abm_nw\_change_nw.mata
do abm_nw\_create_nw.mata
do abm_nw\_return.mata
do abm_nw\_export.mata
