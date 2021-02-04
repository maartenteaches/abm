{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 17 19 2}{...}
{p2col:{bf:copy_grid()} {hline 2}}copy all cells from one iteration to another.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:copy_agents(}{it:real scalar to}, {it:real scalar td}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:copy_grid()} copies all cells from one iteration to another. 


{title:Remarks}

{p 4 4 2}
If the grid evolves over time, it is often useful to start an iteration by 
copying the entire grid from the previous iteration and than make changes when 
necessary. {cmd:copy_grid()} is there to do that copying.


{marker conformability}{...}
{title:Conformability}

    {cmd:copy_agents(}{it:to}, {it:td}{cmd:)}:
           {it:result}:   {it:void}
           {it:to}:        1 {it:x} 1
           {it:td}:        1 {it:x} 1

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:copy_agents()} aborts with an error if {help abm_grid_setup:setup()} has not 
been run first.



