{smcl}
{* *! version 1.0.0 27Jan2021 MLB}{...}
{vieweralsosee "help abm_pop protected" "help abm_pop_protected"}{...}
{vieweralsosee "help abm_nw protected" "help abm_nw_protected"}{...}
{vieweralsosee "help abm_grid protected" "help abm_grid_protected"}{...}
{phang}
{bf:abm_bc class} {hline 2} protected functions and variable in the abm_bc class{p_end}

{marker description}{...}
{title:Description}

{pstd}
The {cmd:abm_bc} class is used by the {help abm_pop}, {help abm_grid}, and 
{help abm_nw} classes to help maintain backwards compatability. As these 
classes continue to be develped, changes in these classes could break models 
created with these classes. To prevent that, the creator of these models 
should specify the version of {bf:abm} used to make that model with the 
{help abm_bc_abm_version: abm_version()} function for each instance of these 
classes. 

{pstd}
The {cmd:abm_bc} class has {help abm_bc_abm_version:public functions} that 
are inherrited by the {cmd:abm_pop}, {cmd:abm_grid}, and {cmd:abm_nw} classes.
However, there are also a number of protected functions and variables that 
are used internally but the user cannot access directly. However, if a user 
creates a new class that inherits from {cmd:abm_bc} {cmd:abm_pop}, 
{cmd:abm_grid}, and {cmd:abm_nw}, then, within that new class, the user does 
have access to these protected functions and variables. This can be helpful 
if your agent based model requires an additional function or that existing 
functions work differently.

{pstd}
In other words, this helpfile is only useful to those who wish to understand
or change what is happening inside the {help abm_pop}, {help abm_grid}, and 
{help abm_nw} classes. If you just want to use these classes to create your 
own Agent Based Model, then {help abm_bc_abm_version: abm_version()} contains 
all the information you need.

{p2colset 8 24 26 8}{...}
{p2line -2 0}
{p2col 6 23 25 8:{it:Protected functions}}{p_end}
{p2col:{helpb abm_bc_mod_geq:mod_geq()}}returns whether (1) or not (0) the
stored version number is greater than or equal to the argument.{p_end}
{p2col:{helpb abm_bc_mod_geq:mod_gt()}}returns whether (1) or not (0) the
stored version number is greater than the argument.{p_end}
{p2col:{helpb abm_bc_mod_geq:mod_leq()}}returns whether (1) or not (0) the
stored version number is less than or equal to the argument.{p_end}
{p2col:{helpb abm_bc_mod_geq:mod_lt()}}returns whether (1) or not (0) the
stored version number is less than the argument.{p_end}
{p2col:{helpb abm_bc_setup:setup()}}sets the version number to the current
version of {cmd:abm} if it has not been set.{p_end}
{p2col:{helpb abm_bc_parse_version:parse_version()}}Parses a string that 
should contain a version number{p_end}

{p2col 6 23 25 8:{it:Protected variables}}{p_end}
{p2col:{bf:mod_version}}version number as a three column real vector.{p_end}
{p2line -2 0}
