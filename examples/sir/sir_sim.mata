include examples/sir/sir_locals.mata

mata:

void sir::run()
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

void sir::setup()
{
	real vector id, key
	real scalar i
	
	if (N==.)                   _error("N has not been set")
	if (tdim==.)                _error("tdim has not been set")
	if (outbreak==.)            _error("outbreak has not been set")
	if (outbreak > N)           _error("the initial outbreak is larger than population")
	if (removed==.)             removed = 0
	if (removed + outbreak > N) _error("intial outbreak + removed agents is larger than the population")
	if (mcontacts==.)           _error("mcontacts has not been set")
	if (mcontacts > N)          _error("average number of mcontacts is larger than population")
	if (transmissibility==.)    _error("transmissibility has not been set")
	if (mindur==.)              _error("mindur has not been specified")
	if (meandur==.)             _error("meandur has not been specified")
	if (meandur <= mindur)      _error("meandur must be larger than mindur")
	if (pr_loss==.)             pr_loss = 0
	
	agents.N(N)
	agents.k(3)
	agents.abm_version("0.1.4")
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

void sir::step(real scalar id, real scalar t)
{
	real matrix exposed
	real scalar i, k
	real rowvector key
	
	is_id(id)
	is_time(t)

	key = id, `dur',t

	agents.put(key, agents.get(key, "last")+1)
	progress(id,t)
	key = id, `state',t
	if (agents.get(key, "last") == `infectious' ) {
		exposed = meet(id, t)
		for(i=1; i<= cols(exposed); i++) {
			exposed[2,i] = infect(exposed[1,i],t) 
		}
		key[2] = `exposes'
		agents.put(key,exposed)
	}
}

void sir::progress(real scalar id, real scalar t)
{
    real rowvector key1, key2, key3
	
	is_id(id)
	is_time(t)
	
	key1 = id, `state',t
	key2 = id, `dur',t
	if (agents.get(key1, "last") == `infectious'  & agents.get(key2, "last") > mindur) {
		if (runiform(1,1) < pr_heal) {
			agents.put(key1, `removed')
			agents.put(key2,1)
			key3 = id, `exposes',t
			agents.put(key3,NULL)
		}
	}
    if (agents.get(key1, "last") == `removed' & runiform(1,1) < pr_loss) {
		agents.put(key1, `susceptible')
		agents.put(key2,1)
	}
}

real matrix sir::meet(real scalar id, real scalar t)
{
	real scalar k
	real colvector res
	real rowvector key

	is_id(id)
	
	k = rpoisson(1,1,mcontacts)
	if (k == 0) {
		return(J(2,0,.))
	}
	else{
		res =  ceil(runiform(1,k):*(N-1))
		res = res + (res:>=id)
		res = res \ J(1,k,.)
		return (res)
	}
}

real scalar sir::infect(real scalar id, real scalar t)
{
	real vector key
	real scalar infected

	is_id(id)
	is_time(t)

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

end
