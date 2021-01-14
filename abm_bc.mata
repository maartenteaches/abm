clear all

mata:
mata set matastrict on
class abm_bc 
{
    protected:
        real          rowvector version

    public: 
        transmorphic            version()
        real          scalar    lessthan_version()
}

end