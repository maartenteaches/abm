{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_grid" "help abm_grid"}{...}
{p2colset 1 35 37 2}{...}
{p2col:{bf:tdim(), rdim(), cdim(), idim()} {hline 2}}return or set the number or iteration,
number of rows, number of columns, and maximum number of agents in a cell
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar} 
{cmd:rdim()}

{p 8 12 2}
{it:real scalar} 
{cmd:cdim()}

{p 8 12 2}
{it:real scalar} 
{cmd:tdim()}

{p 8 12 2}
{it:real scalar} 
{cmd:idim()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:rdim(}{it:real scalar dim}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:cdim(}{it:real scalar dim}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:tdim(}{it:real scalar dim}{cmd:)}

{p 8 12 2}
{it:void}{bind:       }
{cmd:idim(}{it:real scalar dim}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:rdim()} returns the number of rows in the grid, if it has been set 
previously, or {cmd:.} when not. {cmd:cdim()} returns the number of columns in 
the grid, if it has been set previously, or {cmd:.} when not. {cmd:tdim()} 
returns the number of iterations, if it has been set previously, or {cmd:.} when 
not. {cmd:idim()} returns the maximum number of agents in a cell, if it has been 
set previously, or {cmd:.} when not.

{p 4 4 2}
{cmd:rdim(}{it:dim}{cmd:)} sets or resets the number of rows in the grid. 
{it:dim} can be a positive integer. {cmd:cdim(}{it:dim}{cmd:)} sets or resets 
the number of columns in the grid. {it:dim} can be a positive integer. 
{cmd:tdim(}{it:dim}{cmd:)} sets or resets the number of iterations to {it:dim}.
{it:dim} can be zero or a positive integer. {cmd:idim(}{it:dim}{cmd:)} sets or
resets the maximum number of agents in a cell to {it:dim}. {it:dim} can be zero
or a positive integer, whereby zero means that there is no maximum. 


{title:Remarks}

{p 4 4 2}
If the number of iterations has not been set, then {help abm_grid_setup:setup()}
will set it to 0. If the number of iterations is set to 0 and the maximum number
of agents per cell is set to 1, the cells are later refered using only the row 
and column number. Otherwise, the cells are refered to using the row, column, and 
iteration number.

{p 4 4 2}
If the maximum number of agents has not been set, then 
{help abm_grid_setup:setup()} will set it to 1. If {cmd:idim} has been set to 0,
then that means no upper bound is set for the number of agents per cell. If 
multiple agents are allowed in a cell, then each agent has its own "location"
inside the cell, and the agents can be found using a four number "address": 
row number, column number, iteration number, location number. 


{marker conformability}{...}
{title:Conformability}

    {cmd:tdim()}:
           {it:result}:  1 {it:x} 1

    {cmd:rdim()}:
           {it:result}:  1 {it:x} 1

    {cmd:cdim()}:
           {it:result}:  1 {it:x} 1

    {cmd:idim()}:
           {it:result}:  1 {it:x} 1
		   
    {cmd:tdim(}{it:dim}{cmd:)}:
              {it:dim}:  1 {it:x} 1
           {it:result}:  {it:void}

    {cmd:rdim(}{it:dim}{cmd:)}:
              {it:dim}:  1 {it:x} 1
           {it:result}:  {it:void}
		   
    {cmd:cdim(}{it:dim}{cmd:)}:
              {it:dim}:  1 {it:x} 1
           {it:result}:  {it:void}
		   
    {cmd:idim(}{it:dim}{cmd:)}:
              {it:dim}:  1 {it:x} 1
           {it:result}:  {it:void}
		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:tdim()}, {cmd:rdim()}, {cmd:cdim(), {cmd:idim()}} returns {cmd:.} if the 
number of iterations, rows, columns, or maximum number of agents per cell have 
not been specified previously.

{p 4 4 2}
{cmd:tdim(}{it:dim}{cmd:)} and {cmd:idim(}{it:dim}{cmd:)}aborts with error if 
{it:dim} is not an integer or negative.

{p 4 4 2}
{cmd:rdim(}{it:dim}{cmd:)} and {cmd:cdim(}{it:dim}{cmd:)} aborts with error if 
{it:dim} is not an integer, or zero, or negative.

