{smcl}
{* *! version 0.1.0 03Aug2020 MLB}{...}
{vieweralsosee "help abm_pop" "help abm_pop"}{...}
{p2colset 1 8 10 2}{...}
{p2col:{bf:k()} {hline 2}}return or set the number of characteristics{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:k()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:k(}{it:real scalar val}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:k()} returns the number of characteristics, while {cmd:k(}{it:val}{cmd:)} 
sets the number of characteristics to {it:val}. One can think of a characteristic 
as a variable in a Stata dataset; it stores a property of an agent. But this 
property can change over time and at each point in time it does not have to be
a single value (scalar), but it can be a vector or a matrix. Also, unlike 
variables the characteristics are not named but numbered from 1 till {it:val}.
You can use this number to store something using {help abm_pop_put:put()} or 
retrieve it using {help abm_pop_get:get()}.  


{marker conformability}{...}
{title:Conformability}

    {cmd:k()}:
           {it:result}:  1 {it:x} 1
           
    {cmd:k(}{it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:val}      1 {it:x} 1

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:k()} aborts with an error if {it:val} less than or equal to 0 or {it:val} 
is not an integer.
