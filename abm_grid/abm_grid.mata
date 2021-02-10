version 16.1

mata :
mata set matastrict on

class abm_grid extends abm_chk
{
	protected:
		class AssociativeArray scalar universe 
		class AssociativeArray scalar baserings
		
		real scalar    rdim
		real scalar    cdim
		real scalar    tdim
		real scalar    idim
		real scalar    neumann
		real scalar    torus
		real scalar    randit 
		real matrix    basecoords 
		real scalar    size	
		real scalar    setup
		
		// _setup.mata
		void           is_setup()
		void           is_valid_cell()
		void           new()

		// _neighbours.mata
		void           baserings()
		real matrix    basering()
		real matrix    neumannring()
		real matrix    moorering()
		real colvector out_of_bounds()
		real matrix    torus_adj()

		// _schedule.mata 
		void           basecoords() 
	
		// _agents.mata
		real rowvector make_key()
		real rowvector agent_loc()

		// _line.mata
		real matrix    comp_line()
		real matrix    torus_closest()
		real rowvector lerp()		
		
	
	public:
		// _settings.mata
		transmorphic   rdim()
		transmorphic   cdim()
		transmorphic   tdim()
		transmorphic   idim()
		real scalar    size()
		transmorphic   neumann()
		transmorphic   torus()
		transmorphic   randit() 

		// _setup.mata
		void           setup()

		// _neighbours.mata
		real matrix    find_ring()
		real matrix    find_spiral()

		// _agents.mata
		real scalar    agent_id() 
		real rowvector agent_ids()
		real scalar    free_spot()
		real scalar    has_agent()
		void           copy_agent()  
		void           copy_agents() 
		void           copy_grid()
		void           move_agent()
		void           move_agents()
		void           delete_agent() 
		void           delete_agents()
		void           create_agent()

		// _schedule.mata
		real matrix    schedule() 
		real matrix    random_cell() 

		// _line.mata
		real scalar    dist()
		real matrix    find_line()

		// _export.mata
		real matrix    extract()
		
}

end

do abm_grid\_settings.mata
do abm_grid\_setup.mata
do abm_grid\_neighbours.mata
do abm_grid\_agents.mata
do abm_grid\_schedule.mata
do abm_grid\_line.mata
do abm_grid\_export.mata
