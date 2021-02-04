{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 15 17 2}{...}
{p2col:{bf:add_edge()} {hline 2}}adds an edge to a network{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:add_edge(}{it:real scalar t}, {it:real scalar ego}, {it:real scalar alter}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:add_edge(}{it:real scalar t}, {it:real scalar ego}, {it:real scalar alter},
{it:real scalar weight}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:add_edge(}{it:real scalar t}, {it:real scalar ego}, {it:real scalar alter},
{it:real scalar weight}, {it:string scalar replace}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:add_edge(}{it:real scalar t}, {it:real scalar ego}, {it:real scalar alter},
{it:real scalar weight}, {it:string scalar replace}, {it:string scalar fast}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:add_edge()} adds an edge from {it:ego} to {it:alter} at time {it:t} to the
network. If {it:directed} is set to 0, then it also adds the edge from {it:alter}
to {it:ego}. Optionally, one can also specify the weight (if {it:weighted} was set
to 1). 

{p 4 4 2}
By default, {cmd:add_edge} will abort with an error if the edge already 
exists. By specifying any string in {it:replace}, for readabilty I prefer the
string "replace", {cmd:add_edge()} can overwrite existing edges. 

{p 4 4 2}
By default,
{cmd:add_edge()} checks if {it:ego} and {it:alter} are valid id numbers for 
nodes. In large networks the cost in time can be noticable. These checks can
be suppressed by specifying any string in {it:fast}. This is mainly useful if
{cmd:add_edge()} is used in a sub-routine that already checks the validity of
the id numbers, and the check would be superfluous. In general there is nothing
wrong with double checking, so I would only specify this option when it is 
absolutely necessary.


{marker conformability}{...}
{title:Conformability}

    {cmd:add_edge(}{it:t}, {it:ego}, {it:alter}{cmd:)}:
           {it:result}:   {it:void}
           {it:t}:        1 {it:x} 1
           {it:ego}:      1 {it:x} 1 
           {it:alter}:    1 {it:x} 1

    {cmd:add_edge(}{it:t}, {it:ego}, {it:alter}, {it:weight}{cmd:)}:
           {it:result}:   {it:void}
           {it:t}:        1 {it:x} 1
           {it:ego}:      1 {it:x} 1 
           {it:alter}:    1 {it:x} 1
           {it:weight}:   1 {it:x} 1
           
    {cmd:add_edge(}{it:t}, {it:ego}, {it:alter}, {it:weight}, {it:replace}{cmd:)}:
           {it:result}:   {it:void}
           {it:t}:        1 {it:x} 1
           {it:ego}:      1 {it:x} 1 
           {it:alter}:    1 {it:x} 1
           {it:weight}:   1 {it:x} 1  
           {it:replace}:  1 {it:x} 1
         
    {cmd:add_edge(}{it:t}, {it:ego}, {it:alter}, {it:weight}, {it:replace}, {it:fast}{cmd:)}:
           {it:result}:   {it:void}
           {it:t}:        1 {it:x} 1
           {it:ego}:      1 {it:x} 1 
           {it:alter}:    1 {it:x} 1
           {it:weight}:   1 {it:x} 1  
           {it:replace}:  1 {it:x} 1
           {it:fast}:     1 {it:x} 1
         
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:add_edge()} aborts with an error if {it:fast} is not specified and 
{it:ego} or {it:alter} is not a valid node id

{p 4 4 2}
{cmd:add_edge()} aborts with an error if {it:fast} is not specified and 
{it:t] is not a valid time. Valid times are integers from 0 to {it:tdim}

{p 4 4 2}
{cmd:add_edge()} aborts with an error if {it:fast} is not specified and the
network at time {it:t} is frozen, that is, {cmd:setup()} was previously called
it {it:t} is 0, or the network was previously copied using 
{help abm_nw_copy_nw:copy_nw()} if {it:t} is larger than 0.

{p 4 4 2}
{cmd:add_edge()} aborts with an error if {it:fast} is not specified and 
{it:weighted} was set to 0 and a weight was specified other than 0 or 1.

{p 4 4 2}
{cmd:add_edge()} aborts with an error if {it:replace} is not specified and 
the edge already exists
