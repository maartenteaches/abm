{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_agent_ids" "help abm_grid_agent_ids"}{...}
{p2colset 1 15 17 2}{...}
{p2col:{bf:agent_id()} {hline 2}}returns the agent id of the agent living in a
given cell.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:agent_id(}{it:real scalar r}, {it:real scalar c}{cmd:)}

{p 8 12 2}
{it:real scalar} 
{cmd:agent_id(}{it:real scalar r}, {it:real scalar c}, {it:real scalar t}{cmd:)}

{p 8 12 2}
{it:real scalar} 
{cmd:agent_id(}{it:real scalar r}, {it:real scalar c}, {it:real scalar t}
, {it:real scalar i}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:agent_id()} returns the agent id for the agent living in the specified 
location on the specified cell. Depending on whether multiple agents are allowed
to occupy the same cell ({help abm_grid_rdim:idim()}) and whether the grid 
changed over the iteration ({help abm_grid_rdim:tdim()}), the 
coordinates differs. 

{pmore}
The coordinates consists of the row ({it:r}) and column number ({it:c}) if 
{cmd:tdim} has been set to 0, or not set at all and {cmd:idim} was set to 1 or
not set at all. 

{pmore}
The coordinates consist of the row ({it:r}), column ({it:c}), and iteration 
number ({it:t}) if {cmd:tdim} has been set to a number larger than 0 and 
{cmd:idim} was set to 1 or not set at all.

{pmore}
The coordinates consist of the row ({it:r}), column ({it:c}), iteration ({it:t}),
and location number ({it:i}) if {cmd:idim} was set to 0 (no upper bound on the 
number of agents per cell) or a number larger than 1. If {cmd:tdim} is set to 0, 
then the iteration number is always a missing value ({cmd:.}).

{pstd}
{cmd:agen_id()} returns a missing value if no agent lives at the given address.


{title:Remarks}

{p 4 4 2}
The agent id and its location in the grid are the only things about the agent 
that are stored in the grid. Typically you'll want to store other 
characteristics of the agent, which you would do in another 
{help mf_associativearray:associative array}. The agent id will be (part of) the 
key that lets you access those agent characteristics. 


{marker conformability}{...}
{title:Conformability}

    {cmd:agent_id(}{it:r}, {it:c}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:r}:       1 {it:x} 1
           {it:c}:       1 {it:x} 1

    {cmd:agent_id(}{it:r}, {it:c}, {it:t}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:r}:       1 {it:x} 1
           {it:c}:       1 {it:x} 1
           {it:t}:       1 {it:x} 1
		   
    {cmd:agent_id(}{it:r}, {it:c}, {it:t}, {it:i}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:r}:       1 {it:x} 1
           {it:c}:       1 {it:x} 1
           {it:t}:       1 {it:x} 1
           {it:i}:       1 {it:x} 1
   		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:agent_id()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.

{p 4 4 2}
{cmd:agent_id()} aborts with an error if {it:r} or {it:c} is not an integer, or is 
less than or equal to 0, or is more than {help abm_grid_rdim:rdim}, and
{help abm_grid_rdim:cdim} respectively.

{p 4 4 2}
{cmd:agent_id()} aborts with an error if {it:t} is not an integer, or is less 0, 
or is more than {help abm_grid_rdim:tdim}.

{p 4 4 2}
{cmd:agent_id()} aborts with an error if {it:i} is not an integer, or is less 
than or equal to 0, or is more than {help abm_grid_rdim:idim} if {cmd:idim} is
larger than 1.

{p 4 4 2}
{cmd:agent_id()} aborts with an error if {it:t} has been specified while 
{help abm_grid_rdim:tdim} has been set to 0 and {help abm_grid_rdim:idim} has 
been set to 1.

{p 4 4 2}
{cmd:agent_id()} aborts with an error if {it:i} has been specified while 
{help abm_grid_rdim:idim} has been set to 1.
