{smcl}
{* *! version 0.1.0 03Aug2020 MLB}{...}
{vieweralsosee "help abm_pop" "help abm_pop"}{...}
{p2colset 1 10 12 2}{...}
{p2col:{bf:get()} {hline 2}}retrieves a state of a characteristic of an agent at 
a given time{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:transmorphic} 
{cmd:get(}{it:numeric rowvector key}{cmd:)}

{p 8 12 2}
{it:transmorphic} 
{cmd:get(}{it:numeric rowvector key}, {it:string scalar how}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:get()} retrieves the state for agent {it:i}, characteristic {it:c}, at time 
{it:t}. The {it:key} is a vector with two or three elements: ({it:i}, {it:c}) or 
({it:i}, {it:c}, {it:t}). if {it:t} is not part of {it:key}, or it is missing, 
then the latest state is returned. If nothing was ever put into that 
characteristic for that agent, then {cmd:put} will return nothing (J(0,0,.)).

{p 4 4 2}
Given that {cmd:abm_pop} does not store the state for every time-point, but only
when it changes, {cmd:get()} can quickly find the first and last state, but for 
everything in between it needs to do some form of searching. This is what is 
governed by the argument {it:how}. It can take five values:

{phang}
{it:"last"} returns the most recent state. Leaving {it:t} out of the {it:key} or
setting {it:t} to missing will set {it:how} to "last".

{phang}
{it:"first"} returns the first state stored for that characteristic for that 
agent. This does not have to be the state at time 1, as the first time you 
{help abm_pop_put:put()} someting you can specify another {it:t} than 1, which
might indicate that that agent only entered the model at a later date.  
 
{pmore}
Both "first" and "last" are very fast, so you should use it when you know 
that it is applicable.
 
{pmore}
Both "first" and "last" will ignore the {it:t} in {it:key}.

{pmore}
If {it:how} is not set to "first" or "last" and the {it:t} in the {it:key} is 
less than the first time something was stored for that agent and that 
characteristic, then {cmd:get()} will return nothing (J(0,0,.)).

{phang}
{it:"binary"} does a binary search, i.e. it splits the range in half, selects 
the right half, splits that in half, etc, until it finds the {it:t} specified
in the {it:key}. This is a good choice when we have no idea where to start 
looking. It is the default. 

{phang}
{it:"backwards"} starts searching at the latest time point moves backwards. This
can be efficient when you know that the time point is late but not guaranteed to
be the latest.

{phang}
{it:"forwards"} starts searching at the earliest time point and moves forwards.
This can be efficient when you know that the time point is early but not 
guaranteed to be the earliest.
 

{marker conformability}{...}
{title:Conformability}

    {cmd:get(}{it:key}{cmd:)}:
           {it:result}:  {it:transmorphic} 
           {it:key}:     1 {it:x} 2 or 1 {it:x} 3 
           
    {cmd:get(}{it:key}, {it:how}{cmd:)}:
           {it:result}:  {it:transmorphic} 
           {it:key}:     1 {it:x} 2 or 1 {it:x} 3
           {it:how}:     1 {it:x} 1
		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:get()} aborts with an error if {it:i} in {it:key} is not a positive 
integer, or more than {help abm_pop_N:N}.

{p 4 4 2}
{cmd:get()} aborts with an error if {it:c} in {it:key} is not a positive 
integer, or more than {help abm_pop_k:k}.

{p 4 4 2}
{cmd:get()} aborts with an error if {it:t} in {it:key} is not a positive 
integer.

{p 4 4 2}
{cmd:get()} aborts with an error if {it:how} takes another value than "first",
"last", "binary", "forwards", or "backwards". 
