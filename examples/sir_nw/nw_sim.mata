include examples/sir_nw/nw_locals.mata

mata:

void sir_nw::run()
{
	real scalar i, t
	setup()

	dots(0)
	dots(1)

	for (t=2; t<=tdim; t++) {
		dots(t)
		for(i=1; i<=N ; i++) {
			step(i,t)
		}
	}
}

void sir_nw::setup()
{
	real vector id, key
	real scalar i
	
	if (N==.)                   _error("N has not been set")
	if (tdim==.)                _error("tdim has not been set")
	if (outbreak==.)            _error("outbreak has not been set")
	if (outbreak > N)           _error("the initial outbreak is larger than population")
	if (removed==.)             removed = 0
	if (removed + outbreak > N) _error("intial outbreak + removed agents is larger than the population")
	if (transmissibility==.)    _error("transmissibility has not been set")
	if (mindur==.)              _error("mindur has not been specified")
	if (meandur==.)             _error("meandur has not been specified")
	if (meandur <= mindur)      _error("meandur must be larger than mindur")
	if (pr_loss==.)             pr_loss = 0
	if (degree==.)              _error("degree has not been specified")  // <-- new
	if (pr_long==.)             _error("pr_long has not been specified") // <-- new
	
	nw.clear()                                                           // <-- new   
	nw.N_nodes(0,N)                                                      // <-- new
	nw.directed(0)                                                       // <-- new
	nw.tdim(0)                                                           // <-- new
	nw.sw(degree,pr_long)                                                // <-- new    
	nw.setup()                                                           // <-- new
	
	agents.N(N)
	agents.k(4)
	agents.setup()
	
	id = jumble((1..N)')
	
	for (i = 1; i<= N; i++) {
		key = id[i],`state',1
		agents.put(key,(i<=outbreak ? `infectious' : (i <= outbreak+removed ? `removed' : `susceptible')))
		key[2] = `exposes'
		if (i <= outbreak) agents.put(key, J(2,0,.) )
		
		key[2] = `dur'
		agents.put(key,1)
	}

	
// if meandur - mindur < 1 then pr_heal > 1, so there is no randomness to the duration
// and the fixed duration of the disease is mindur	
	pr_heal = 1/(meandur-mindur)
}

void sir_nw::step(real scalar id, real scalar t)
{
	real matrix exposed
	real scalar i, k
	real rowvector key
	
	isid(id)
	istime(t)

	key = id, `dur',t

	agents.put(key, agents.get(key, "last")+1)
	progress(id,t)
	key = id, `state',t
	if (agents.get(key, "last") == `infectious' ) {
		exposed = nw.neighbours(id)                        // <-- new
		exposed = exposed \ J(1,cols(exposed),.)           // <-- new
		for(i=1; i<= cols(exposed); i++) {
			exposed[2,i] = infect(exposed[1,i],t) 
		}
		key[2] = `exposes'
		agents.put(key,exposed)
	}
}

void sir_nw::progress(real scalar id, real scalar t)
{
    real rowvector key1, key2, key3
	
	isid(id)
	istime(t)
	
	key1 = id, `state',t
	key2 = id, `dur',t
	if (agents.get(key1, "last") == `infectious'  & agents.get(key2, "last") > mindur) {
		if (runiform(1,1) < pr_heal) {
			agents.put(key1, `removed')
			agents.put(key2,1)
			key3 = id, `exposes',t
			//agents.put(key3,NULL)
		}
	}
    if (agents.get(key1, "last") == `removed' & runiform(1,1) < pr_loss) {
		agents.put(key1, `susceptible')
		agents.put(key2,1)
	}
}

real scalar sir_nw::infect(real scalar id, real scalar t)
{
	real vector key
	real scalar infected

	isid(id)
	istime(t)

	infected = 0
	key = id,`state', t
	if (agents.get(key, "last")==`susceptible') {
		if (runiform(1,1) < transmissibility) {
			agents.put(key, `infectious')
			key[2] = `dur'
			agents.put(key, 1)
			key[2] = `exposes'
			agents.put(key,J(2,0,.))
			infected = 1
		}
	}
	return(infected)
}

void sir_nw::dots(real scalar t) 
{
	if (t==0) {
		printf("----+--- 1 ---+--- 2 ---+--- 3 ---+--- 4 ---+--- 5\n")
	}
	else if (mod(t, 50) == 0) {
		printf(". %9.0f\n", t)
	}
	else {
		printf(".")
	}
	displayflush()
}
end
