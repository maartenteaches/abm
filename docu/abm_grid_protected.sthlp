{smcl}
{* *! version 0.1.0 22Jan2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 30 32 2}{...}
{p2col:{bf:abm_grid class, protected} {hline 2}} protected functions and 
variables in the abm_grid class
models{p_end}
{p2colreset}{...}

{title:Description}

{p 4 4 2}
The {cmd:abm_grid} class has {help abm_grid:public functions} that the user can 
directly interact with and a number of protected functions and variables that 
are used internally but the user cannot access directly. However, if a user 
creates a new class that inherits from {cmd:abm_grid}, then, within that new 
class, the user does have access to these protected functions and variables. 
This can be helpful if your agent based model requires an additional function or 
that existing functions work differently.


{p2colset 8 24 26 8}{...}
{p2line -2 0}
{p2col 6 23 25 8:{it:Protected functions}}{p_end}
{p2col:{helpb abm_grid_is_setup:is_setup()}}aborts with an error if the scalar 
{cmd:setup} is not 1{p_end}
{p2col:{helpb abm_grid_baserings:baserings()}}Fills the associative array 
{cmd:baserings} with baserings for the radiuses 1..max(rdim,cdim) using either
{cmd:neumannring()} or {cmd:moorering()} depending on the setting 
{help abm_grid_neumann:neumann()}{p_end}
{p2col:{helpb abm_grid_baserings:neumannring()}}creates and returns a {it:k x 2} 
matrix with the row (first column) and column (second column) numbers of the 
basering for a given radius using a Von Neumann neighbourhood.{p_end}
{p2col:{helpb abm_grid_baserings:moorering()}}creates and returns a {it:k x 2} 
matrix with the row (first column) and column (second column) numbers of the 
basering for a given radius using a Moore neighbourhood.{p_end}
{p2col:{helpb abm_grid_baserings:basering()}}returns a {it:k x} 2 matrix with the 
row (first column) and column (second column) numbers of the basering for a 
given radius obtained from the associative array {cmd:baserings}.{p_end}
{p2col:{helpb abm_grid_baserings:out_of_bounds()}}returns a 1 when a given
coordinate is outside the grid (either a row or column number less than or equal 
to 0 are row number larger than {cmd:rdim} or a column number larger than 
{cmd:cdim}), otherwise it returns a 0.{p_end}
{p2col:{helpb abm_grid_baserings:torus_adj()}}receives a row an column number as
arguments and if it is out of bounds for the grid it adjusts it assuming the grid 
wraps around.{p_end}
{p2col:{helpb abm_grid_basecoords:basecoords()}}creates the matrix {cmd:basecoords}{p_end}
{p2col:{helpb abm_grid_make_key:make_key()}}receives the row, column, iteration, 
and location number, checks those arguments, fills them with appropriate defaults 
when necessary and returns the key for the associative array {cmd:universe}{p_end}
{p2col:{cmd:new()}}runs when an instance of the {cmd:abm_grid}
class is created. It sets the scalar {cmd:setup} to 0.{p_end}
{p2col:{helpb abm_grid_agent_loc:agent_loc()}}returns for a cell the row vector 
of locations at which agents exist{p_end}
{p2col:{helpb abm_grid_torus_closest:torus_closest()}}returns matrix of two coordinates such 
that the distance between is closest on a torus.{p_end}
{p2col:{helpb abm_grid_lerp:lerp()}}returns the closest cell that is {it:t} between 
{it:orig} and {it:dest}{p_end}
{p2col:{helpb abm_grid_comp_line:comp_line()}}sub-routine for 
{help abm_grid_find_line:find_line()} which returns the coordinates of all cells 
on a line {p_end}

{p2col 6 23 25 8:{it:Protected variables}}{p_end}
{p2col:{cmd:universe}}A 4 dimensional associative array containing the the grid. 
Created by {help abm_grid_setup:setup()}{p_end}
{p2col:{cmd:baserings}}A 1 dimensional associative array that stores for each 
radius (key) the basering. Created by {help abm_grid_baserings:baserings()}{p_end}
{p2col:{cmd:rdim}}scalar that stores the setting set by {help abm_grid_rdim:rdim()}{p_end}
{p2col:{cmd:cdim}}scalar that stores the setting set by {help abm_grid_rdim:cdim()}{p_end}
{p2col:{cmd:tdim}}scalar that stores the setting set by {help abm_grid_rdim:tdim()} 
or {help abm_grid_setup:setup()}{p_end}
{p2col:{cmd:idim}}scalar that stores the setting set by {help abm_grid_rdim:idim()} 
or {help abm_grid_setup:setup()}{p_end}
{p2col:{cmd:neumann}}scalar that stores the setting set by {help abm_grid_neumann:neumann()} 
or {help abm_grid_setup:setup()}{p_end}
{p2col:{cmd:torus}}scalar that stores the setting set by {help abm_grid_torus:torus()} 
or {help abm_grid_setup:setup()}{p_end}
{p2col:{cmd:randit}}scalar that stores the setting set by {help abm_grid_randit:randit()} 
or {help abm_grid_setup:setup()}{p_end}
{p2col:{cmd:basecoords}}A {it:k x} 2 matrix containing the row (first column) 
and column (second column) numbers of all cells in the grid. Created by 
{help abm_grid_basecoords:basecoords()}{p_end}
{p2col:{cmd:size}}scalar that stores the size of the grid (rdim {it:x} cdim). 
Created by {help abm_grid_setup:setup()}{p_end}
{p2col:{cmd:setup}}scalar set to 0 when {help abm_grid_setup:setup()} has not run
or when settings have been changed after {cmd:setup()} has been run. Otherwise
it contains a 1.{p_end}
{p2line -2 0}

{pstd}
In addition, {cmd:abm_grid} inherits protected functions from the 
{help abm_chk}, and {help abm_bc_protected:abm_bc} classes. 

