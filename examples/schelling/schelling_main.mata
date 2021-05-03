version 16.1
cd "d:\mijn documenten\projecten\stata\abm\abm"

mata:
mata set matastrict on
class schelling extends abm_util {
		class abm_grid  scalar    universe
		string          colvector agents

		real            scalar    rdim
		real            scalar    cdim
		real            scalar    tdim
		real            scalar    limit
		real            scalar    nblue
		real            scalar    nred
		real            scalar    nagents

		// initialize the model
		void                      setup_agents()
		void                      setup_universe()		
		void                      populate_universe()

		// schelling_sim.mata
		string          scalar    get_color()
		real            scalar    sum_neighbours()	// proportion of same color in neighbourhood
		real            scalar    is_happy()        // is that proportion larger than limit 
		void                      move()		    // search for nearest empty spot where agent would be happy
		void                      step()	        // a single step by a single agent
		void                      run()
		
		// set or return settings
		transmorphic              rdim()
		transmorphic              cdim()
		transmorphic              tdim()
		transmorphic              limit()
		transmorphic              nblue()
		transmorphic              nred()
		
		
		// schelling_export.mata
		real matrix               summ()
		void                      summtable()
		void                      extract()
}

// -------------------------------------------------------------- return results

end

do examples/schelling/schelling_export.mata
do examples/schelling/schelling_sim.mata
do examples/schelling/schelling_pars.mata

