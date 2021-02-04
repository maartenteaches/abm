{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 13 15 2}{...}
{p2col:{bf:randit()} {hline 2}}return or set whether or not schedule() returns a
list of all coordinates in random order or not.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:randit()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:randit(}{it:real scalar bool}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:randit()} returns whether {help abm_grid_schedule:schedule()} will return a 
list of all coordinates in random order (1) or not (0). If this has not been set 
previously it returns {cmd:.}. 

{p 4 4 2}
{cmd:randit(}{it:bool}{cmd:)} sets or resets whether 
{help abm_grid_schedule:schedule()} will return a list of all coordinates in 
random order or not. Set {it:bool} to 1 if the order should be random and to 0 
when the order should always be from the top left to the bottom right, moving
horizontally first. If this has not been set, then 
{help abm_grid_setup:setup()} will set this to 0 (fixed order).


{title:Remarks}

{pstd}
Iterations in many Agent Based Models involve a loop over all cells in the grid.
Sometimes the behavior of the model differs depending on whether the cells
are accessed in a fixed or random order. To facilitate the creation on such a 
loop, the {help abm_grid_schedule:schedule()} function returns a list of all
coordinates. If {cmd:randit} has been set to 1 the order of these coordinates 
will be different and (pseudo-)random each time {cmd:schedule()} is called, while
if it has been set to 0 the order will be fixed: from left to right and from top 
to bottom. The fixed order is the default.


{marker conformability}{...}
{title:Conformability}

    {cmd:randit()}:
           {it:result}:  1 {it:x} 1

    {cmd:randit(}{it:bool}{cmd:)}:
             {it:bool}:  1 {it:x} 1
           {it:result}:  {it:void}

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:randit()} returns {cmd:.} if {cmd:randit} has not been specified previously.

{p 4 4 2}
{cmd:randit(}{it:bool}{cmd:)} aborts with an error if {it:bool} is not 0 or 1.
