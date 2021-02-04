{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 13 15 2}{...}
{p2col:{bf:rewire()} {hline 2}}changes the start and end nodes of an
edge with other nodes{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:rewire(}{it:real scalar t}, {it:real scalar ego0}, 
{it:real scalar alter0}, {it:real scalar ego1}, {it:real scalar alter1}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:rewire()} changes the starting of an edge on time {it:t} from {it:ego0} to 
{it:ego1} and the end node from {it:alter0} to {it:alter1}. 


{marker conformability}{...}
{title:Conformability}

    {cmd:rewire(}{it:t}, {it:ego0}, {it:alter0}, {it:ego1}, {it:alter1}{cmd:)}:
           {it:result}:   {it:void}
           {it:t}:        1 {it:x} 1
           {it:ego0}:     1 {it:x} 1 
           {it:alter0}:   1 {it:x} 1
           {it:ego1}:     1 {it:x} 1
           {it:alter1}:   1 {it:x} 1

         
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:rewire()} aborts with an error if {it:ego0}, {it:alter0}, {it:ego1}, or 
{it:alter1} is not valid a valid node id.

{p 4 4 2}
{cmd:rewire()} aborts with an error if {it:t] is not a valid time. Valid 
times are integers from 0 to {it:tdim}

{p 4 4 2}
{cmd:rewire()} aborts with an error if the edge that should be changed does 
not exist

{p 4 4 2}
{cmd:rewire()} aborts with an error if the network at time {it:t} is 
frozen, that is, {cmd:setup()} was previously called it {it:t} is 0, or the 
network was previously copied using {help abm_nw_copy_nw:copy_nw()} if {it:t} is 
larger than 0.

