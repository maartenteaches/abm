{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid protected"}{...}
{p2colset 1 16 18 2}{...}
{p2col:{bf:agent_loc()} {hline 2}}returns a rowvector of location numbers containing
agents for a particular cell
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:rowvector} 
{cmd:agent_loc(}{it:real scalar r}, {it:real scalar c}, {it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
A particular cell (identified by a row and column number) at a particular 
iteration (identified by the iteration number) can contain multiple agents if 
{help abm_grid_rdim:idim} has been set to 0 or a number larger than 1. Each of 
these agents is stored at a "location" with a location number within the cell.
The {cmd:agent_loc()} function returns a rowvector with all location numbers that
contain an agent, which will be {cmd:J(1,0,.)} if no agents live at that cell.


{marker conformability}{...}
{title:Conformability}

    {cmd:agent_loc(}{it:r}, {it:c}, {it:t}{cmd:)}:
                {it:r}:   1 {it:x} 1
                {it:c}:   1 {it:x} 1
                {it:t}:   1 {it:x} 1
           {it:result}:   1 {it:x k} 

