{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 17 19 2}{...}
{p2col:{bf:free_spot()} {hline 2}}returns a free location number inside a cell.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:free_spot(}{it:real scalar r}, {it:real scalar c}, 
{it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
If multple agents can occupy the same cell, then each aget will have its own 
"adress" inside that cell: its location number. The full adress of an agents is 
{it:r}, {it:c}, {it:t}, {it:i}, whereby the cell is identified by the row and 
column number ({it:r} and {it:c}, respectively), the point in time by {it:t}, 
the location in that cell by {it:i}. {cmd:free_spot} returns a free location 
inside the cell {it:r}, {it:c}, {it:t}. If there are no free locations left it
will return a missing value.

{marker conformability}{...}
{title:Conformability}

    {cmd:free_spot(}{it:r}, {it:c}, {it:t}{cmd:)}:
           {it:result}:    1 {it:x} 1
           {it:r}:         1 {it:x} 1
           {it:c}:         1 {it:x} 1
           {it:t}:         1 {it:x} 1
		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:free_spot()} aborts with an error if {help abm_grid_setup:setup()} has not 
been run first.

{p 4 4 2}
{cmd:free_spot()} aborts with an error if {it:r}, or {it:c}
 is not an integer, or is less than or equal to 0, or is more than 
{help abm_grid_rdim:rdim}, and {help abm_grid_rdim:cdim} respectively.

{p 4 4 2}
{cmd:free_spot()} aborts with an error if {it:t}, is not an 
integer, or is less 0, or is more than {help abm_grid_rdim:tdim}.
