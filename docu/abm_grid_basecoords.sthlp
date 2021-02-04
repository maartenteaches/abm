{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid protected"}{...}
{p2colset 1 17 19 2}{...}
{p2col:{bf:basecoords()} {hline 2}}creates a list of coordinates of all cells in 
the grid.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:basecoords()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:basecoords()} makes the matrix {cmd:basecoords}, which is a {it:k} by 2 
matrix with all the coordinates in the grid. The first column represents the row 
numbers, the second column the column numbers. This matrix is created once by
{help abm_grid_setup:setup()} and returned by {help abm_grid_schedule:schedule()}.


{marker conformability}{...}
{title:Conformability}

    {cmd:basecoords()}:
           {it:result}:  {it:void}

