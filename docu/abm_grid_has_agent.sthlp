{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 16 18 2}{...}
{p2col:{bf:has_agent()} {hline 2}}returns whether or not an agent lives in a
given cell.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:has_agent(}{it:real scalar r}, {it:real scalar c}{cmd:)}

{p 8 12 2}
{it:real scalar} 
{cmd:has_agent(}{it:real scalar r}, {it:real scalar c}, {it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:has_agent()} returns a 1 when one or more agents live at the specified 
coordinate, and a 0 when that cell is empty. Depending on how 
{help abm_grid_rdim:tdim()} has been setup, the coordinates of the cell consist 
of the row and column number (if {cmd:tdim} has been set to 0, or not set at 
all) or the row , column, and iteration number (if {cmd:tdim} has been set to a 
number larger than 0).


{marker conformability}{...}
{title:Conformability}

    {cmd:has_agent(}{it:r}, {it:c}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:r}:       1 {it:x} 1
           {it:c}:       1 {it:x} 1

    {cmd:has_agent(}{it:r}, {it:c}), {it:t}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:r}:       1 {it:x} 1
           {it:c}:       1 {it:x} 1
           {it:t}:       1 {it:x} 1
		   
   		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:has_agent()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.

{p 4 4 2}
{cmd:has_agent()} aborts with an error if {it:r}, {it:c}, or {it:t} is not an 
integer, or is less than or equal to 0, or is more than 
{help abm_grid_rdim:rdim}, {help abm_grid_rdim:cdim}, or 
{help abm_grid_rdim:tdim} respectively.

{p 4 4 2}
{cmd:has_agent()} aborts with an error if {it:t} has been specified while 
{help abm_grid_rdim:tdim} has been set to 0.
