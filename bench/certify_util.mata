mata:
mata set matastrict on

class foo extends abm_util
{
    void run()
}
void foo::run()
{
    real scalar i
    dots(0)
    for(i=1;i<=102;i++) {
        dots(i)
    }
}

bar = foo()
bar.run()
end