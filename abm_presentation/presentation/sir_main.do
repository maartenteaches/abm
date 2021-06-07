version 16.1

mata:

mata set matastrict on

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
	
	// sir_chks.do
	void                          isid()
	void                          istime()
	
	// sir_set_pars.do
	transmorphic                  N()
	transmorphic                  tdim()
	transmorphic                  outbreak()
	transmorphic                  removed()
	transmorphic                  mcontacts()
	transmorphic                  transmissibility()
	transmorphic                  mindur()
	transmorphic                  meandur()
	transmorphic                  pr_loss()

	// sir_sim.do
	void                          setup()
	real                   matrix meet()
	real                   scalar infect()
	void                          progress()
	void                          step()
	void                          run()
	
	// sir_export.do
	void                          export_sir()
	void                          export_r()
}
end 

do sir_chks.do
do sir_set_pars.do
do sir_sim.do
do sir_export.do

exit
