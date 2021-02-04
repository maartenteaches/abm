{smcl}
{* *! version 0.1.0 22Jan2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 13 15 2}{...}
{p2col:{bf:find_ring} {hline 2}} return coordinates of a ring of neighbouring cells{p_end}
{p2colreset}{...}

{marker findring_syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} {cmd:find_ring(}{it:real scalar r}, {it:real scalar c}, 
    {it:real scalar radius}{cmd:)}
	
{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:find_ring()} returns a {it:k} {it:x} 2 matrix with the coordinates of the 
{it:k} neighbouring cells that form a ring of radius {it:radius} around the cell 
({it:r}, {it:c}).


{title:Remarks}

{p 4 4 2}
There are two common ways of defining cells {it: radius} steps removed from the 
origin cell. The first one, often called a Moore neighbourhood, allows horizontal,
vertical and diagonal steps. This is the default, and can be changed using the 
{help abm_grid_neumann:neumann()} function. The second one, often called the
Von Neumann neighbourhood, only allows horizontal and vertical steps. The rings
for a radius of two for these different types of neighbourhoods are shown below.
The {cmd:o} is the origin, the numbers represent the order of the selected cells
as they appear in the output, and the {cmd:.}s are the non-selected cells. 

         Moore        Von Neumann

      9 10 11 12 13    . . 7 . .
      8  .  .  . 14    . 6 . 8 .
      7  .  o  . 15    5 . o . 1
      6  .  .  . 16    . 4 . 2 .
      5  4  3  2  1    . . 3 . .
	

{marker conformability}{...}
{title:Conformability}

    {cmd:find_ring(}{it:r}, {it:c}, {it:radius}{cmd:)}:
             {it:r}:  1 {it:x} 1
             {it:c}:  1 {it:x} 1
        {it:radius}:  1 {it:x} 1
        {it:result}:  {it:k} {it:x} 2


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:find_ring()} returns a 0 {it:x} 2 matrix containing . if there are no
neighbours exactly {it:radius} steps removed.

{p 4 4 2}
{cmd:find_ring()} aborts with an error if {help abm_grid_setup:setup()} has 
not been run first.
		