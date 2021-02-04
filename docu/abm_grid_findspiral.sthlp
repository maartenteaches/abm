{smcl}
{* *! version 0.1.0 22Jan2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 16 18 2}{...}
{p2col:{bf:find_spiral} {hline 2}} return coordinates of a spiral of neighbouring cells{p_end}
{p2colreset}{...}

{marker findring_syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real matrix} {cmd:find_spiral(}{it:real scalar r}, {it:real scalar c}, 
    {it:real scalar radius}{cmd:)}
	
{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:find_spiral()} returns a {it:k} {it:x} 2 matrix with the coordinates of the 
{it:k} neighbouring cells that are {it:radius} steps or less removed from the
focal cell ({it:r}, {it:c}). 


{title:Remarks}

{p 4 4 2}
There are two common ways of defining cells {it: radius} steps removed from the 
origin cell. The first one, often called a Moore neighbourhood, allows horizontal,
vertical and diagonal steps. This is the default, and can be changed using the 
{help abm_grid_neumann:neumann()} function. The second one, often called the
Von Neumann neighbourhood, only allows horizontal and vertical steps. The spirals
for a radius of two for these different types of neighbourhoods are shown below.
The {cmd:o} is the origin, the numbers represent the order in which the selected 
cells appear in the returned matrix, and the {cmd:.}s are the non-selected cells. 

         Moore         Von Neumann

    17 18 19 20 21    .  . 11  .  .
    16  5  6  7 22    . 10  4 12  .
    15  4  o  8 23    9  3  o  1  5
    14  3  2  1 24    .  8  2  6  .
    13 12 11 10  9    .  .  7  .  .
	

{marker conformability}{...}
{title:Conformability}

    {cmd:find_spiral(}{it:r}, {it:c}, {it:radius}{cmd:)}:
             {it:r}:  1 {it:x} 1
             {it:c}:  1 {it:x} 1
        {it:radius}:  1 {it:x} 1
        {it:result}:  {it:k} {it:x} 2


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:find_spiral()} returns a 0 {it:x} 2 matrix containing . if there are no
neighbours {it:radius} or less steps removed.

{p 4 4 2}
{cmd:find_spiral()} aborts with an error if {help abm_grid_setup:setup()} has 
not been run first.
		