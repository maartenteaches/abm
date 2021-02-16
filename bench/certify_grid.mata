mata:
class tests_abm_grid extends abm_grid
{
    void tests_new()
    void tests_setup()
    void tests_is_valid_cell()
    real scalar return_setup()
    void tests_basecoords()
    void tests_neumannring()
    void tests_moorering()
    void tests_baserings()
    void tests_basering()
    void tests_outofbounds()
    void tests_torus_adj()
    real matrix tests_torus_closest()
    real rowvector tests_make_key()
}

// ============================ _setup.mata
foo = tests_abm_grid()

// new() sets the abm_version to current
assert(foo.abm_version() == foo.abm_current())

foo.abm_version("0.5.1")
assert(foo.abm_version() == (0,5,1))

void tests_abm_grid::tests_new()
{
    assert(setup==0)
}
foo.tests_new()
end

rcof "mata: foo.setup()" == 3351

mata:
void tests_abm_grid::tests_is_valid_cell(real matrix tocheck)
{
    is_valid_cell(tocheck)
}
foo=tests_abm_grid()
foo.rdim(10)
foo.cdim(10)
foo.setup()
tocheck = 1,1 \ 
          2,4 \
          3,3 
foo.tests_is_valid_cell(tocheck)
end
rcof "mata: foo.tests_is_valid_cell((tocheck\(0,0)))" == 3498
rcof "mata: foo.tests_is_valid_cell((tocheck\(1,1.1)))" == 3300

mata:
foo.torus(1)
foo.setup()
tocheck = tocheck \
          0,0 \
          -1,-1\
          11,11
foo.tests_is_valid_cell(tocheck)
end
rcof "mata: foo.tests_is_valid_cell((tocheck\(1,1.1)))" == 3300

mata:
foo = tests_abm_grid()
foo.rdim(10)
foo.cdim(20)
assert(foo.rdim() == 10)
assert(foo.cdim() == 20)

// defaults for setup()
foo.setup()
assert(foo.tdim()     == 0)
assert(foo.idim()     == 1)
assert(foo.neumann()  == 0)
assert(foo.torus()    == 0)
assert(foo.randit()   == 0)
assert(foo.size()     == 200)

void tests_abm_grid::tests_setup()
{
    assert(universe.notfound()==J(1,0,.))
}
foo.tests_setup()

end

// ================================ _settings.mata
mata:
foo= tests_abm_grid()
end

rcof "mata: foo.rdim(-1)" == 3300
rcof "mata: foo.rdim(1.5)" == 3300
rcof "mata: foo.cdim(-1)" == 3300
rcof "mata: foo.cdim(1.5)" == 3300
rcof "mata: foo.idim(-1)" == 3300
rcof "mata: foo.idim(1.5)" == 3300
rcof "mata: foo.tdim(-1)" == 3300
rcof "mata: foo.tdim(1.5)" == 3300
rcof "mata: foo.torus(-1)" == 3300
rcof "mata: foo.torus(1.5)" == 3300
rcof "mata: foo.torus(2)" == 3300
rcof "mata: foo.neumann(-1)" == 3300
rcof "mata: foo.neumann(1.5)" == 3300
rcof "mata: foo.neumann(2)" == 3300
rcof "mata: foo.randit(-1)" == 3300
rcof "mata: foo.randit(1.5)" == 3300
rcof "mata: foo.randit(2)" == 3300


mata:

real scalar tests_abm_grid::return_setup()
{
    return(setup)
}

foo.rdim(5)
foo.cdim(10)
foo.idim(0)
foo.tdim(10)
foo.torus(1)
foo.neumann(1)
foo.randit(1)

assert(foo.rdim() == 5)
assert(foo.cdim() == 10)
assert(foo.idim() == 0)
assert(foo.tdim() == 10)
assert(foo.torus() == 1)
assert(foo.neumann() == 1)
assert(foo.randit() == 1)
assert(foo.return_setup()==0)
foo.setup() // setup does not overwrite set parameters
assert(foo.return_setup()==1)
assert(foo.rdim() == 5)
assert(foo.cdim() == 10)
assert(foo.idim() == 0)
assert(foo.tdim() == 10)
assert(foo.torus() == 1)
assert(foo.neumann() == 1)
assert(foo.randit() == 1)


assert(foo.return_setup()==1)
foo.rdim(5)
assert(foo.return_setup()==0)
foo.setup()
assert(foo.return_setup()==1)

foo.cdim(10)
assert(foo.return_setup()==0)
foo.setup()
assert(foo.return_setup()==1)

foo.idim(0)
assert(foo.return_setup()==0)
foo.setup()
assert(foo.return_setup()==1)

foo.tdim(10)
assert(foo.return_setup()==0)
foo.setup()
assert(foo.return_setup()==1)

foo.torus(1)
assert(foo.return_setup()==0)
foo.setup()
assert(foo.return_setup()==1)

foo.neumann(1)
assert(foo.return_setup()==0)
foo.setup()
assert(foo.return_setup()==1)

foo.randit(1)
assert(foo.return_setup()==0)
foo.setup()
assert(foo.return_setup()==1)

end

// ============================= tests _schedule
mata:
foo = tests_abm_grid()
foo.rdim(5)
foo.cdim(4)
foo.setup()

void tests_abm_grid::tests_basecoords()
{
    real matrix true

    true = 1,1 \
           1,2 \
           1,3 \
           1,4 \
           2,1 \
           2,2 \
           2,3 \
           2,4 \
           3,1 \
           3,2 \
           3,3 \
           3,4 \ 
           4,1 \
           4,2 \
           4,3 \
           4,4 \
           5,1 \
           5,2 \
           5,3 \
           5,4 
    assert(all(basecoords:==true))
}
foo.tests_basecoords()

bla = foo.random_cell(60)
assert(all(bla :<= (5,4)))
assert(all(bla :> 0))
assert(all(floor(bla) :== bla))
assert(rows(bla)==60)
assert(cols(bla)==2)
bla = foo.schedule()
assert(all(bla :<= (5,4)))
assert(all(bla :> 0))
assert(all(floor(bla) :== bla))
assert(rows(bla)==20)
assert(cols(bla)==2)
end

// ======================= test _neighbours.mata
mata:
foo = tests_abm_grid()

void tests_abm_grid::tests_neumannring()
{
    real matrix true

    true =  1, 0 \
            0, 1 \ 
           -1, 0 \
            0,-1

//    | -1  0  1
// ---+----------
// -1 |     3
//  0 |  4  x  2
//  1 |     1
    assert(all(neumannring(1):==true))

    true =  2, 0 \
            1, 1 \
            0, 2 \
           -1, 1 \
           -2, 0 \
           -1,-1 \
            0,-2 \
            1,-1
//    | -2 -1   0   1   2
// ---+-------------------
// -2 |         5 
// -1 |     6   .   4
//  0 |  7  .   x   .   3
//  1 |     6   .   2
//  2 |         1


    assert(all(neumannring(2)==true))
}
foo.tests_neumannring()

void tests_abm_grid::tests_moorering()
{
    real matrix true

    true =  1, 1\
            0, 1\
           -1, 1\
           -1, 0\
           -1,-1\
            0,-1\
            1,-1\
            1, 0
//    | -1  0  1
// ---+---------
// -1 |  5  4  2
//  0 |  6  x  2
//  1 |  7  8  1

    assert(all(moorering(1):==true))
    true =  2, 2\
            1, 2\
            0, 2\
           -1, 2\
           -2, 2\
           -2, 1\
           -2, 0\
           -2,-1\
           -2,-2\
           -1,-2\
            0,-2\
            1,-2\
            2,-2\
            2,-1\
            2, 0\
            2, 1
//     |  -2 -1  0  1  2
// ----+-----------------    
//  -2 |   9  8  7  6  5
//  -1 |  10  .  .  .  4
//   0 |  11  .  x  .  3
//   1 |  12  .  .  .  2
//   2 |  13  14 15 16 1  
    assert(all(moorering(2):==true))
}
foo.tests_moorering()

foo.rdim(5)
foo.cdim(5)
foo.neumann(0)

void tests_abm_grid::tests_baserings()
{
    real matrix true

    baserings()
    if (neumann==0) {
        true =  1, 1\
                0, 1\
            -1, 1\
            -1, 0\
            -1,-1\
                0,-1\
                1,-1\
                1, 0

        assert(all(baserings.get(1) :== true))

        true =  2, 2\
                1, 2\
                0, 2\
            -1, 2\
            -2, 2\
            -2, 1\
            -2, 0\
            -2,-1\
            -2,-2\
            -1,-2\
                0,-2\
                1,-2\
                2,-2\
                2,-1\
                2, 0\
                2, 1    
        assert(all(baserings.get(2):==true))
    }
    else {
        true =  1, 0 \
                0, 1 \ 
                -1, 0 \
                0,-1

        assert(all(baserings.get(1) :== true))

        true =  2, 0 \
                1, 1 \
                0, 2 \
                -1, 1 \
                -2, 0 \
                -1,-1 \
                0,-2 \
                1,-1

        assert(all(baserings.get(2):==true))        
    }
}
foo.tests_baserings()
foo.neumann(1)
foo.tests_baserings()

// basering()
foo = tests_abm_grid()
foo.rdim(5)
foo.cdim(5)
foo.neumann(0)
foo.setup()

void tests_abm_grid::tests_basering()
{
    real matrix true

    baserings()
    if (neumann==0) {
        true =  1, 1\
                0, 1\
            -1, 1\
            -1, 0\
            -1,-1\
                0,-1\
                1,-1\
                1, 0

        assert(all(basering(1) :== true))

        true =  2, 2\
                1, 2\
                0, 2\
            -1, 2\
            -2, 2\
            -2, 1\
            -2, 0\
            -2,-1\
            -2,-2\
            -1,-2\
                0,-2\
                1,-2\
                2,-2\
                2,-1\
                2, 0\
                2, 1    
        assert(all(basering(2):==true))
    }
    else {
        true =  1, 0 \
                0, 1 \ 
                -1, 0 \
                0,-1

        assert(all(basering(1) :== true))

        true =  2, 0 \
                1, 1 \
                0, 2 \
                -1, 1 \
                -2, 0 \
                -1,-1 \
                0,-2 \
                1,-1

        assert(all(basering(2):==true))        
    }
}

foo.tests_basering()
foo.neumann(1)
foo.setup()
foo.tests_basering()

// out_of_bounds()
foo= tests_abm_grid()
foo.rdim(5)
foo.cdim(5)
foo.setup()
void tests_abm_grid::tests_outofbounds()
{
    real scalar r,c
    for(r=1; r<=5;r++) {
        for(c=1; c<=5;c++) {
            assert(out_of_bounds((r,c))==0)
        }
    }
    assert(out_of_bounds((-1,1))==1)
    assert(out_of_bounds((0,0))==1)
    assert(out_of_bounds((6,1))==1)
    assert(out_of_bounds((1,6))==1)
    assert(out_of_bounds((6,6))==1)
}
foo.tests_outofbounds()

// torus_adj()
foo= tests_abm_grid()
foo.rdim(5)
foo.cdim(5)
foo.torus(1)
foo.setup()

void tests_abm_grid::tests_torus_adj()
{
    real matrix totest, true

    totest = 0, 1 \
             1, 1 \
             6, 5 \
             5, 6 \
             6, 6
    true   = 5, 1 \
             1, 1 \
             1, 5 \
             5, 1 \
             1, 1

    assert(torus_adj(totest)==true)
}
foo.tests_torus_adj()

// find_ring()

foo=abm_grid()
foo.rdim(10)
foo.cdim(10)
foo.torus(0)
foo.setup()

true = 2,2 \
       1,2 \
       2,1
//   | 1  2 
// --+-----
// 1 | x  2
// 2 | 8  1

assert(foo.find_ring(1,1,1)==true)
true = 
  6 ,  6  \
  5 ,  6  \
  4 ,  6  \
  3 ,  6  \
  2 ,  6  \
  2 ,  5  \
  2 ,  4  \
  2 ,  3  \
  2,   2  \
    3 ,  2  \
    4 ,  2  \
    5 ,  2  \
    6 ,  2  \
    6 ,  3  \
    6 ,  4  \
    6 ,  5  

//   | 2  3  4  5  6 
// --+---------------
// 2 | 9  8  7  6  5
// 3 |10           4
// 4 |11     x     3
// 5 |12           2
// 6 |13 14 15 16  1
assert(foo.find_ring(4,4,2)== true)

foo.torus(1)
foo.setup()

true = 2,2 \
       1,2 \
      10,2 \
      10,1 \
      10,10\
       1,10\
       2,10\
       2,1

//    | 1  2 .. 10
// ---+ x  2     6
// 1  | 8  1     7
// 2  |
// .. |
// 10 | 4  3     5
assert(foo.find_ring(1,1,1)==true)

true = 
  6 ,  6  \
  5 ,  6  \
  4 ,  6  \
  3 ,  6  \
  2 ,  6  \
  2 ,  5  \
  2 ,  4  \
  2 ,  3  \
  2,   2  \
    3 ,  2  \
    4 ,  2  \
    5 ,  2  \
    6 ,  2  \
    6 ,  3  \
    6 ,  4  \
    6 ,  5  

assert(foo.find_ring(4,4,2)== true)

foo.torus(0)
foo.neumann(1)
foo.setup()

true = 2,1 \
       1,2 
//   | 1  2 
// --+-----
// 1 | x  2
// 2 | 1  

assert(foo.find_ring(1,1,1)==true)

true = 6,4 \
       5,5 \
       4,6 \
       3,5 \
       2,4 \
       3,3 \
       4,2 \
       5,3
//   | 2  3  4  5  6 
// --+--------------
// 2 |       5
// 3 |    6     4
// 4 | 7     x     3
// 5 |    8     2
// 6 |       1 
assert(foo.find_ring(4,4,2)==true)

foo.torus(1)
foo.setup()
true = 2, 1 \
       1, 2 \
      10, 1 \
       1,10
//    | 1  2 .. 10
// ---+-----------
// 1  | x  2     4
// 2  | 1
// .. | 
// 10 | 3

assert(foo.find_ring(1,1,1)==true)

true = 6,4 \
       5,5 \
       4,6 \
       3,5 \
       2,4 \
       3,3 \
       4,2 \
       5,3
//   | 2  3  4  5  6 
// --+--------------
// 2 |       5
// 3 |    6     4
// 4 | 7     x     3
// 5 |    8     2
// 6 |       1 
assert(foo.find_ring(4,4,2)==true)

// find_spiral
foo.torus(0)
foo.neumann(0)
foo.setup()
true = 2,2 \
       1,2 \
       2,1
assert(foo.find_spiral(1,1,1)==true)
true = 5,5 \ 
       4,5 \
       3,5 \
       3,4\
       3,3\
       4,3\
       5,3\
       5,4\
       6,6\
       5,6\
       4,6\
       3,6\
       2,6\
       2,5\
       2,4\
       2,3\
       2,2\
       3,2\
       4,2\
       5,2\
       6,2\
       6,3\
       6,4\
       6,5
//   |  2  3  4  5  6
// --+---------------  
// 2 | 17 16 15 14 13
// 3 | 18  5  4  3 12
// 4 | 19  6  x  2 11
// 5 | 20  7  8  1 10
// 6 | 21 22 23 24  9

assert(foo.find_spiral(4,4,2)==true)

foo.torus(1)
foo.neumann(0)
foo.setup()
true = 2,2 \
       1,2 \
      10,2 \
      10,1 \
      10,10\
       1,10\
       2,10\
       2,1

assert(foo.find_spiral(1,1,1)==true)
true = 5,5 \ 
       4,5 \
       3,5 \
       3,4\
       3,3\
       4,3\
       5,3\
       5,4\
       6,6\
       5,6\
       4,6\
       3,6\
       2,6\
       2,5\
       2,4\
       2,3\
       2,2\
       3,2\
       4,2\
       5,2\
       6,2\
       6,3\
       6,4\
       6,5

assert(foo.find_spiral(4,4,2)==true)

foo.torus(0)
foo.neumann(1)
foo.setup()
true = 2,1\
       1,2
assert(foo.find_spiral(1,1,1)==true)

true = 5,4 \
       4,5 \
       3,4 \
       4,3 \
       6,4 \
       5,5 \ 
       4,6 \
       3,5 \
       2,4 \
       3,3 \ 
       4,2 \
       5,3
assert(foo.find_spiral(4,4,2) == true)

foo.torus(1)
foo.neumann(1)
foo.setup()
true = 2,1 \
       1,2 \
       10,1 \
       1, 10
assert(foo.find_spiral(1,1,1) == true)

true = 5,4 \
       4,5 \
       3,4 \
       4,3 \
       6,4 \
       5,5 \ 
       4,6 \
       3,5 \
       2,4 \
       3,3 \ 
       4,2 \
       5,3
assert(foo.find_spiral(4,4,2)==true)

end

// _line.mata
mata:
foo = abm_grid()
foo.rdim(10)
foo.cdim(10)
foo.setup()

//   | 1  2  3  4  5  6
// --+------------------
// 1 | 1  2  3
// 2 |          4  5  6      
assert(foo.dist((1,1),(2,6))==5) // there are 5 steps between the 6 cells

true = 1,1 \
       1,2 \
       1,3 \
       2,4 \
       2,5 \
       2,6
assert(foo.find_line((1,1),(2,6)) == true)

foo.neumann(1)
foo.setup()
//   | 1  2  3  4  5  6
// --+------------------
// 1 | 1  2  3
// 2 |       4  5  6  7   
true = 1,1 \
       1,2 \
       1,3 \
       2,3 \
       2,4 \
       2,5 \
       2,6
assert(foo.find_line((1,1),(2,6))==true)
assert(foo.dist((1,1),(2,6))==6)
 

foo.neumann(0)
foo.torus(1)
foo.setup()
//   | 1  2  3  4  5  6  7  8  9 10
// --+-----------------------------
// 1 | 1                          2
// 2 |                   5  4  3
true = 1,1 \
       1,10 \
       2,9 \
       2,8 \
       2,7

assert(foo.find_line((1,1),(2,7))==true)
assert(foo.dist((1,1),(2,7))==4)

foo.neumann(1)
foo.torus(1)
foo.setup()
//   | 1  2  3  4  5  6  7  8  9 10
// --+-----------------------------
// 1 | 1                       3  2
// 2 |                   6  5  4
true = 1,1 \
       1,10 \
       1,9 \
       2,9 \
       2,8 \
       2,7
assert(foo.find_line((1,1),(2,7))==true)
assert(foo.dist((1,1),(2,7))==5)
end

mata:
real matrix tests_abm_grid::tests_torus_closest(real rowvector orig, real rowvector dest)
{
    return(torus_closest(orig,dest))
}
foo = tests_abm_grid()
foo.rdim(10)
foo.cdim(10)
foo.torus(1)
foo.setup()

//   | 1 2 3 4 5 6 7 8 9 10 11
// --+--------------------------------------  
// 1 | O                    O'
// 2 |             D
true = 1, 11 \
       2, 7
assert(foo.tests_torus_closest((1,1),(2,7))==true)

foo.torus(0)
foo.setup()
true = 1,1 \
       2,7
assert(foo.tests_torus_closest((1,1),(2,7))==true)
// find_line() is just a wrapper for comp_line()
// there is not much to check for lerp()

// _export.mata
foo=tests_abm_grid()
foo.rdim(10)
foo.cdim(10)
foo.setup()
foo.create_agent(2,1,1)
foo.create_agent(2,2,5)
foo.create_agent(1,1,3)
true = 1,1,0,1,3 \
       2,1,0,1,1 \
       2,2,0,1,5
assert(foo.extract()==true)

// _agents.mata
foo=tests_abm_grid()
foo.rdim(10)
foo.cdim(10)
foo.setup()
foo.create_agent(1,1,2)
assert(foo.agent_id(1,1)==2)
assert(foo.agent_ids(1,1)==2)

foo=tests_abm_grid()
foo.rdim(10)
foo.cdim(10)
foo.idim(2)
foo.setup()
foo.create_agent(1,1,3,.,1)
foo.create_agent(1,1,5,.,2)
assert(foo.agent_id(1,1,.,1)==3)
assert(foo.agent_ids(1,1)==(3,5))

real rowvector tests_abm_grid::tests_make_key(real scalar r, real scalar c, real scalar t, real scalar i)
{
    return(make_key(r,c,t,i))
}

foo=tests_abm_grid()
foo.rdim(10)
foo.cdim(10)
foo.setup()
assert(foo.tests_make_key(1,1,.,.)==(1,1,0,1))


end
