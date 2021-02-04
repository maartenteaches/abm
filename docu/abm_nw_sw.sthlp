{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 7 9 2}{...}
{p2col:{bf:sw} {hline 2}}creates a random network using the 
Watts-Strogatz model{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:sw(}{it:real scalar degree}, {it:real scalar pr}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:sw()} creates a random network using the Watts-Strogatz model.
This creates a network with "small world" properties. The network 
is highly clustered. So if two nodes share a "friend", the chance is high
that they are also friends. This leads to a network with a lot of redundant
connections. At the same time, there are a few "long distance" connections.
These connections make it possible for most nodes to reach most other nodes
in a fairly small number of steps.

{p 4 4 2}
For a undirected network the nodes are lined up in order of their id. We can 
think of that line as circle, so that node 1 is the neighbour of the final 
nodel. Each node is connected to {it:degree}/2 neighbours to the left and 
{it:degree}/2 neighbours to the right. Each edge has a probabilty {it:pr} of 
being rewired, that is, the "destination node" of the edge is replaced by a 
randomly chosen node. The {it:degree} for an undirected network thus needs to be 
an even integer.

{p 4 4 2}
For a directed network, each node is connected to the floor({it:degree}/2)
neighbours to the left and ceil({it:degree}/2) neighbours to the right. So 
for a directed network, the degree can be an even or an odd integer.


{marker conformability}{...}
{title:Conformability}

    {cmd:sw(}{it:degree}, {it:pr}{cmd:)}:
           {it:result}:   {it:void}
           {it:degree:}   1 {it:x} 1 
           {it:pr}        1 {it:x} 1
		   
           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:sw()} aborts with an error if {it:degree} is not an integer

{p 4 4 2}
{cmd:sw()} aborts with an error if {cmd:directed} is set to 0 and {it:degree}
is odd

{p 4 4 2}
{cmd:sw()} aborts with an error if {it:pr} is less than 0 or larger than 1

{p 4 4 2}
{cmd:sw()} aborts with an error if {cmd:weighted} was set to 1.

{p 4 4 2}
{cmd:sw()} aborts with an error if a network was already imported.

{p 4 4 2}
{cmd:sw()} aborts with an error if nodes were dropped with 
{help abm_nw_remove_node:remove_node()} in the initial network (t=0).

{p 4 4 2}
{cmd:random()} aborts with an error if the number of initial nodes has
not been set.
