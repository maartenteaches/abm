{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 13 15 2}{...}
{p2col:{bf:setup()} {hline 2}}sets defaults, and creates the necessary variables.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}


{p 8 12 2}
{it:void} {cmd:setup()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:setup()} creates the necessary internal variables for the grid using the 
settings set by the {help abm_grid_rdim:rdim()}, {help abm_grid_rdim:cdim()}, 
{help abm_grid_rdim:tdim()}, {help abm_grid_rdim:idim()}, 
{help abm_grid_neumann:neumann()}, {help abm_grid_torus:torus()}, and 
{help abm_grid_randit:randit()} functions. Of these settings only {cmd:rdim} and 
{cmd:cdim} must be set, all other setting have a default. These defaults will be 
set by {cmd:setup()}

{pmore}
If {cmd:tdim} has not been set, then {cmd:setup()} will set it to 0, that is, 
there is only one grid that does not change from iteration to iteration. This 
makes sense when the agents have a fixed position in the grid and don't move. 

{pmore}
if {cmd:idim} has not been set, then {cmd:setup()} will set it to 1, that is,
only one agent per cell is allowed.

{pmore}
If {cmd:neumann} has not been set, then {cmd:setup()} will set it to 0, that is,
it will use a Moore neighbourhood.

{pmore}
If {cmd:torus} has not been set, then {cmd:setup()} will set it to 0, that is, 
the grid does not wrap around.

{pmore}
If {cmd:randit} has not been set, then {cmd:setup()} will set it to 0, that is,
{cmd:schedule()} will return a list of coordinates of all cells in a fixed order.


{title:Remarks}

{pstd}
The order in which you use the {cmd:abm_grid} class is to first create an 
instance that class, set the settings, then run {cmd:setup()}. Only after that
can one assign agents to cells, find neighbours, etc. 

{marker conformability}{...}
{title:Conformability}

    {cmd:setup()}:
           {it:result}:  {it:void}

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:setup()} aborts with an error if {cmd:rdim} or {cmd:cdim} have not been set 
previously.
