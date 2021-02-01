cscript
cd "c:\Mijn documenten\projecten\stata\abm\abm"
do abm_bc.mata
do abm_chk.mata

mata:
class chk extends abm_chk {
    void chk_is_posint()
    void chk_is_bool()
    void chk_is_pr()
}

void chk::chk_is_posint(real scalar val, | string scalar zero_ok) {
    if (args()==1) {
        is_posint(val)
    }
    else {
        is_posint(val,zero_ok)
    }
}

void chk::chk_is_bool(real scalar val)
{
    is_bool(val)
}

void chk::chk_is_pr(real scalar val)
{
    is_pr(val)
}

foo = chk()
foo.chk_is_posint(3)
foo.chk_is_posint(0, "zero_ok")
end

rcof "mata foo.chk_is_posint(0)" == 3300
rcof "mata foo.chk_is_posint(-1)" == 3300
rcof "mata foo.chk_is_posint(1.5)" == 3300

mata:
foo.chk_is_bool(1)
foo.chk_is_bool(0)
end

rcof "mata foo.chk_is_bool(0.5)" == 3300
rcof "mata foo.chk_is_bool(2)" == 3300
rcof "mata foo.chk_is_bool(-1)" == 3300

mata:
foo.chk_is_pr(0)
foo.chk_is_pr(0.5)
foo.chk_is_pr(1)
end

rcof "mata foo.chk_is_pr(-1)" == 3300
rcof "mata foo.chk_is_pr(2)" == 3300
rcof "mata foo.chk_is_pr(1.00000005)" == 3300

