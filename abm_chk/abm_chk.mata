mata:
mata set matastrict on

class abm_chk extends abm_bc
{
    protected:
   		void                             is_posint()
		void                             is_bool()
		void                             is_pr()
}

void abm_chk::is_bool(real scalar val)
{
	string scalar errmsg
	
	if (val != 1 & val != 0) {
		errmsg = "argument can only be 0 or 1"
		_error(3300, errmsg)
	}
}

void abm_chk::is_posint(real scalar val, | string scalar zero_ok) 
{
	string scalar errmsg
	
	if (args() == 1) {
		if (val <= 0 | ceil(val)!= val ){
			errmsg = "argument must be a positive integer"
			_error(3300, errmsg)
		}
	}
	else {
		if (val < 0 | ceil(val)!= val){
			errmsg = "argument must be zero or a positive integer"
			_error(3300, errmsg)
		}
	}
}

void abm_chk::is_pr(real scalar val)
{
	if (val < 0 | val > 1) {
		_error(3300,"argument is not a valid probability")
	}
}

end