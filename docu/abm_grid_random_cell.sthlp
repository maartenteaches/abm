{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 18 20 2}{...}
{p2col:{bf:random_cell()} {hline 2}}returns the coordinates of a random cell in 
the grid.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real rowvector} 
{cmd:random_cell()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:random_cell()} returns a 1 by 2 matrix with the coordinates of a random 
cell in the grid. The first number represents the row number, the second number
the column number.


{title:Remarks}

{p 4 4 2}
The iterations in many agent based models consist of "activating" a random cell.
The {cmd:random_cell()} function helps with that. 


{marker conformability}{...}
{title:Conformability}

    {cmd:random_cell()}:
           {it:result}:  1 {it:x} 2

   		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:random_cell()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.
