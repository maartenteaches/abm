mata:
mata set matastrict on
class abm_bc 
{
    protected:
        real          rowvector vnr

    public: 
        transmorphic            vnr()
        real          scalar    lessthan_version()
}

transmorphic abm_bc::vnr(| string scalar valstr)
{
	real rowvector val

    if (args() == 1) {
		val = strtoreal(tokens(valstr,"."))
		if (cols(val) == 1 | (cols(val) == 2 & val[2]==.)) {
			val = val, 0, 0
		} 
		else if (cols(val) == 3 | (cols(val) == 4 & val[4] == .)) {
			if (val[2]!= .) _error("format of version nr is #.#.#")
			val = val[1], val[3], 0
		}
		else if (cols(val) == 5) {
			if (val[2]!=. & val[4]!= .) _error("format of version nr is #.#.#")
			val = val[1], val[3], val[5]
		}
		else if (cols(val) > 5) {
			_error("version has only 3 levels")
		}
		val
		if (anyof(val,.)) {
			_error("version cannot contain missing values")
		}
		if (any(val:< 0) | any(floor(val):!=val)) {
			_error("version levels must be positive integers")
		}
		
		vnr = val
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
		if (vnr[i] > tocheck[i]) {
			break
		}
	    if (vnr[i] < tocheck[i]) {
		    res = 1
			break
		}
	}
	return(res)
}

end