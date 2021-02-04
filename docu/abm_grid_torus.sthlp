{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 12 14 2}{...}
{p2col:{bf:torus()} {hline 2}}return or set whether or not the grid wraps around
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:torus()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:torus(}{it:real scalar bool}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:torus()} returns whether the grid wraps around (1) - that is, that cells on 
the left border of the grid neighbour opposite cells on the right border and 
cells on the top border neighbour cells on the opposite bottom border - or not 
(0). If this has not been set previously it returns {cmd:.}. 

{p 4 4 2}
{cmd:torus(}{it:bool}{cmd:)} sets or resets whether the grid wraps around or 
not. Set {it:bool} to 1 when the grid should wrap around and to 0 when the grid
should not wrap around. If this has not been set, then 
{help abm_grid_setup:setup()} will set this to 0 (not wrap around).


{title:Remarks}

{pstd}
One thing to consider with a grid is what to do with the cells on the borders of 
the grid. They can either have fewer neighbours, or we can say that the grid 
wraps around so that cells of the left border neighbour cells on the right 
border and cells on the top border neighbour cells on the bottom border. The 
default is to let cells on the border have fewer neighbours.


{marker conformability}{...}
{title:Conformability}

    {cmd:torus()}:
           {it:result}:  1 {it:x} 1

    {cmd:torus(}{it:bool}{cmd:)}:
             {it:bool}:  1 {it:x} 1
           {it:result}:  {it:void}

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:torus()} returns {cmd:.} if the wrapping behavior of the grid has not been 
specified previously.

{p 4 4 2}
{cmd:torus(}{it:bool}{cmd:)} aborts with an error if {it:bool} is not 0 or 1.
