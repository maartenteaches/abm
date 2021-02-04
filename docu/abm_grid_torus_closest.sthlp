{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid_protected"}{...}
{p2colset 1 20 22 2}{...}
{p2col:{bf:torus_closest()} {hline 2}}returns matrix of two coordinates such 
that the distance between is closest on a torus.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} 
{cmd:torus_closest(}{it:real rowvector orig}, {it:real rowvector dest} {cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
On a grid that wraps around, we can imagine that at each border of the grid there
is a copy of that grid, such that each point on these four extra grids 
corresponds to a point on the main grid. {cmd:torus_closest()} returns the 
coordinates of {it:orig} and {it:dest} on the extended grid (the main grid plus
the four extra grids), such that the distance between the points is smallest.

{p 4 4 2}
{cmd:torus_closest()} returns the coordinates as a single 2 {it:x} 2 matrix, 
where the first row represents {it:orig} and the second {it:dest}.


{marker conformability}{...}
{title:Conformability}

    {cmd:torus_closest(}{it:orig}, {it:dest}{cmd:)}:
           {it:result}:  2 {it:x} 2
           {it:orig}:    1 {it:x} 2
           {it:dest}:    1 {it:x} 2

   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:torus_closest()} aborts with an error if {help abm_grid_setup:setup()} has 
not been run first.

{p 4 4 2}
{cmd:torus_closest()} aborts with an error if either {it:orig} or {it:dest} is 
not a valid coordinate on the grid.

