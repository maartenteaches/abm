{smcl}
{* *! version 1.0.0 02Feb2021 MLB}{...}
{vieweralsosee "help abm_bc protected" "help abm_bc_protected"}{...}
{phang}
{cmd:bc_setup()} {hline 2} sets the default version{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:bc_setup()}


{marker description}{...}
{title:Description}

{pstd}
If the version has not been set (using {help abm_bc_abm_version:abm_version()}), 
then {cmd:bc_setup()} will set the version to the current version of {cmd:abm}. 
This command is intended for the setup functions of {help abm_pop_protected:abm_pop},
{help abm_nw_protected:abm_nw}, and {help abm_grid_protected:abm_grid}. It sets 
the default version to be the current version. 

{pstd}
So, if one does not set the version, one gets access to the newest features of 
{cmd:abm}, but one is not protecting ones model against future changes in {cmd:abm}
that might break the model.


{marker conformability}{...}
{title:Conformability}

    {cmd:bc_setup()}:
           {it:result}:   {it:void} 
