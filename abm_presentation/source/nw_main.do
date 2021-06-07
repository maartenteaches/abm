version 16.1

mata:

mata set matastrict on

class sir_nw extends abm_util {
	class abm_pop          scalar agents
	class abm_nw           scalar nw                     // <-- new
	
	real                   scalar tdim
	real                   scalar outbreak
	real                   scalar removed
//	real                   scalar mcontacts              // <-- no longer necessary
	real                   scalar N
	real                   scalar transmissibility
	real                   scalar mindur
	real                   scalar meandur
	real                   scalar pr_heal
	real                   scalar pr_loss
	real                   scalar degree                 // <-- new
	real                   scalar pr_long                // <-- new
	
	// sir_chks.do
	void                          isid()
	void                          istime()
	
	// sir_set_pars.do
	transmorphic                  N()
	transmorphic                  tdim()
	transmorphic                  outbreak()
	transmorphic                  removed()
//	transmorphic                  mcontacts()           // <-- no longer necessary
	transmorphic                  transmissibility()
	transmorphic                  mindur()
	transmorphic                  meandur()
	transmorphic                  pr_loss()
	transmorphic                  degree()              // <-- new
	transmorphic                  pr_long()             // <-- new

	// sir_sim.do
	void                          setup()
//	real                   matrix meet()                // <-- no longer necessary
	real                   scalar infect()
	void                          progress()
	void                          step()
	void                          run()
	
	// sir_export.do
	void                          export_sir()
	void                          export_r()
	void                          export_nw()          // <-- new
}
end 

do nw_chks.do
do nw_set_pars.do
do nw_sim.do
do nw_export.do

exit
