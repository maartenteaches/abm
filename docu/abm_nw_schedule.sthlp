{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 15 17 2}{...}
{p2col:{bf:schedule()} {hline 2}}returns a vector of nodes{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real vector}
{cmd:schedule()}

{p 8 12 2}
{it:real vector}
{cmd:schedule(}{it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:schedule()} returns a row vector of all nodes of the network at time {it:t}.
If {it:t} is not specified, then {it:t} is zero. 

{p 4 4 2}
If {help abm_nw_random:randomit}
is set to 1, then the nodes will be in random order. This can play a role when
the order of the returned vector determines the order in which the agents can 
take actions, which can sometimes have surprising effects in an ABM.


{marker conformability}{...}
{title:Conformability}

    {cmd:schedule()}:
           {it:result}:    1 {it:x k}

    {cmd:schedule(}{it:t}{cmd:)}:
           {it:result}:    1 {it:x k} 
           {it:t}:         1 {it:x} 1 

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:schedule()} aborts with an error if {it:t} is not a valid time. Valid times 
are integers from 0 to {it:tdim}
