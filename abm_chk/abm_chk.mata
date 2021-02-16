mata:
mata set matastrict on

class abm_chk extends abm_bc
{
    protected:
   		void                             is_posint()
		void                             is_int()
		void                             is_bool()
		void                             is_pr()
}

void abm_chk::is_bool(real matrix val)
{
	string scalar errmsg
	
	if (any((val :!= 1) :& (val :!= 0))) {
		errmsg = "argument can only contain 0 or 1"
		_error(3300, errmsg)
	}
}

void abm_chk::is_int(real matrix val)
{
	if (ceil(val)!=val) {
		_error(3300,"argument must contain all integers")
	}
}

void abm_chk::is_posint(real matrix val, | string scalar zero_ok) 
{
	string scalar errmsg
	
	is_int(val)

	if (args() == 1) {
		if (any(val :<= 0 )){
			errmsg = "argument must contain all positive integers"
			_error(3300, errmsg)
		}
	}
	else {
		if (any(val :< 0) ){
			errmsg = "argument must contain all zero or positive integers"
			_error(3300, errmsg)
		}
	}
}

void abm_chk::is_pr(real matrix val)
{
	if (any((val :< 0) :| (val :> 1))) {
		_error(3300,"argument must contain all valid probabilities")
	}
}

end