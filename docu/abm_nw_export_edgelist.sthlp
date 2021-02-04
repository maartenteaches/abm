{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 22 24 2}{...}
{p2col:{bf:export_edgelist()} {hline 2}}returns the list of edges as a matrix{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix}
{cmd:export_edgelist()}

{p 8 12 2}
{it:real matrix}
{cmd:export_edgelist(}{it:real scalar t}{cmd:)}

{p 8 12 2}
{it:real matrix}
{cmd:export_edgelist(}{it:real scalar t}, {it:string scalar ego_all}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:export_edgelist()} returns the list of edges at time {it:t} as a {it:k} 
by {it:3} matrix. If {it:t} is not specified, {it:t} will be 0. The first column
will be the node id of ego, the second column the node id of alter, and the third
column the weight. 

{p 4 4 2}
If any string is specified at {it:ego_all}, rows will be added
to the matrix such at all valid nodes at time {it:t} will at least have one 
entry in the ego column. These extra rows will have missing values on the second
and third column. 



{marker conformability}{...}
{title:Conformability}

    {cmd:export_edgelist()}:
           {it:result}:    {it:k x} 3 

    {cmd:export_edgelist(}{it:t}{cmd:)}:
           {it:result}:    {it:k x} 3 
           {it:t}:         1 {it:x} 1 

    {cmd:export_edgelist(}{it:t}, {it:ego_all}{cmd:)}:
           {it:result}:    {it:k x} 3 
           {it:t}:         1 {it:x} 1 
           {it:ego_all}    1 {it:x} 1
           
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:export_edgelist()} aborts with an error if {it:t} is not a valid time. Valid times 
are integers from 0 to {it:tdim}
