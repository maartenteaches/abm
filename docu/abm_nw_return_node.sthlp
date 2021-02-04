{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 19 21 2}{...}
{p2col:{bf:return_node()} {hline 2}}returns a perviously removed node to the network{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:return_node(}{it:real scalar t}, {it:real scalar id}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:return_node()} returns node {it:id} that was previously removed by
{help abm_nw_remove_node:remove_node()} to the network at time {it:t}. It
does not recover the edges.


{marker conformability}{...}
{title:Conformability}

    {cmd:return_node(}{it:t},{it:id}{cmd:)}:
           {it:result}:   {it:void}
           {it:t}:        1 {it:x} 1
           {it:id}:       1 {it:x} 1
           
         
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:return_node()} aborts with an error if {it:id} was not previously removed.

{p 4 4 2}
{cmd:return_node()} aborts with an error if {it:t} is not a valid time. Valid 
times are integers from 0 to {it:tdim}

{p 4 4 2}
{cmd:return_node()} aborts with an error if the network at time {it:t} is 
frozen, that is, {cmd:setup()} was previously called it {it:t} is 0, or the 
network was previously copied using {help abm_nw_copy_nw:copy_nw()} if {it:t} is 
larger than 0.

