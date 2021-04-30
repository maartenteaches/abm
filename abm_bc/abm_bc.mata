// class to manage backwards compatability

// set current version
local current (0,1,2)

mata:
mata set matastrict on
class abm_bc 
{
    protected:
        real          rowvector mod_version
		
		real          rowvector parse_version()
		void                    valid_version()
		void                    bc_setup()
		real          scalar    mod_leq()
        real          scalar    mod_lt()
		real          scalar    mod_geq()
		real          scalar    mod_gt()

    public: 
        transmorphic            abm_version()
		real          rowvector abm_current()
}

real rowvector abm_bc::abm_current()
{
	return(`current')
}

void abm_bc::bc_setup()
{
	if (mod_version == J(1,0,.)) {
		mod_version = `current'
	}
}

real rowvector abm_bc::parse_version(string scalar valstr)
{
	real scalar l, i, j
	real rowvector v
	string scalar part, errmsg
	string rowvector res, nr

	res = "", J(1,2,"0")
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
	v = strtoreal(res)
	if (mod_lt(v,"max")) {  // current < version specified
		errmsg = strofreal(`current'[1]) + "." +
		         strofreal(`current'[2]) + "." + 
				 strofreal(`current'[3])
		errmsg = "this is version " + errmsg + " of ABM"
		_error(errmsg)
	}
	return(v)
}

transmorphic abm_bc::abm_version(| string scalar val)
{
    if (args() == 1) {
		mod_version = parse_version(val)
	}
	else {
		return(mod_version)
	}
}

void abm_bc::valid_version(real rowvector tocheck)
{
	if (cols(tocheck)!= 3 | anyof(tocheck,.) | any(tocheck:<0) | any(floor(tocheck):!=tocheck)) {
	  _error("version to be checked invalid")  
	} 
}

real scalar abm_bc::mod_lt(real rowvector tocheck, | string scalar max) 
{
    real scalar i, res
	real rowvector against
	
	valid_version(tocheck)
	
	if (args()==1) {
		against = mod_version
	}
	else {
		against = `current'
	}

	res = 0
	for (i=1; i<=3 ; i++) {
		if (against[i] > tocheck[i]) {
			break
		}
	    if (against[i] < tocheck[i]) {
		    res = 1
			break
		}
	}
	return(res)
}

real scalar abm_bc::mod_leq(real rowvector tocheck) 
{
    real scalar i, res
	
	valid_version(tocheck)
	
	if (tocheck==mod_version) return(1)
	return(mod_lt(tocheck))
}

real scalar abm_bc::mod_geq(real rowvector tocheck) 
{
    real scalar i, res
	
	valid_version(tocheck)
	
	if (tocheck==mod_version) return(1)
	return(mod_gt(tocheck))
}

real scalar abm_bc::mod_gt(real rowvector tocheck) 
{
    real scalar i, res

	valid_version(tocheck)
	
	res = 0
	for (i=1; i<=3 ; i++) {
		if (mod_version[i] > tocheck[i]) {
			res = 1
			break
		}
	    if (mod_version[i] < tocheck[i]) {
			break
		}
	}
	return(res)
}

end