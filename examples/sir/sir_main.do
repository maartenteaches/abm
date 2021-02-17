version 16.1
cd "c:\mijn documenten\projecten\abm\abm"

mata:

mata set matastrict on

class sir extends abm_chk {
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
	void                          is_id()
	void                          is_time()
	
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
	void                          dots()
	
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
