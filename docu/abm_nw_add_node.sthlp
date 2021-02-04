{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 15 17 2}{...}
{p2col:{bf:add_node()} {hline 2}}adds node to network{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:add_node(}{it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:add_node()} adds a node to the network at time {it:t}. Its id will be the
pervious number of nodes plus one.


{marker conformability}{...}
{title:Conformability}

    {cmd:add_node(}{it:t}{cmd:)}:
           {it:result}:   {it:void}
           {it:t}:        1 {it:x} 1
           
         
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:add_node()} aborts with an error if {it:t} is not a valid time. Valid 
times are integers from 0 to {it:tdim}

{p 4 4 2}
{cmd:add_node()} aborts with an error if the network at time {it:t} is 
frozen, that is, {cmd:setup()} was previously called it {it:t} is 0, or the 
network was previously copied using {help abm_nw_copy_nw:copy_nw()} if {it:t} is 
larger than 0.

