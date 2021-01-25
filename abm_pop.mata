include current_version

mata:
mata set matastrict on

class abm_pop extends abm_bc
{
	protected: 
		pointer (pointer matrix) matrix pop
		real                     scalar N
		real                     scalar k
		real                     scalar get_t()
		transmorphic                    get_c()

	public: 
		transmorphic                    N()
		transmorphic                    k()
		void                            setup()
		transmorphic                    get()
		void                            put()
		void                            add()
		pointer                  matrix extract()
}

real scalar abm_pop::get_t(real scalar row, real scalar col, real scalar i)
{
	 return(*((*pop[row,col])[2,i]))
}

transmorphic abm_pop::get_c(real scalar row, real scalar col, real scalar i)
{
	return(*((*pop[row,col])[1,i]))
}
transmorphic abm_pop::N(|real scalar val) 
{
	if (args()>0) {
		if (val<=0 | ceil(val)!=val) {
			_error("argument must be a positive integer")
		}
		N=val
	}
	else {
		return(N)
	}
}

transmorphic abm_pop::k(|real scalar val) 
{
	if (args()>0) {
		if (val<=0 | ceil(val) != val ) {
			_error("argument must be a positive integer")
		}
		k=val
	}
	else {
		return(k)
	}
}


void abm_pop::setup()
{
	if (N==.)    _error("N has not been set")
	if (k==.)    k=1
	if (mod_version == J(1,0,.)) mod_version = `current'
	pop = J(N,k,NULL)
}

void abm_pop::add(real scalar toadd)
{
    pointer matrix add
	
	if (floor(toadd) != toadd) _error("argument is not an integer") 
	
    N = N + toadd
	add = J(toadd,k,NULL)
	pop = pop \ add
}

void abm_pop::put(real rowvector key, transmorphic content)
{
	transmorphic c
	real scalar t, row, col
	
	c   = content
	t   = key[3]
	row = key[1]
	col = key[2]

	if (t<=0 | t != ceil(t)) {
		_error("t must be a positive integer")
	}	
	if (pop[row,col] == NULL) {
		pop[row, col] = &(&c \ &t)
	}
	else if (*((*pop[row,col])[2,1])<=t) {
		pop[row,col] = &((&c\&t),*pop[row,col])
	}
	else {
		_error("t is already used")
	}
	
}

transmorphic abm_pop::get(real rowvector key, | string scalar how)
{
	real scalar cols, i, t, u, l, m, row, col

	row = key[1]
	col = key[2]
	t = (cols(key)==3 ? key[3] : .)
	if (t==. & how != "first") how = "last"
	if (t==1 & how != "last")  how = "forwards"

	if (pop[row,col] == NULL) return

	cols = cols(*pop[row,col])
	if (how == "last") {
	    if(t < get_t(row,col,1) ) _error("t is not the last time")
		return( get_c(row,col,1) )
	}	
	else if (get_t(row,col,cols) > t) { // before the first time that char for that agent was specified
		return
	}
	else if (how == "first") {
	    if (cols >= 2 & t != .) {
		    if(t >= get_t(row,col,cols-1)) _error("t is not the first time")
		}
		return( get_c(row,col,cols) )
	}	
	else if (how == "backwards") {
		for (i=1; i<= cols; i++) {
			if( get_t(row,col,i) <= t ) {
				return( get_c(row,col,i)  )
			}
		}		
	}
	else if (how == "forwards") {
		for (i=cols; i>= 1; i--) {
			if( get_t(row,col,i) > t ) {
				return( get_c(row,col,i+1) )
			}
		}
		return(get_c(row,col,1))
	}
	else if (how == "binary" | how == "") {
		u = cols
		l = 1
		while (l < u) {
			m = floor((l+u)/2)
			if (get_t(row,col,m) > t) {
				l=m+1
			}
			else {
				u=m
			}
		}
		return(get_c(row,col,l))
	}
	else {
	    _error("method " + how + " not allowed")
	}
}

pointer matrix abm_pop::extract(real scalar c, real scalar tmax)
{
	pointer matrix res, raw
	real scalar i, j, current
	
	if (floor(tmax) != tmax) _error("argument is not an integer")
	
	res = J(N,tmax, NULL)

	for(i=1; i<=N; i++) {
		raw = (pop[i,c]==NULL ? NULL : *pop[i,c] )
		current = cols(raw)
		for(j=1; j<=tmax; j++) {
			if (current > 1) {
				if (*raw[2,current-1] <= j) {
					current = current-1
				} 
			}
			res[i,j] = raw[1,current]
		}	
	}
	return(res)
}

end

