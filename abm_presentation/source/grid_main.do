version 16.1

mata:

mata set matastrict on

class sir_grid extends abm_util {                 // <-- new
    class sir              matrix town
    class abm_grid         scalar grid
    
    real                   scalar rdim
    real                   scalar cdim
    real                   scalar prop_close
    real                   scalar prop_medium
    real                   scalar prop_far    
    
	real                   scalar tdim
	real                   scalar outbreak
	real                   scalar removed
	real                   scalar mcontacts
	real                   scalar N
	real                   scalar transmissibility
	real                   scalar mindur
	real                   scalar meandur
	real                   scalar pr_heal
	real                   scalar pr_loss    

    // grid_set_pars.do
	transmorphic                  N()
    transmorphic                  rdim()
    transmorphic                  cdim()
	transmorphic                  tdim()
	transmorphic                  outbreak()
	transmorphic                  removed()
	transmorphic                  mcontacts()
	transmorphic                  transmissibility()
	transmorphic                  mindur()
	transmorphic                  meandur()
	transmorphic                  pr_loss()  
    transmorphic                  prop_close()
    transmorphic                  prop_medium()
    transmorphic                  prop_far()
    
    // grid_chks.do
    void                          is_valid_address()
    
    // grid_sim.do
    void                          setup()
    void                          run()
    void                          travel()
    void                          travel_contact()
    
    // grid_export
    void                          export_sir()
}

class sir extends abm_util {
	class abm_pop          scalar agents
	
	real                   scalar tdim         
	real                   scalar outbreak
	real                   scalar removed
	real                   scalar mcontacts
	real                   scalar N
	real                   scalar transmissibility
	real                   scalar mindur
	real                   scalar meandur
	real                   scalar pr_heal
	real                   scalar pr_loss
    real                   scalar vil_id
	
	// grid_chks.do
	void                          isid()
	void                          istime()
	
	// gird_sir_set_pars.do
	transmorphic                  N()
	transmorphic                  tdim()        
	transmorphic                  outbreak()
	transmorphic                  removed()
	transmorphic                  mcontacts()
	transmorphic                  transmissibility()
	transmorphic                  mindur()
	transmorphic                  meandur()
	transmorphic                  pr_loss()
    transmorphic                  vil_id()     // <-- new

	// grid_sir_sim.do
	void                          setup()
	real                   matrix meet()
	real                   scalar infect()
	void                          progress()
	void                          step()
    void                          run()         
    real                   scalar state()    // <-- new
	
	// grid_export.do
	real matrix                   export_sir()
}
end 

do grid_chks.do
do grid_set_pars.do
do grid_sir_set_pars.do
do grid_sir_sim.do
do grid_sim.do
do grid_export.do

exit
