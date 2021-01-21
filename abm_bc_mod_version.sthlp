{smcl}
{* *! version 1.0.0 21Jan2021 MLB}{...}
{vieweralsosee "abm_pop" "help abm_pop"}{...}
{vieweralsosee "abm_grid" "help abm_pop"}{...}
{vieweralsosee "abm_nw" "help abm_pop"}{...}

{phang}
{bf:mod_version()} {hline 2} Set or return version number

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}
{cmd:mod_version(}{it:string scalar val}{cmd:)}

{p 8 12 2}
{it:real rowvector}
{cmd:mod_version()}


{marker description}{...}
{title:Description}

{pstd}
When writing an Agent Based Model with {help abm_pop}, {help abm_grid}, or {help abm_nw}, 
one can set the version with {cmd:mod_version()}. These three classes continue to be 
improved, but these improvements could break your model. Setting the version prevents that.
If either of these classes is further developed in a way that it would break your model, 
and you have set the version, then all improvements since than that would break your model,
are roled back. So by setting the version one can safely update the {cmd:abm} package, 
without it breaking your existing models.
