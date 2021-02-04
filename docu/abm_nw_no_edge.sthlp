{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 32 34 2}{...}
{p2col:{bf:no_edge()} and {bf:edge_exists()} {hline 2}}tests whether an edge exists{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:edge_exists(}{it:real scalar ego}, {it:real scalar alter}{cmd:)}

{p 8 12 2}
{it:real scalar}
{cmd:edge_exists(}{it:real scalar ego}, {it:real scalar alter}, {it:real scalar t}{cmd:)}

{p 8 12 2}
{it:real scalar}
{cmd:edge_exists(}{it:real scalar ego}, {it:real scalar alter}, 
{it:real scalar t}, {it:string scalar fast}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:no_edge(}{it:real scalar t}, {it:real scalar ego}, {it:real scalar alter}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:no_edge(}{it:real scalar t}, {it:real scalar ego}, {it:real scalar alter}, 
{it:string scalar fast}{cmd:)}

{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:edge_exists()} returns whether (1) or not (0) the edge between {it:ego} and 
{it:alter} at time {it:t} exists. If {it:t} is not specified, then {it:t} is 0.
If any string is specified in {it:fast}, then {cmd:edge_exists()} will not check
whether {it:ego} and {it:alter} are valid ids for nodes at time {it:t}. This can
speed up the simulation in large networks, but at the cost of an increased risk 
of bugs. 

{p 4 4 2}
{cmd:no_edge()} returns aborts with an error message when an edge between 
{it:ego} and {it:alter} at time {it:t} exists. If any string is specified in 
{it:fast}, then {cmd:no_edge()} will not check whether {it:ego} and {it:alter} 
are valid ids for nodes at time {it:t}. This can speed up the simulation in 
large networks, but at the cost of an increased risk of bugs.  


{marker conformability}{...}
{title:Conformability}

    {cmd:edge_exists(}{it:ego}, {it:alter}{cmd:)}:
           {it:result}:    1 {it:x} 1
           {it:ego}:       1 {it:x} 1
           {it:alter}:     1 {it:x} 1		   
		   
    {cmd:edge_exists(}{it:ego}, {it:alter}, {it:t} {cmd:)}:
           {it:result}:    1 {it:x} 1
           {it:ego}:       1 {it:x} 1
           {it:alter}:     1 {it:x} 1		   
           {it:t}:         1 {it:x} 1

    {cmd:edge_exists(}{it:ego}, {it:alter}, {it:t}, {it:fast} {cmd:)}:
           {it:result}:    1 {it:x} 1
           {it:ego}:       1 {it:x} 1
           {it:alter}:     1 {it:x} 1		   
           {it:t}:         1 {it:x} 1
           {it:fast}:      1 {it:x} 1

    {cmd:no_edge(}{it:t}, {it:ego}, {it:alter}{cmd:)}:
           {it:result}:    {it:void} 
           {it:t}:         1 {it:x} 1 
           {it:ego}:       1 {it:x} 1
           {it:alter}:     1 {it:x} 1
		   
    {cmd:no_edge(}{it:t}, {it:ego}, {it:alter}, {it:fast}{cmd:)}:
           {it:result}:    {it:void} 
           {it:t}:         1 {it:x} 1 
           {it:ego}:       1 {it:x} 1
           {it:alter}:     1 {it:x} 1  
           {it:fast}:      1 {it:x} 1  		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:edge_exists()} and {cmd:no_edge()} abort1 with an error if nothing is 
specified for {it:fast} and {it:ego} or {it:alter} is not a valid id for a node.

{p 4 4 2}
{cmd:edge_exists()} and {cmd:no_edge()} abort with an error if nothing is 
specified for {it:fast} and {it:t} is not a valid time. Valid times are integers from 0 to {it:tdim}

{p 4 4 2}
{cmd:no_edge()} aborts with an error if an edge exists between {it:ego} and 
{it:alter} at time {it:t}
