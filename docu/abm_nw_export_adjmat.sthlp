{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 20 22 2}{...}
{p2col:{bf:export_adjmat()} {hline 2}}returns the adjancency matrix as a matrix{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:export_adjmat()}

{p 8 12 2}
{it:real matrix}
{cmd:export_adjmat(}{it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:export_adjmat()} returns the adjancency matrix at time {it:t} as a {it:N} 
by {it:N} matrix, where {it:N} is the number of nodes that ever existed in the
network. The row and column numbers correspond to the node id. If a node did not
exist at time {it:t} the corresponding entries are set to missing. If {it:t} is 
not specified, {it:t} will be 0. 


{marker conformability}{...}
{title:Conformability}

    {cmd:export_adjmat()}:
           {it:result}:    {it:N x N} 

    {cmd:export_adjmat(}{it:t}{cmd:)}:
           {it:result}:    {it:N x N} 
           {it:t}:         1 {it:x} 1 

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:export_adjmat()} aborts with an error if {it:t} is not a valid time. Valid times 
are integers from 0 to {it:tdim}
