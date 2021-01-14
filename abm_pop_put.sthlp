{smcl}
{* *! version 0.1.0 03Aug2020 MLB}{...}
{vieweralsosee "help abm_pop" "help abm_pop"}{...}
{p2colset 1 10 12 2}{...}
{p2col:{bf:put()} {hline 2}}stores a state of a characteristic of an agent and 
the time from when it applies{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:put(}{it:numeric rowvector key}, {it:transmorphic content}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:put()} stores the state {it:content} for agent {it:i}, characteristic 
{it:c}, at time {it:t}. The {it:key} is a vector with these three elements: 
({it:i}, {it:c}, {it:t}). The content will persist until it is changed by 
another call to {cmd:put()}. The content can be a scalar, a vector, or a matrix 
of real or irrational numbers or strings.


{marker conformability}{...}
{title:Conformability}

    {cmd:put(}{it:key}, {it:content}{cmd:)}:
           {it:result}:  {it:void} 
           {it:key}:     1 {it:x} 3
           {it:content}: {it:transmorphic}
           
       
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:put()} aborts with an error if {it:i} in {it:key} is not a positive number,
or more than {help abm_pop_N:N}, or not an integer.

{p 4 4 2}
{cmd:put()} aborts with an error if {it:c} in {it:key} is not a positive number,
or more than {help abm_pop_k:k}, or not an integer.

{p 4 4 2}
{cmd:put()} aborts with an error if {it:t} in {it:key} is not a positive number, 
or not an integer.

{p 4 4 2}
{cmd:put()} aborts with an error if {it:t} in {it:key} is less than the {it:t}
for the last characteristic stored for that agent, i.e. the things need to be
stored in chronological order. 