{smcl}
{* *! version 0.1.0 16Feb2021 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid_protected"}{...}
{phang}
{bf:is_valid_cell()} {hline 2} aborts with an error if 
the argument is not a matrix of valid cell adresses{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:is_valid_cell(}{it:real matrix tocheck}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}

{pmore}
{cmd:is_valid_cell()} aborts with an error if the {it:tocheck} is not
a matrix of valid cell adresses. The addresses are expected to be stacked
on top of one another. So {it:tocheck} has to have two columns, and
each row is a different cell address. The first column is for the row 
number, and the second column for the column number. The numbers
must be integers. If {help abm_grid_torus:torus} has not been set or 
set to 0, then the numbers must also be larger than 0 and less than 
{help abm_grid_rdim:rdim} and {help abm_grid_rdim:cdim} respectively.


{marker conformability}{...}
{title:Conformability}

    {cmd:is_valid_cell(}{it:tocheck}{cmd:)}:
           {it:result}:   {it:void}
           {it:tocheck}:  {it:k x} 2
		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
see description
