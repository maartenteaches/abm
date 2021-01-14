{smcl}
{* *! version 0.1.0 03Aug2020 MLB}{...}
{vieweralsosee "help abm_pop" "help abm_pop"}{...}
{p2colset 1 12 14 2}{...}
{p2col:{bf:setup()} {hline 2}}sets defaults and performs checks on 
settings{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:setup()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:setup()} checks if the number of agents has been set, sets 
{help abm_pop_k:k} to 1 if it has not been set, and prepares the class to 
receive data for the agents. It is necessary to finish the setting up phase with
{cmd:setup()}, before using it.


{marker conformability}{...}
{title:Conformability}

    {cmd:setup()}:
           {it:result}:  {it:void} 
           
	   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:setup()} aborts with an error if {help abm_pop_N:N} has not been set.
