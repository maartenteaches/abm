{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 14 16 2}{...}
{p2col:{bf:copy_nw()} {hline 2}}copies a network from one timepoint to another{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:copy_nw(}{it:real scalar t0}, {it:real scalar t1}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:copy_nw()} copies a network from {it:t0} to {it:t1}. This will "freeze"
the network of {it:t0}, that is, no changes can be made to the network at {it:t0}. 


{marker conformability}{...}
{title:Conformability}

    {cmd:copy_nw(}{it:t0},{it:t1}{cmd:)}:
           {it:result}:   {it:void}
           {it:t0}:       1 {it:x} 1
           {it:t1}:       1 {it:x} 1
           
         
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:copy_nw()} aborts with an error if {it:t0} or {it:t1} is not a valid time. Valid 
times are integers from 0 to {it:tdim}

{p 4 4 2}
{cmd:copy_nw()} aborts with an error if the network at time {it:t1} is 
frozen, that is, {cmd:setup()} was previously called it {it:t} is 0, or the 
network was previously copied using {help abm_nw_copy_nw:copy_nw()} if {it:t} is 
larger than 0.

