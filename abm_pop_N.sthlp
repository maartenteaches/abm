{smcl}
{* *! version 0.1.0 03Aug2020 MLB}{...}
{p2colset 1 8 10 2}{...}
{vieweralsosee "help abm_pop" "help abm_pop"}{...}
{p2col:{bf:N()} {hline 2}}return or set the number of agents{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:N()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:N(}{it:real scalar val}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:N()} returns the number of agents, and {cmd:N(}{it:val}{cmd:)} sets the 
initial number of agents to {it:val}. The agents will be numbered from 1 till 
{it:val}, and individual agents will be referred to by this id number. You can 
use this id number to store something using {help abm_pop_put:put()} or retrieve 
it using {help abm_pop_get:get()}. 


{title:Remarks}

{p 4 4 2}
{cmd:N()} cannot be used to set the number of agents at later times. The number 
of agents can be increased at later times using the {help abm_pop_add:add()} 
function. Agents cannot be removed.


{marker conformability}{...}
{title:Conformability}

    {cmd:N()}:
           {it:result}:  1 {it:x} 1
           
    {cmd:N(}{it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:val}      1 {it:x} 1

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:N()} aborts with an error if {it:val} less than or equal to 0 or {it:val} 
is not an integer.
