{smcl}
{* *! version 0.1.0 22Jan2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid protected"}{...}
{p2colset 1 23 25 2}{...}
{p2col:{bf:finding neighbours} {hline 2}} protected functions used for 
finding neighbours{p_end}
{p2colreset}{...}

{marker findring_syntax}{...}
{title:Syntax}

{p 8 12 2}
{it: real matrix}	
	{cmd:basering(}{it:real scalar radius}{cmd:)}

{p 8 12 2}
{it:void} 
    {cmd:baserings()}	
	
{p 8 12 2}
{it:real colvector}	
    {cmd:out_of_bounds(}{it:real matrix pos}{cmd:)}
	
{p 8 12 2}	
{it:real matrix}
    {cmd:torus_adj(}{it:real matrix pos}{cmd:)}

{p 8 12 2}
{it:real matrix}	
    {cmd:neumannring(}{it:real scalar radius}{cmd:)}

{p 8 12 2}
{it:real matrix}	
    {cmd:moorering(}{it:real scalar radius}{cmd:)}
	
	
{marker description}{...}
{title:Description}


{p 4 4 2}
An important task in the {cmd:abm_grid} class is to find neighbours. This is done
with the public function {help abm_grid_findring:findring()}. It receives the
coordinates of the focal cell and a radius. Internally there is an associative 
array {cmd:baserings} that for each radius (the key) stores a matrix containing 
all coordinates of the so-called basering. The protected function {cmd:basering()}
receives as argument the radius and extracts the corresponding basering from that
associative array. A basering is the ring of cells around the focal cell (0,0) 
ignoring the edge of the grid, i.e. allowing negative row and column numbers. 
The nice thing about a basering is that we can get the coordinates of the ring of 
cells around another focal cell, by just adding the coordinates of that focal 
cell to the coordinates in the basering. This is almost what is being returned 
by {cmd:findring}, but some of the coordinates can fall outside the grid.
If we don't let the grid wrap around ({help abm_grid_torus:torus} = 0) then we 
need to find the coordinates outside the grid, with the protected function 
{cmd:out_of_bounds()}, and remove them form the matrix. If we allow the grid to 
wrap around ({help abm_grid_torus:torus} = 1), then we need to adjust the 
coordinates that are out of bounds with the protected {cmd:torus_adj()} function.

{p 4 4 2}
The associative array {cmd:baserings} is created in {help abm_grid_setup:setup()}
using the protected function {cmd:baserings()}, which in turn repeatedly calls 
either the protected function {cmd:neumannring()} or the protected function
{cmd:moorering()}, depending on whether we want a 
{help abm_grid_find_ring:moore neighbourhood} ({help abm_grid_neumann:neumann} = 0)
or a {help abm_grid_find_ring:Von Neumann} neighbourhood 
({help abm_grid_neumann:neumann} = 1). The {cmd:neumannring()} and 
{cmd:moorering()} functions receive as argument a radius and return the
corresponding basering. The {cmd:baserings()} function loops over all radiuses 
it wants to store in the associative array {cmd:baserings} 
(max({it:rdim},{it:cdim})), each time calling either {cmd:moorering()} or 
{cmd:neumannring()} and storing the result in the associative array.
	

{marker conformability}{...}
{title:Conformability}

    {cmd:basering(}{it:radius}{cmd:)}
        {it:radius}:  1 {it:x} 1
        {it:result}:  {it:k x} 2
		
    {cmd:baserings()}
        {it:result}:  {it:void}

    {cmd:out_of_bounds(}{it:pos}{cmd:)}
           {it:pos}:  {it:k x} 2
        {it:result}:  {it:k x} 1
	
    {cmd:torus_adj(}{it:pos}{cmd:)}
           {it:pos}:  {it:k x} 2
        {it:result}:  {it:k x} 2
		
    {cmd:neumannring(}{it:radius}{cmd:)}
        {it:radius}:  1 {it:x} 1
        {it:result}:  {it:k x} 2

    {cmd:moorering(}{it:radius}{cmd:)}
        {it:radius}:  1 {it:x} 1
        {it:result}:  {it:k x} 2
		
		
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:basering()}, {cmd:out_of_bounds()}, {cmd:torus_adj()} abort with an error 
if {help abm_grid_setup:setup()} has not been run first.

{p 4 4 2}
{cmd:basering()} aborts with an error if {it:radius} is larger than 
max({help abm_grid_rdim:rdim}, {help abm_grid_rdim:cdim})
		