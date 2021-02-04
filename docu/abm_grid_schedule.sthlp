{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 15 17 2}{...}
{p2col:{bf:schedule()} {hline 2}}returns a list of coordinates of all cells in 
the grid.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} 
{cmd:schedule()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:schedule()} returns a {it:k} by 2 matrix with all the coordinates in the 
grid. The first column represents the row numbers, the second column the column 
numbers.

{p 4 4 2}
If {help abm_grid_randit:randit()} has been set to 1 then the order of these 
coordinates will be random and will differ each time {cmd:schedule()} is called. 
When {cmd:randit} has be set to 0 (or not set at all), the first coordinate will 
be the top left cell, continuing first from left to right and than from top to 
bottom.


{title:Remarks}

{p 4 4 2}
Many agent based models loop over all cells in a grid in an iteration. The 
{cmd:schedule()} function helps with that. Sometimes the order matters, which is
why there are two modes governed by the {cmd:randit} setting. 


{marker conformability}{...}
{title:Conformability}

    {cmd:schedule()}:
           {it:result}:  {it:k} {it:x} 2

   		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:schedule()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.
