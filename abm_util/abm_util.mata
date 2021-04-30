mata:
mata set matastrict on

class abm_util extends abm_chk
{
    protected:
        void dots()
}

void abm_util::dots(real scalar t) 
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