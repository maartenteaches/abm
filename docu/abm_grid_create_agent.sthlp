{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 19 21 2}{...}
{p2col:{bf:create_agent()} {hline 2}}creates an agent at a given cell.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:create_agent(}{it:real scalar r}, {it:real scalar c}, 
{it:real scalar agent_id}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:create_agent(}{it:real scalar r}, {it:real scalar c}, 
{it:real scalar agent_id}, {it:real scalar t}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:create_agent(}{it:real scalar r}, {it:real scalar c}, 
{it:real scalar agent_id}, {it:real scalar t},
{it:real scalar i}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:create_agent()} creates an agent at a given coordinate. Creating an agents
means that the {it:agent_id} is stored at that coordinate. The coordinate at 
which the agent is stored depends on how the grid has been set up:

{pmore}
The coordinates consists of the row ({it:r}) and column number ({it:c}) if 
{cmd:tdim} has been set to 0, or not set at all and {cmd:idim} has been set to 1
or not set at all. 

{pmore}
The coordinates consist of the row ({it:r}), column ({it:c}), and iteration 
number ({it:t}) if {cmd:tdim} has been set to a number larger than 0 and 
{cmd:idim} has been set to 1 or not set at all. 

{pmore}
The coordinates consist of the row ({it:r}), column ({it:c}), iteration ({it:t}),
and location ({it:i}) number if {cmd:idim} has been set to either zero or a 
number larger than 1. If {cmd:tdim} has been set to 0, or not set at all, then
the iteration number ({it:t}) in the coordinate needs to be specified as 
missing ({cmd:.}).


{title:Remarks}

{p 4 4 2}
Agents typically have properties, but these are not stored in the grid. Instead
they have to be stored in a separate {help mf_associativearray:associative array} 
using the {it:agent_id} as part of the key. 


{marker conformability}{...}
{title:Conformability}

    {cmd:create_agent(}{it:r}, {it:c}, {it:agent_id}{cmd:)}:
           {it:result}:   {it:void}
           {it:r}:        1 {it:x} 1
           {it:c}:        1 {it:x} 1
           {it:agent_id}: 1 {it:x} 1

    {cmd:create_agent(}{it:r}, {it:c}, {it:agent_id}, {it:t}{cmd:)}:
           {it:result}:   {it:void}
           {it:r}:        1 {it:x} 1
           {it:c}:        1 {it:x} 1
           {it:agent_id}: 1 {it:x} 1
           {it:t}:        1 {it:x} 1

    {cmd:create_agent(}{it:r}, {it:c}, {it:agent_id}, {it:t}, {it:i}{cmd:)}:
           {it:result}:   {it:void}
           {it:r}:        1 {it:x} 1
           {it:c}:        1 {it:x} 1
           {it:agent_id}: 1 {it:x} 1
           {it:t}:        1 {it:x} 1
           {it:i}:        1 {it:x} 1
		   
   		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:create_agent()} aborts with an error if {help abm_grid_setup:setup()} has not 
been run first.

{p 4 4 2}
{cmd:create_agent()} aborts with an error if {it:r} or {it:c} is not an integer, or is 
less than or equal to 0, or is more than {help abm_grid_rdim:rdim}, and
{help abm_grid_rdim:cdim} respectively.

{p 4 4 2}
{cmd:create_agent()} aborts with an error if {it:t} is not an integer, or is less 0, 
or is more than {help abm_grid_rdim:tdim}.

{p 4 4 2}
{cmd:create_agent()} aborts with an error if {it:t} has been specified while 
{help abm_grid_rdim:tdim} has been set to 0.

{p 4 4 2}
{cmd:create_agent()} aborts with an error if {it:i} is not an integer, or is
less than or equal to 0

{p 4 4 2} 
{cmd:create_agent()} aborts with an error if {it:i} is more than 
{help abm_grid_rdim:idim} and {cmd:idim} has not been set to 0.

{p 4 4 2}
{cmd:create_agent()} aborts with an error if {it:i} has been specified while 
{help abm_grid_rdim:idim} has been set to 1.
