{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 14 16 2}{...}
{p2col:{bf:neumann()} {hline 2}}return or set the type of neighbourhood
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:neumann()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:neumann(}{it:real scalar bool}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:neumann()} returns whether the model uses Von Neumann neighbourhoods (1) or 
Moore neighbourhoods (0), if it has been set previously, or {cmd:.} when not. 

{p 4 4 2}
{cmd:neumann(}{it:bool}{cmd:)} sets or resets the type of neighbourhood used.
Set {it:bool} to 1 when Von Neumann neighbourhoods should be used, and 0 when
Moore neighbourhoods should be used. If this has not been set, then 
{help abm_grid_setup:setup()} will set this to 0 (Moore neighoorhood).


{title:Remarks}

{pstd}
An important reason for using a grid in an Agent Based Model is that an agent's
location on the grid defines with whom it can interact. There are two basic 
styles of neighbours: The Moore and Von Neumann neighbours. A neighbourhood is 
defined by how many "steps" a vocal cell is removed from other cells. A Moore 
neighbourhood allows horizontal, vertical, and diagonal steps, while a Von 
Neumann neighboorhood only allows horizontal and vertical steps. These two 
styles are described in the figure below. The {cmd:o} is the vocal cell for whom 
we want to find the neighbours, the {cmd:x}s are the neighbours and the {cmd:.}s 
are not selected. Moore is the default.

{cmd}{...}
    radius       Moore   Von Neumann
    
      1          x x x      . x .
                 x o x      x o x
                 x x x      . x .
 
      2        x x x x x  . . x . .
               x . . . x  . x . x .
               x . o . x  x . o . x
               x . . . x  . x . x .
               x x x x x  . . x . .
{txt}{...}


{marker conformability}{...}
{title:Conformability}

    {cmd:neumann()}:
           {it:result}:  1 {it:x} 1

    {cmd:neumann(}{it:bool}{cmd:)}:
             {it:bool}:  1 {it:x} 1
           {it:result}:  {it:void}

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:neumann()} returns {cmd:.} if the style of neighbourhood has not been 
specified previously.

{p 4 4 2}
{cmd:neumann(}{it:bool}{cmd:)} aborts with an error if {it:bool} is not 0 or 1.
