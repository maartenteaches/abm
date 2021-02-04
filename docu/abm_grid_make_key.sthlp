{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid_protected"}{...}
{p2colset 1 16 18 2}{...}
{p2col:{bf:make_key()} {hline 2}}create the key/coordinates for a particular 
location in a cell.
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}


{p 8 12 2}
{it:real rowvector} {cmd:make_key(}{it:real scalar r}, {it:real scalar c},
{it:real scalar t}, {it:real scalar i}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:make_key()} receives the row, column, iteration, and location number, 
checks those arguments, fills them with appropriate defaults when necessary and 
returns the key for the associative array {cmd:universe}.


{title:Remarks}

{p 4 4 2}
The {cmd:abm_grid} class stores the grid in the four dimensional associative 
array {cmd:universe}. The key consists of 4 numbers: row, column, iteration, and 
location within cell number. However, most public functions allow you to ignore
parts of these coordinates if your settings imply that they would make no sense. 

{pmore}
You can refer to a cell by just its row and column number if you set the number 
of iteration to 0 ({help abm_grid_rdim:tdim}=0) and the maximum number of agents
per cell to 1 ({help abm_grid_rdim:idim}=1).

{pmore}
You can refer to a cell by the row, column and iteration number if you set the 
number of iterations to a number larger than 0 and the maximum number of agents
to 1

{pmore}
You cannot ignore the iteration number when the maximum number of agents per 
cell is larger than 1. This means that you have to specify the iteration number 
as missing ({cmd:.}) if you set the number of iterations 0 and the maximum number 
of agents in a cell to free ({help abm_grid_rdim:idim}=0) or to a number larger 
than 1.

{p 4 4 2}
The {cmd:make_key()} function takes the row, column, iteration, and location 
numbers as received by the public functions, which could be missing when they
were not specified, and turns them into a valid key for the associative array
{cmd:universe}. It also checks those numbers.


{marker conformability}{...}
{title:Conformability}

    {cmd:make_key(}{it:r}, {it:c}, {it:t}, {it:i}{cmd:)}:
           {it:r}     :   1 {it:x} 1
           {it:c}     :   1 {it:x} 1
           {it:t}     :   1 {it:x} 1
           {it:i}     :   1 {it:x} 1
           {it:result}:   1 {it:x} 4

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:make_key()} aborts with an error if {help abm_grid_setup:setup()} has not been
run first.

{p 4 4 2}
{cmd:make_key()} aborts with an error if {it:r} or {it:c} is not an integer, or is 
less than or equal to 0, or is more than {help abm_grid_rdim:rdim}, and
{help abm_grid_rdim:cdim} respectively.

{p 4 4 2}
{cmd:make_key()} aborts with an error if {it:t} is not an integer, or is less 0, 
or is more than {help abm_grid_rdim:tdim}.

{p 4 4 2}
{cmd:make_key()} aborts with an error if {it:i} is not an integer, or is less 
than or equal to 0, or is more than {help abm_grid_rdim:idim} if {cmd:idim} is
larger than 1.

{p 4 4 2}
{cmd:make_key()} aborts with an error if {it:t} is not a missing value while 
{help abm_grid_rdim:tdim} has been set to 0 and {help abm_grid_rdim:idim} has 
been set to 1.

{p 4 4 2}
{cmd:make_key()} aborts with an error if {it:i} is not a missing value while 
{help abm_grid_rdim:idim} has been set to 1.
