{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 14 16 2}{...}
{p2col:{bf:N_nodes()} {hline 2}}return or set the number of nodes
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:N_nodes(}{it:real scalar t}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:N_nodes(}0, {it:real scalar val}{cmd:)}

{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:N_nodes(}{it:t}{cmd:)} returns the number of Nodes in the network at time
{it:t}. {cmd:N_nodes(}0,{it:val}{cmd:)} sets the initial number of nodes to 
{it:val}. This will create a list of nodes numbered from 1 till {it:val}, and
individual nodes will be referred to by this id number. You can use this id 
number to track the properties of those nodes. 


{title:Remarks}

{p 4 4 2}
{cmd:N_nodes()} cannot be used to set the number of nodes at later times. The 
number of nodes can be increased at later times using the 
{help abm_nw_add_node:add_node()} or {help abm_nw_add_node:return_node()} 
functions, or decreased using the {help abm_nw_add_node:remove_node()} function.


{marker conformability}{...}
{title:Conformability}

    {cmd:N_nodes(}{it:t}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:t}:       1 {it:x} 1
           
    {cmd:N_nodes(}{it:t}, {it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:t}:       1 {it:x} 1
           {it:val}      1 {it:x} 1

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:N_nodes()} aborts with an error if {it:t} is negative or not an integer.

{p 4 4 2}
{cmd:N_nodes()} aborts with an error if {it:val} is specified and {it:t} is not 0.

{p 4 4 2}
{cmd:N_nodes()} aborts with an error if {it:val} less than or equal to 0 or 
{it:val} is not an integer.

{p 4 4 2}
{cmd:N_nodes(}{it:val}{cmd:)} aborts with an error if {it:val} is specified and 
the network at time 0 is frozen, that is after 
{help abm_nw_setup:setup()} has been run. {help abm_nw_clear:clear()} unfreezes 
the network.
		   