mata:
mata set matastrict on
class abm_bc 
{
    protected:
        real          rowvector vnr
		real          rowvector parse_vnr()

    public: 
        transmorphic            vnr()
        real          scalar    lessthan_version()
}

real rowvector abm_bc::parse_vnr(string scalar valstr)
{
	real scalar l, i, j
	string scalar part
	string rowvector res, nr

	res = J(1,3,"0")
	l = ustrlen(valstr)
	j=1
	nr = "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
	
	for(i=1; i<=l; i++) {
		part = usubstr(valstr,i,1)
		if (anyof(nr,part)) {
			res[j] = res[j]+part
		}
		else if (part == " ") {
			// do nothing; i.e. ignore spaces
		}
		else if (part == "." ) {
			if (i!=l) {
				j=j+1
				if (j>3) {
					_error("format for version number is #.#.#")
				}
				res[j]=""
			}
		}
		else {
			_error("format for version number is #.#.#")
		}
	}
	return(strtoreal(res))
}

transmorphic abm_bc::vnr(| string scalar val)
{
    if (args() == 1) {
		vnr = parse_vnr(val)
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