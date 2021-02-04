{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 13 15 2}{...}
{p2col:{bf:weight()} {hline 2}}returns the weight of an edge{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:weight(}{it:real scalar ego}, {it:real scalar alter}{cmd:)}

{p 8 12 2}
{it:real scalar}
{cmd:weight(}{it:real scalar ego}, {it:real scalar alter}, {it:real scalar t}{cmd:)}

{p 8 12 2}
{it:real scalar}
{cmd:weight(}{it:real scalar ego}, {it:real scalar alter}, {it:real scalar t}, 
{it:string scalar fast}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:weight()} returns the weight of the edge between {it:ego} and {it:alter}
at time {it:t}. If {it:t} is not specified, {it:t} will be 0. If no edge exist, 
the weight will be 0. If any string is specified in {it:fast}, 
then {cmd:weight()} will not check if {it:ego} and {it:alter} are valid nodes. 
This can speed up the simulation in large networks, but risks adding bugs.  


{marker conformability}{...}
{title:Conformability}

    {cmd:weight(}{it:ego}, {it:alter}{cmd:)}:
           {it:result}:    1 {it:x} 1
           {it:ego}:       1 {it:x} 1 
           {it:alter}:     1 {it:x} 1
           
    {cmd:weight(}{it:ego}, {it:alter}, {it:t}{cmd:)}:
           {it:result}:    1 {it:x} 1
           {it:ego}:       1 {it:x} 1 
           {it:alter}:     1 {it:x} 1
           {it:t}:         1 {it:x} 1 

    {cmd:weight(}{it:ego}, {it:alter}, {it:t}, {it:fast}{cmd:)}:
           {it:result}:    1 {it:x} 1
           {it:ego}:       1 {it:x} 1 
           {it:alter}:     1 {it:x} 1
           {it:t}:         1 {it:x} 1 
           {it:fast}       1 {it:x} 1

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:weight()} aborts with an error if {it:fast} is not specified and 
{it:ego} or {it:alter} is not a valid node id

{p 4 4 2}
{cmd:weight()} aborts with an error if {it:fast} is not specified and 
{it:t} is not a valid time. Valid times are integers from 0 to {it:tdim}
