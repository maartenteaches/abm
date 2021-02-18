version 16.1
cd "d:\mijn documenten\projecten\stata\abm\abm"

mata:

mata set matastrict on

class sir_nw extends abm_chk {
	class abm_pop          scalar agents
	class abm_nw           scalar nw                     
	
	real                   scalar tdim
	real                   scalar outbreak
	real                   scalar removed
	real                   scalar N
	real                   scalar transmissibility
	real                   scalar mindur
	real                   scalar meandur
	real                   scalar pr_heal
	real                   scalar pr_loss
	real                   scalar degree                 
	real                   scalar pr_long                
	
	// sir_chks.do
	void                          is_id()
	void                          is_time()
	
	// sir_set_pars.do
	transmorphic                  N()
	transmorphic                  tdim()
	transmorphic                  outbreak()
	transmorphic                  removed()
	transmorphic                  transmissibility()
	transmorphic                  mindur()
	transmorphic                  meandur()
	transmorphic                  pr_loss()
	transmorphic                  degree()              
	transmorphic                  pr_long()             

	// sir_sim.do
	void                          setup()
	real                   scalar infect()
	void                          progress()
	void                          step()
	void                          run()
	void                          dots()
	
	// sir_export.do
	void                          export_sir()
	void                          export_r()
	void                          export_nw()          
}
end 

do examples/sir_nw/nw_chks.mata
do examples/sir_nw/nw_set_pars.mata
do examples/sir_nw/nw_sim.mata
do examples/sir_nw/nw_export.mata

exit
