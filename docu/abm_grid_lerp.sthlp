{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid_protected"}{...}
{p2colset 1 11 13 2}{...}
{p2col:{bf:lerp()} {hline 2}}returns the closest cell that is {it:t} between 
{it:orig} and {it:dest}.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real rowvector} 
{cmd:dist(}{it:real rowvector orig}, {it:real rowvector dest}, {it:real scalar t} {cmd:)} 

{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:dist()} returns the closest cell that the fraction {it:t} between the cells
{it:orig} and {it:dest}. 


{marker conformability}{...}
{title:Conformability}

    {cmd:lerp(}{it:orig}, {it:dest}, {it:t}{cmd:)}:
           {it:result}:  1 {it:x} 2
           {it:orig}:    1 {it:x} 2
           {it:dest}:    1 {it:x} 2
           {it:what}:    1 {it:x} 1
		   
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:lerp()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.

{p 4 4 2}
{cmd:lerp()} aborts with an error if either {it:orig} or {it:dest} is not a
valid coordinate on the grid.



