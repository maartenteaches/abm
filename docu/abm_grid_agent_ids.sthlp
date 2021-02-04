{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_agent_id" "help abm_grid_agent_id"}{...}
{p2colset 1 16 18 2}{...}
{p2col:{bf:agent_ids()} {hline 2}}returns agent ids of all agents living in a
given cell.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:agent_id(}{it:real scalar r}, {it:real scalar c}{cmd:)}

{p 8 12 2}
{it:real rowvector} 
{cmd:agent_id(}{it:real scalar r}, {it:real scalar c}, {it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:agent_id()} returns the agent ids for all the agents living in the specified 
cell. Depending on whether the grid changed over the iteration 
({help abm_grid_rdim:tdim()}) the coordinates differs. 

{pmore}
The coordinates consists of the row ({it:r}) and column number ({it:c}) if 
{cmd:tdim} has been set to 0, or not set at all. 

{pmore}
The coordinates consist of the row ({it:r}), column ({it:c}), and iteration 
number ({it:t}) if {cmd:tdim} has been set to a number larger than 0. 


{title:Remarks}

{p 4 4 2}
{cmd:agent_ids()} and {help abm_grid_agent_id:agent_id()} will give the 
same result if the maximum number of agents ({help abm_grid_rdim:idim()}) has 
been set to 1 or not set at all. In that case {help abm_grid_agent_id:agent_id()}
will be slightly faster. 


{marker conformability}{...}
{title:Conformability}

    {cmd:agent_ids(}{it:r}, {it:c}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:r}:       1 {it:x} 1
           {it:c}:       1 {it:x} 1

    {cmd:agent_ids(}{it:r}, {it:c}, {it:t}{cmd:)}:
           {it:result}:  1 {it:x} {it:k}
           {it:r}:       1 {it:x} 1
           {it:c}:       1 {it:x} 1
           {it:t}:       1 {it:x} 1
		   
   		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:agent_ids()} aborts with an error if {help abm_grid_setup:setup()} has not 
been run first.

{p 4 4 2}
{cmd:agent_ids()} aborts with an error if {it:r} or {it:c} is not an integer, or is 
less than or equal to 0, or is more than {help abm_grid_rdim:rdim}, and
{help abm_grid_rdim:cdim} respectively.

{p 4 4 2}
{cmd:agent_ids()} aborts with an error if {it:t} is not an integer, or is less 0, 
or is more than {help abm_grid_rdim:tdim}.

{p 4 4 2}
{cmd:agent_ids()} aborts with an error if {it:t} has been specified while 
{help abm_grid_rdim:tdim} has been set to 0.
