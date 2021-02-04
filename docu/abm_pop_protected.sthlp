{smcl}
{* *! version 1.0.0 27Jan2021 MLB}{...}
{vieweralsosee "help abm_pop" "help abm_pop"}{...}
{phang}
{bf:abm_pop class} {hline 2} protected functions and variable in the abm_pop class{p_end}

{marker description}{...}
{title:Description}

{pstd}
The {cmd:abm_pop} class has {help abm_pop:public functions}, but there are 
also a number of protected functions and variables that are used internally 
but the user cannot access directly. However, if a user creates a new class 
that inherits from {cmd:abm_pop}, then, within that new class, the user does 
have access to these protected functions and variables. This can be helpful 
if your agent based model requires an additional function or that existing 
functions work differently.


{p2colset 8 24 26 8}{...}
{p2line -2 0}
{p2col 6 23 25 8:{it:Protected functions}}{p_end}
{p2col:{helpb abm_pop_get_t:get_t()}}for a given agent and characteristic get
the time of {it:k}th element{p_end}
{p2col:{helpb abm_pop_get_t:get_c()}}for a given agent and characteristic get
the content of {it:k}th element{p_end}

{p2col 6 23 25 8:{it:Protected variables}}{p_end}
{p2col:{helpb abm_pop_get_t:pop}}Pointer matrix storing the data{p_end}
{p2col:{bf:N}}number of agents{p_end}
{p2col:{bf:k}}number of characteristics{p_end}
{p2line -2 0}

{pstd}
In addition, {cmd:abm_pop} inherits protected functions from the 
{help abm_chk}, and {help abm_bc_protected:abm_bc} classes. 
