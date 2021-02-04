{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 11 13 2}{...}
{p2col:{bf:dist()} {hline 2}}returns the distance between two cells.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:dist(}{it:real rowvector orig}, {it:real rowvector dest} {cmd:)}

{p 8 12 2}
{it:real scalar} 
{cmd:dist(}{it:real rowvector orig}, {it:real rowvector dest} , {it:string scalar what}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:dist()} returns the distance between the cell {it:orig} to the cell 
{it:dest}. 

{title:Remarks}

{p 4 4 2}
By default, the distance is defined as the minimum number of steps an 
agent needs to make in order to move from {it:orig} to {it:dest}. This depends 
on whether or not diagonal steps are allowed. If {help abm_grid_neumann:neumann} 
has been set to zero diagonal moves are assumed to be allowed, while diagonal 
moves are assumed to be not allowed when {it:neumann} has been set to 1. This 
default can be overwritten by specifying the {it:what} option to either 
"{it:{ul:cheb}ishev}" (diagonal moves allowed), 
"{it:{ul:man}hattan}" (diagonal moves not allowed), or "{it:{ul:eucl}edian}" 
(eucledian distance).

{p 4 4 2}
{cmd:dist()} respects whether the grid wraps around or not. If the grid 
wraps around ({help abm_grid_torus :torus} has been set to 1) then {cmd:dist()} 
will return the shortest distance, which could be on a line that moves off one 
border and appear again on an opposite border. 


{marker conformability}{...}
{title:Conformability}

    {cmd:dist(}{it:orig}, {it:dest}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:orig}:    1 {it:x} 2
           {it:dest}:    1 {it:x} 2

    {cmd:dist(}{it:orig}, {it:dest}, {it:what}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:orig}:    1 {it:x} 2
           {it:dest}:    1 {it:x} 2
           {it:what}:    1 {it:x} 1
		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:dist()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.

{p 4 4 2}
{cmd:dist()} aborts with an error if either {it:orig} or {it:dest} is not a
valid coordinate on the grid.

{p 4 4 2}
{cmd:dist()} aborts with an error if {it:what} contains something other than
chebishev, manhattan, or eucledian. These can be abreviated to cheb, man, and 
eucl respectively.

