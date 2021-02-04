{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 15 17 2}{...}
{p2col:{bf:setup()} {hline 2}}sets defaults
{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:setup()}

{p 8 12 2}
{it:void}{bind:       }
{cmd:setup(}{it:string scalar fast}{cmd:)}

{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:setup()} is meant to finalize the intial setup phase; it checks the inputs
and sets anything not set to its default. 

{p 4 4 2}
The defaults are:

{p 8 8 2}
{help abm_nw_tdim:tdim} = 0 

{p 8 8 2}
{help abm_nw_directed:directed} = 1

{p 8 8 2}
{help abm_nw_directed:weighted} = 1

{p 8 8 2}
{help abm_nw_randomit:randomit} = 0

{p 4 4 2}
If any string is specified in {it:fast} (for clarity I prefer the word "fast"), 
then {cmd:setup()} will not check if the network is symmetric when 
{help abm_nw_directed:directed} has been set to 0. In large networks this could
speed your model up, but at the cost of not performing this check. As long as 
you set {cmd:directed} before entering edges to the network, you should be fine. 
When in doubt I would {ul:not} set the {it:fast} option.


{marker conformability}{...}
{title:Conformability}

    {cmd:setup()}:
           {it:result}:  {it:void}
           
    {cmd:setup(}{it:fast}{cmd:)}:
           {it:result}:  {it:void}
           {it:fast}      1 {it:x} 1

		   
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:setup()} aborts with an error if {cmd:directed} was set to 0, the network 
is not symmetric and {it:fast} has not been set.
