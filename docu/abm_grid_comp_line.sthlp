{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid_protected"}{...}
{p2colset 1 16 18 2}{...}
{p2col:{bf:comp_line()} {hline 2}}returns the coordinates of all cells on a line 
for use in {cmd:find_line()}.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} 
{cmd:comp_line(}{it:real rowvector orig}, {it:real rowvector dest} , {it:string scalar what}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:comp_line()} returns the coordinates of the cells on a straight line from 
the cell {it:orig} to the cell {it:dest}. It is intended as a sub-routine for 
{help abm_grid_find_line: find_line()}. {cmd:comp_line()} does not check the 
arguments, or takes into account that the grid may be a torus.


{marker conformability}{...}
{title:Conformability}

    {cmd:comp_line(}{it:orig}, {it:dest}, {it:what}{cmd:)}:
           {it:result}:  {it:k x} 2
           {it:orig}:    1 {it:x} 2
           {it:dest}:    1 {it:x} 2
           {it:what}:    1 {it:x} 1