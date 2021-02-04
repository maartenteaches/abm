{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 18 20 2}{...}
{p2col:{bf:remove_edge()} {hline 2}}removes an edge from a network{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:remove_edge(}{it:real scalar t}, {it:real scalar ego}, {it:real scalar alter}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:remove_edge()} removes the edge from {it:ego} to {it:alter} at time {it:t} 
from the network. If {it:directed} is set to 0, then it also removes the edge 
from {it:alter} to {it:ego}. 


{marker conformability}{...}
{title:Conformability}

    {cmd:remove_edge(}{it:t}, {it:ego}, {it:alter}{cmd:)}:
           {it:result}:   {it:void}
           {it:t}:        1 {it:x} 1
           {it:ego}:      1 {it:x} 1 
           {it:alter}:    1 {it:x} 1

         
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:remove_edge()} aborts with an error if {it:ego} or {it:alter} is not valid
a valid node id.

{p 4 4 2}
{cmd:remove_edge()} aborts with an error if {it:t] is not a valid time. Valid 
times are integers from 0 to {it:tdim}

{p 4 4 2}
{cmd:remove_edge()} aborts with an error if the edge that should be removed does 
not exist

{p 4 4 2}
{cmd:remove_edge()} aborts with an error if the network at time {it:t} is 
frozen, that is, {cmd:setup()} was previously called it {it:t} is 0, or the 
network was previously copied using {help abm_nw_copy_nw:copy_nw()} if {it:t} is 
larger than 0.

