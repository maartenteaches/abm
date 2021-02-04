{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 15 17 2}{...}
{p2col:{bf:randomit()} {hline 2}}sets or returns whether the list of nodes 
returned by {cmd:schedule()} is in random order or not
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:randomit()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:randomit(}{it:real scalar val}{cmd:)}

{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:randomit()} returns whether {help abm_nw_schedule:schedule()} returns a list
of nodes in random order or not. In many Agent Based Models you will be looping
over nodes. Sometimes the order in which agents can take actions matter.  


{marker conformability}{...}
{title:Conformability}

    {cmd:randomit()}:
           {it:result}:  1 {it:x} 1
           
    {cmd:randomit(}{it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:val}      1 {it:x} 1

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:randomit(}{it:val}{cmd:)} aborts with an error if {it:val} is not 0 or 1.

{p 4 4 2}
{cmd:randomit(}{it:val}{cmd:)} aborts with an error if the network at time 0 is frozen, that is after 
{help abm_nw_setup:setup()} has been run. {help abm_nw_clear:clear()} unfreezes 
the network.
