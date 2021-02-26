{smcl}
{* *! version 1.0.0 26Feb2021 MLB}{...}
{vieweralsosee "help abm_bc protected" "help abm_bc_protected"}{...}
{phang}
{cmd:valid_version()} {hline 2} checks whether a version is valid{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:valid_version(}{it:tocheck}{cmd:)}

{marker description}{...}
{title:Description}

{pstd}
{cmd:valid_version()} checks whether the vector received by {help abm_bc_mod_geq:mod_geq()}, 
{help abm_bc_mod_geq:mod_gt()}, {help abm_bc_mod_geq:mod_leq()}, and 
{help abm_bc_mod_geq:mod_lt()} is a valid version vector. {cmd:valid_version()} will 
exit with an error if {it:tocheck} is not a three column rowvector with all positive 
integers.


{marker conformability}{...}
{title:Conformability}

    {cmd:valid_version(}{it:tocheck}{cmd:)}:
           {it:result}:   {it:void} 
           {it:tocheck}:  1 {it:x} 3 
