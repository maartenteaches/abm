{smcl}
{* *! version 0.1.0 03Aug2020 MLB}{...}
{p2colset 1 14 16 2}{...}
{vieweralsosee "help abm_pop" "help abm_pop"}{...}
{p2col:{bf:extract()} {hline 2}}extracts a characteristic for all agents and 
time{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:pointer matrix}
{cmd:extract(}{it:real scalar c}, {it:real scalar tmax}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:extract()} returns a {help [M-2] pointers:pointer matrix} that for each 
agent (row) at each point in time till {it:tmax} (column) points to the state 
of characteristic {it:c}. It is intended to help exporting the results of your 
model to Stata. You still need to derefence the pointers, and adjust if they 
don't all point to a scalar of the same type.


{marker conformability}{...}
{title:Conformability}

    {cmd:extract(}{it:k}, {it:tmax}{cmd:)}:
           {it:result}:  {it:{help abm_pop_N:N} x tmax}
           {it:c}        1 {it:x} 1
           {it:tmax}     1 {it:x} 1

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:extract()} aborts with an error if {it:c} is not a positive integer or if
{it:c} is larger than {help abm_pop_k:k}.

{p 4 4 2}
{cmd:extract()} aborts with an error if {it:tmax} is not a positive integer.
