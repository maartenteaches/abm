{smcl}
{* *! version 0.1.0 03Aug2020 MLB}{...}
{p2colset 1 10 12 2}{...}
{vieweralsosee "help abm_pop" "help abm_pop"}{...}
{p2col:{bf:add()} {hline 2}}add agents{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:add(}{it:real scalar val}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:add(}{it:val}{cmd:)} adds {it:val} new agents. If previously there were 
{it:N} agents, then the new agents will receive the id numbers {it:N}+1 till
{it:N}+{it:val} 

{title:Remarks}

{p 4 4 2}
{cmd:add()} is intended for adding agents after {help abm_pop_setup:setup()}.
This can be useful in models where new agents enter the model over time and the
total number of agents is not known beforehand.


{marker conformability}{...}
{title:Conformability}

    {cmd:add(}{it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:val}      1 {it:x} 1

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:add()} aborts with an error if {it:val} is negative or {it:val} 
is not an integer.
