{smcl}
{* *! version 1.0.0 02Feb2021 MLB}{...}
{vieweralsosee "abm_pop protected" "help abm_pop_protected"}{...}
{vieweralsosee "abm_pop" "help abm_pop"}{...}

{phang}
{bf:get_t() and get_c} {hline 2} Extracting time and content

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:get_t(}{it:real scalar row}, {it:real scalar col}, {it:real scalar i}{cmd:)}

{p 8 12 2}
{it:transmorphic}
{cmd:get_c(}{it:real scalar row}, {it:real scalar col}, {it:real scalar i}{cmd:)}


{marker description}{...}
{title:Description}

{pstd}
An instance of an {cmd:abm_pop} class stores it content in a 
{help [M-2] pointers:pointer} matrix {it:pop}, where the rows are the 
agents and the columns are the characteristics (variables). Initially, 
these are all NULL pointers, i.e. they point at nothing. The first time 
something is stored for a given cell, the pointer will point to a 2x1 
pointer matrix, where the top row points at the content that is should 
be stored, and the second row points at a scalar indicating when this 
change took place. If new content is stored for that cell, then a new 
column of pointers will be added in front the existing matrix. So the 
pointer to the most recent content is stored in cell (1,1). 

{pstd}
The {cmd:get_t()} and {cmd:get_c()} functions extract the time and 
content respectively based on the row (agent) and column (characteristic) 
number of the matrix {it:pop}, and column number of the matrix that that
cell points to. 


{marker conformability}{...}
{title:Conformability}

    {cmd:get_t(}{it:row}, {it:col}, {it:i}{cmd:)}:
           {it:result}:  1 {it:x} 1
           {it:row}      1 {it:x} 1
           {it:col}      1 {it:x} 1
           {it:i}        1 {it:x} 1

    {cmd:get_c(}{it:row}, {it:col}, {it:i}{cmd:)}:
           {it:result}:  {it:transmorphic}
           {it:row}      1 {it:x} 1
           {it:col}      1 {it:x} 1
           {it:i}        1 {it:x} 1
