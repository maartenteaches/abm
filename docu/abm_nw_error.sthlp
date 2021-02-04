{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{vieweralsosee "help abm_nw_protected" "help abm_nw_protected"}{...}
{p2colset 1 29 31 2}{...}
{p2col:error checking functions {hline 2}}aborts with 
an error if arguments don't meet requirements{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:is_setup()}

{p 8 12 2}
{it:void} 
{cmd:is_nodesset()}

{p 8 12 2}
{it:void} 
{cmd:is_frozen()}

{p 8 12 2}
{it:void} 
{cmd:is_frozen(}{it:real scalar t}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_symmetric()}

{p 8 12 2}
{it:void} 
{cmd:is_symmetric(}{it:real scalar t}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_valid_id(}{it:real scalar id}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_valid_id(}{it:real scalar id}, {it:real scalar t}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_valid_id(}{it:real scalar id}, {it:real scalar t}, {it:string scalar dropped_ok}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_valid_time(}{it:real scalar t}{cmd:)}

{marker description}{...}
{title:Description}

{p 4 4 2}
These functions test whether common requirements are met, and aborts with an 
error message when that is not the case.

{pmore}
{cmd:is_setup()} aborts with an error if {help abm_nw_setup:setup()} has not run. 

{pmore}
{cmd:is_nodesset()} aborts with an error if the initial number of nodes is not
yet specified, see {help abm_nw_N_nodes:N_nodes()}

{pmore}
{cmd:is_frozen()} aborts with an error if the network at time {it:t} is "frozen".
After {help abm_nw_setup:setup()} has been run, the network at time 0 is assumed
to be done, and can no longer be changed. Similarly, if a network at time {it:t}
is copied using {help abm_nw_copy_nw:copy_nw()}, then the network at time {it:t} 
is assumed to be done. If {it:t} is not specified, then {it:t} is 0.

{pmore}
{cmd:is_symmetric()} aborts with an error if the network at time {it:t} is not 
symmetric. If {it:t} is not specified, then {it:t} is 0.

{pmore}
{cmd:is_valid_id()} aborts with an error if {it:id} is not a valid node id at
time {it:t}. If {it:t} is not specified, then {it:t} is 0. By default, ids of 
nodes that have been removed from the network using 
{help abm_nw_remove_node:remove_node()} are not valid nodes, unless any string
was specified for {it:dropped_ok}.

{pmore}
{cmd:is_valid_time()} aborts with an error if {it:t} is not a valid time. Valid
times are integers between 1 and {help abm_nw_tdim:tdim} (inclusive).

{marker conformability}{...}
{title:Conformability}

    {cmd:is_setup()}:
           {it:result}:   { it:void}

    {cmd:is_nodesset()}:
           {it:result}:    {it:void}    
           
    {cmd:is_frozen()}:
           {it:result}:    {it:void}           

    {cmd:is_frozen(}{it:t}{cmd:)}:
           {it:result}:    {it:void}    
           {it:t}:         1 {it:x} 1
    
    {cmd:is_symmetric()}:
           {it:result}:    {it:void}

    {cmd:is_symmetric(}{it:t}{cmd:)}:
           {it:result}:    {it:void}    
           {it:t}:         1 {it:x} 1
           
    {cmd:is_valid_id(}{it:id}{cmd:)}:
           {it:result}:    {it:void}    
           {it:id}:        1 {it:x} 1          

    {cmd:is_valid_id(}{it:id}, {it:t}{cmd:)}:
           {it:result}:    {it:void}    
           {it:id}:        1 {it:x} 1
           {it:t}:         1 {it:x} 1

    {cmd:is_valid_id(}{it:id}, {it:t}, {it:dropped_ok}{cmd:)}:
           {it:result}:    {it:void}    
           {it:id}:        1 {it:x} 1
           {it:t}:         1 {it:x} 1
           {it:dropped_ok} 1 {it:x} 1
           
    {cmd:is_valid_time(}{it:t}{cmd:)}:
           {it:result}:    {it:void}    
           {it:t}:         1 {it:x} 1   
           
           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
See description.
