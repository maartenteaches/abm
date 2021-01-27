{smcl}
{* *! version 1.0.0 21Jan2021 MLB}{...}
{vieweralsosee "abm_pop" "help abm_pop"}{...}
{vieweralsosee "abm_grid" "help abm_grid"}{...}
{vieweralsosee "abm_nw" "help abm_nw"}{...}

{phang}
{bf:abm_version()} {hline 2} Set or return version number

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:abm_version(}{it:string scalar val}{cmd:)}

{p 8 12 2}
{it:real rowvector}
{cmd:abm_version()}

{p 8 12 2}
{it:real rowvector}
{cmd:abm_current()}


{marker description}{...}
{title:Description}

{pstd}
When writing an Agent Based Model with {help abm_pop}, {help abm_grid}, or {help abm_nw}, 
one can set the version with {cmd:abm_version()}. These three classes continue to be 
improved, but these improvements could break your model. Setting the version prevents that.
If either of these classes is further developed in a way that would break your model, 
and you have set the version, then the improvements that would break your model are roled 
back. So by setting the version for every instance of the classes one can safely update 
the {cmd:abm} package, without it breaking your existing models.

{pstd}
To find the current version of {cmd:abm} use the {cmd:abm_current()} function.

{pstd}
{cmd:abm_version(} {it:val}{cmd:)} expects {it:val} to be a string with the format "#.#.#", 
where "#" has to be a positive integer (including 0). One can abreviate the version as "#" 
or "#.#", meaning #.0.0 or #.#.0 respectively.

{pstd}
{cmd:abm_version()} without arguments returns the version. If the version has been set
then it will be a 1 by 3 real rowvector, otherwise J(1,0,.).


{marker conformability}{...}
{title:Conformability}

    {cmd:abm_version(}{it:val}{cmd:)}:
           {it:result}:  {it:void}
           {it:val}      1 {it:x} 1

    {cmd:abm_version( )}:
           {it:result}:  1 {it:x} 3

    {cmd:abm_current( )}:
           {it:result}:  1 {it:x} 3


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:abm_version(}{it:val}{cmd:)} aborts with an error if {it:val} exceeds the current version of 
{cmd:abm}.
