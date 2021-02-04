{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid_protected"}{...}
{phang}
{bf:is_setup()} {hline 2} aborts with an error if grid is not setup{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:is_setup()}


{marker description}{...}
{title:Description}

{p 4 4 2}

{pmore}
{cmd:is_setup()} aborts with an error if {cmd:setup()} has not run or when settings 
have been changed after {cmd:setup()} has been run. 


{marker conformability}{...}
{title:Conformability}

    {cmd:is_setup()}:
           {it:result}:   {it:void}
		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:is_setup()} aborts with an error if {cmd:setup()} has not run or when settings 
have been changed after {cmd:setup()} has been run.
