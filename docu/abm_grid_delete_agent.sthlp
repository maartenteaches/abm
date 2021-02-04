{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_delete_agents" "help abm_grid_delete_agents"}{...}
{p2colset 1 19 21 2}{...}
{p2col:{bf:delete_agent()} {hline 2}}deletes an agent at a given cell.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:delete_agent(}{it:real scalar r}, {it:real scalar c}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:delete_agent(}{it:real scalar r}, {it:real scalar c}, 
{it:real scalar t}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:delete_agent(}{it:real scalar r}, {it:real scalar c}, 
{it:real scalar t}, {it:real scalar i}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:delete_agent()} deletes an agent at a given coordinate. deleting an agent
means that the agent_id is removed from that coordinate. The coordinate 
depends on how the grid has been set up:

{pmore}
The coordinate consist of the row ({it:r}) and column number ({it:c}) if 
{cmd:tdim} has been set to 0, or not set at all and {cmd:idim} has been set to 1
or not set at all. 

{pmore}
The coordinate consist of the row ({it:r}), column ({it:c}), and iteration 
number ({it:t}) if {cmd:tdim} has been set to a number larger than 0 and 
{cmd:idim} has been set to 1 or not set at all. 

{pmore}
The coordinate consist of the row ({it:r}), column ({it:c}), iteration ({it:t}),
and location ({it:i}) number if {cmd:idim} has been set to either zero or a 
number larger than 1. If {cmd:tdim} has been set to 0, or not set at all, then
the iteration number ({it:t}) in the coordinate needs to be specified as 
missing ({cmd:.}).


{title:Remarks}

{p 4 4 2}
{cmd:delete_agent()} only removes the agent from the grid. Typically there is a
separate {help mf_associativearray:associative array} that stores the properties
of the agents. {cmd:delete_agent()} does not touch that separate associative 
array.


{marker conformability}{...}
{title:Conformability}

    {cmd:delete_agent(}{it:r}, {it:c}{cmd:)}:
           {it:result}:   {it:void}
           {it:r}:        1 {it:x} 1
           {it:c}:        1 {it:x} 1

    {cmd:create_agent(}{it:r}, {it:c}, {it:t}{cmd:)}:
           {it:result}:   {it:void}
           {it:r}:        1 {it:x} 1
           {it:c}:        1 {it:x} 1
           {it:t}:        1 {it:x} 1

    {cmd:create_agent(}{it:r}, {it:c}, {it:t}, {it:i}{cmd:)}:
           {it:result}:   {it:void}
           {it:r}:        1 {it:x} 1
           {it:c}:        1 {it:x} 1
           {it:t}:        1 {it:x} 1
           {it:i}:        1 {it:x} 1
		   
   		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:delete_agent()} aborts with an error if {help abm_grid_setup:setup()} has not 
been run first.

{p 4 4 2}
{cmd:delete_agent()} aborts with an error if no agent exists at that coordinate.

{p 4 4 2}
{cmd:delete_agent()} aborts with an error if {it:r} or {it:c} is not an integer, or is 
less than or equal to 0, or is more than {help abm_grid_rdim:rdim}, and
{help abm_grid_rdim:cdim} respectively.

{p 4 4 2}
{cmd:delete_agent()} aborts with an error if {it:t} is not an integer, or is less 0, 
or is more than {help abm_grid_rdim:tdim}.

{p 4 4 2}
{cmd:delete_agent()} aborts with an error if {it:t} has been specified while 
{help abm_grid_rdim:tdim} has been set to 0.

{p 4 4 2}
{cmd:delete_agent()} aborts with an error if {it:i} is not an integer, or is
less than or equal to 0

{p 4 4 2} 
{cmd:delete_agent()} aborts with an error if {it:i} is more than 
{help abm_grid_rdim:idim} and {cmd:idim} has not been set to 0.

{p 4 4 2}
{cmd:delete_agent()} aborts with an error if {it:i} has been specified while 
{help abm_grid_rdim:idim} has been set to 1.
