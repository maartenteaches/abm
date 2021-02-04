{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 16 18 2}{...}
{p2col:{bf:find_line()} {hline 2}}returns the coordinates of all cells on a line.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} 
{cmd:find_line(}{it:real rowvector orig}, {it:real rowvector dest} {cmd:)}

{p 8 12 2}
{it:real matrix} 
{cmd:find_line(}{it:real rowvector orig}, {it:real rowvector dest} , {it:string scalar what}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:find_line()} returns the coordinates of the cells on a straight line from 
the cell {it:orig} to the cell {it:dest}. 


{title:Remarks}

{p 4 4 2}
Which cells are on that line depends 
on whether an agent can move only horizontally and vertically, or also 
diagonally. By default, if {help abm_grid_neumann:neumann} has been set to zero
diagonal moves are allowed, while diagonal moves are not allowed when {it:neumann}
has been set to 1. This default can be overwritten by specifying the {it:what}
option to either "{it:{ul:ortho}gonal}" (no diagonal moves allowed) or 
"{it:{ul:inter}polate}" (diagonal moves allowed).

{p 4 4 2}
{cmd:find_line()} respects whether the grid wraps around or not. If the grid 
wraps around ({help abm_grid_torus :torus} has been set to 1) then {cmd:find_line()} 
will return the shortest line, which could move off one border and appear again
on an opposite border. 


{marker conformability}{...}
{title:Conformability}

    {cmd:find_line(}{it:orig}, {it:dest}{cmd:)}:
           {it:result}:  {it:k x} 2
           {it:orig}:    1 {it:x} 2
           {it:dest}:    1 {it:x} 2

    {cmd:find_line(}{it:orig}, {it:dest}, {it:what}{cmd:)}:
           {it:result}:  {it:k x} 2
           {it:orig}:    1 {it:x} 2
           {it:dest}:    1 {it:x} 2
           {it:what}:    1 {it:x} 1
		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:find_line()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.

{p 4 4 2}
{cmd:find_line()} aborts with an error if either {it:orig} or {it:dest} is not a
valid coordinate on the grid.

{p 4 4 2}
{cmd:find_line()} aborts with an error if {it:what} contains something other than
orthogonal or interpolate. Either can be abreviated to ortho and inter.

