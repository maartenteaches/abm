{smcl}
{* *! version 1.0.0 01Feb2021 MLB}{...}
{vieweralsosee "help abm_pop" "help abm"}{...}
{phang}{cmd:abm_bc} {hline 2} Class to help with backwards compatability{p_end}

{marker description}{...}
{title:Description}

{p 4 4 2}
The {cmd:abm_bc} class is intended to be inherrited by other {cmd:abm} classes,
in particular {help abm_pop}, {help abm_grid}, or {help abm_nw}, to help with 
backwards compatability. If the {cmd:abm} classes are improved, these 
improvements can break existing Agent Based Models that were written with 
older versions. To prevent that, the writers of those models should set the
version for each instance of every {cmd:abm} class used. That way the 
improvements that would break your model are roled back. So by setting the 
version one can safely update the {cmd:abm} package, without it breaking your
existing models. 

{pstd}
After inherriting the {cmd:abm_bc} class the child classes will have two extra
public functions: 

{phang}
{help abm_bc_abm_version:abm_version()}: for setting the version of {cmd:abm} 
used in your model.

{phang}
{help abm_bc_abm_version:abm_current()}: to show the current version of {cmd:abm}
on your machine.

{pstd}
In addition, there will also be a number of {help abm_bc_protected:protected functions}
available inside the child classes.
