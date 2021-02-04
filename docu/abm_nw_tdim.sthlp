{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 11 13 2}{...}
{p2col:{bf:tdim()} {hline 2}}return or set the number of iterations
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:tdim()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:tdim(}{it:real scalar val}{cmd:)}

{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:tdim()} returns the number of iterations. {cmd:tdim(}{it:val}{cmd:)} sets 
the number of iterations to {it:val}. 


{title:Remarks}

{p 4 4 2}
In many Agent Based Models only the properties of the agents change, but the 
network remains constant. In that case you should set the time dimension for the
network to 0. 


{marker conformability}{...}
{title:Conformability}

    {cmd:tdim()}:
           {it:result}:  1 {it:x} 1
           
    {cmd:tdim(}{it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:val}      1 {it:x} 1

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:tdim} aborts with an error if {help abm_nw_N_nodes:N_nodes()} has not been 
set.

{p 4 4 2}
{cmd:tdim(}{it:val}{cmd:)} aborts with an error if {it:val} is negative or not an integer.

{p 4 4 2}
{cmd:tdim(}{it:val}{cmd:)} aborts with an error if the network at time 0 is frozen, that is after 
{help abm_nw_setup:setup()} has been run. {help abm_nw_clear:clear()} unfreezes 
the network.		   
