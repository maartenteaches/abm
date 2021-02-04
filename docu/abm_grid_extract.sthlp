{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 14 16 2}{...}
{p2col:{bf:extract()} {hline 2}}returns the grid as a matrix{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} 
{cmd:extract()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:extract()} returns the entire grid as a {it:k x} 5 matrix. The first 4 
columns are the row, column, iteration, and location number (in that order) and 
the fifth column is the agent_id stored at that location. 


{marker conformability}{...}
{title:Conformability}

    {cmd:extract()}:
           {it:result}:   {it:k x} 5
           
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:move_agent()} aborts with an error if {help abm_grid_setup:setup()} has not 
been run first.
