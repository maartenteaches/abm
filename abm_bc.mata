clear all

mata:
mata set matastrict on
class abm_bc 
{
    protected:
        real          rowvector vnr

    public: 
        transmorphic            version()
        real          scalar    lessthan_version()
}

transmorphic abm_bc::version(string scalar val)
{
    if (args() == 1) {
		val = strtoreal(tokens(val,"."))
		if (cols(val) == 1 ) {
			val = val, 0, 0
		} 
		else if (cols(val) == 2) {
			val = val, 0
		}
		else if (cols(val) > 3) {
			_error("version has only 3 levels")
		}
		if (anyof(val,.)) {
			_error("version cannot contain missing values")
		}
		if (any(val:< 0)) {
			_error("version levels must be positive")
		}
		if (any(floor(val):!=val)) {
		    _error("version levels must be integers")
		}
		
		vnr = val
		setup   = 0
	}
	else {
		return(vnr)
	}
}

real scalar abm_bc::lessthan_version(real rowvector tocheck) 
{
    real scalar i, res
	
	if (cols(tocheck)!= 3 | anyof(tocheck,.) | any(tocheck:<0) | any(floor(tocheck):!=tocheck)) {
	  _error("version to be checked invalid")  
	} 
	
	res = 0
	for (i=1; i<=3 ; i++) {
	    if (vnr[i] < tocheck[i]) {
		    res = 1
			break
		}
	}
	return(res)
}

end