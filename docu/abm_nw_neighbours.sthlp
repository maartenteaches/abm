{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 17 19 2}{...}
{p2col:{bf:neighbours()} {hline 2}}returns a vector of neighbouring nodes{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real vector}
{cmd:neighbours(}{it:real scalar ego}{cmd:)}

{p 8 12 2}
{it:real vector}
{cmd:neighbours(}, {it:real scalar ego}, {it:real scalar t}{cmd:)}

{p 8 12 2}
{it:real vector}
{cmd:neighbours(}{it:real scalar ego},{it:real scalar t}, 
{it:string scalar dropped_ok}{cmd:)}

{p 8 12 2}
{it:real vector}
{cmd:neighbours(}{it:real scalar ego}{it:real scalar t}, 
{it:string scalar dropped_ok}, {it:string scalar fast}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:neighbours()} returns a rowvector of nodes connected to {it:ego}. If {it:t}
is not specified, {it:t} will be 0. If any string is specified in {it:dropped_ok},
for readabilty I prefer a string like "dropped_ok", {it:ego} could be the id of
a node dropped by {help abm_nw_remove_node:remove_node()}. The vector of neighbours
will in that case be {cmd:J(1,0,.)}. If any string is specified in {it:fast}, 
then {cmd:neighbours()} will not check if {it:ego} is a valid node. This can
speed up the simulation in large networks, but risks adding bugs.  


{marker conformability}{...}
{title:Conformability}

    {cmd:neighbours(}{it:ego}{cmd:)}:
           {it:result}:    1 {it:x k}
           {it:ego}:       1 {it:x} 1 

    {cmd:neighbours(}{it:ego}, {it:t}{cmd:)}:
           {it:result}:    1 {it:x k}
           {it:ego}:       1 {it:x} 1 
           {it:t}:         1 {it:x} 1 

    {cmd:neighbours(}{it:ego}, {it:t}, {it:dropped_ok}{cmd:)}:
           {it:result}:    1 {it:x k}
           {it:ego}:       1 {it:x} 1 
           {it:t}:         1 {it:x} 1 
           {it:dropped_ok} 1 {it:x} 1

    {cmd:neighbours(}{it:ego}, {it:t}, {it:dropped_ok}, {it:fast}{cmd:)}:
           {it:result}:    1 {it:x k}
           {it:ego}:       1 {it:x} 1 
           {it:t}:         1 {it:x} 1 
           {it:dropped_ok} 1 {it:x} 1          
           {it:fast}       1 {it:x} 1

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:neighbours()} aborts with an error if {it:fast} is not specified and 
{it:ego} is not a valid node id

{p 4 4 2}
{cmd:neighbours()} aborts with an error if {it:fast} is not specified and 
{it:t] is not a valid time. Valid times are integers from 0 to {it:tdim}
