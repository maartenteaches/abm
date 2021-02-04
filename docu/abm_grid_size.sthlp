{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 11 13 2}{...}
{p2col:{bf:size()} {hline 2}}returns the number of cells in the grid.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:size()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:size()} returns the number of cells in the grid, that is the number of 
rows ({help abm_grid_rdim:rdim}) times the number of columns 
({help abm_grid_rdim:cdim}).


{marker conformability}{...}
{title:Conformability}

    {cmd:size()}:
           {it:result}:  1 {it:x} 1

   		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:size()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.
