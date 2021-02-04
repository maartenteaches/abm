{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 30 32 2}{...}
{p2col:{bf:directed() and {bf:weighted()}} {hline 2}}return or set whether or not
the network is directed or weighted
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:directed()}

{p 8 12 2}
{it:real scalar} 
{cmd:weighted()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:directed(}{it:real scalar val}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:weighted(}{it:real scalar val}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:directed()} and weighted return whether (1) or not (0) the network is 
directed or weighted. 

{p 4 4 2}
In a directed network there is a direction to the relationship between nodes; 
there is a sender and a receiver. So node A could sent to node B, but it is 
possible for node B to not sent to node A. In an undirected network there is no 
direction: if A is connected to B then B is also connected to A. 

{p 4 4 2}
In a weighted network the edges could have a value, e.g. the distance between 
two cities or the frequency with which two persons meet. In an unweighted 
network the values are either 1 (there is a connection) or 0 (there is no 
connection). 


{title:Remarks}

{p 4 4 2}
When you don't specify {cmd:weighted()}, then {help abm_nw_setup:setup()} will
set the network to weighted. However, an unweighted network can be stored a bit 
more efficiently, which can speed up your agent based model. In smaller networks
you won't notice the difference, but in larger networks (say a milion nodes or 
more) the difference could become noticeable.


{marker conformability}{...}
{title:Conformability}

    {cmd:directed()}:
           {it:result}:  1 {it:x} 1
		   
    {cmd:weighed()}:
           {it:result}:  1 {it:x} 1           
    
	{cmd:directed(}{it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:val}      1 {it:x} 1

	{cmd:weighed(}{it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:val}      1 {it:x} 1
		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:directed(}{it:val}{cmd:)} and {cmd:weighted(}{it:val}{cmd:)} abort with an 
error if {it:val} is not 0 or 1.

{p 4 4 2}
{cmd:directed(}{it:val}{cmd:)} and {cmd:weighted(}{it:val}{cmd:)} abort with an 
error if the network at time 0 is frozen, that is after 
{help abm_nw_setup:setup()} has been run. {help abm_nw_clear:clear()} unfreezes 
the network.
