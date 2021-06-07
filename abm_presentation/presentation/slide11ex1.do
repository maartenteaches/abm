clear mata

mata:

class arithmatic {

    real scalar a
    real scalar b
    
    real scalar sum()
    real scalar prod()
    void input()
    void run()
}

void arithmatic::input(real scalar aval, real scalar bval)
{
    a = aval
    b = bval
}

real scalar arithmatic::sum()
{
    return(a + b)
}

real scalar arithmatic::prod()
{
    return(a * b)
}

void arithmatic::run()
{
    sum()
    prod()
}

// how the user interacts with this program
math = arithmatic()
math.input(2,4)
math.run()
end
