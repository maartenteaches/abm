{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 13 15 2}{...}
{p2col:{bf:N_edges()} {hline 2}}returns the number of edges{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:N_edges()}

{p 8 12 2}
{it:real scalar}
{cmd:N_edges(}{it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:N_edges()} returns the number of edges at time {it:t}. If {it:t} is 
not specified, {it:t} will be 0. 


{marker conformability}{...}
{title:Conformability}

    {cmd:N_edges()}:
           {it:result}:    1 {it:x} 1

    {cmd:N_edges(}{it:t}{cmd:)}:
           {it:result}:    1 {it:x} 1
           {it:t}:         1 {it:x} 1 

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:weight()} aborts with an error if {it:t} is not a valid time. Valid times 
are integers from 0 to {it:tdim}
