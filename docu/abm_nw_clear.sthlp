{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 14 16 2}{...}
{p2col:{bf:clear()} {hline 2}}clears the network but keeps the settings{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:clear()}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:clear()} clears the network but keeps the settings. This is helpful when one
wants repeatedly run the model with the same settings, or only minor changes to
the settings. 


{marker conformability}{...}
{title:Conformability}

    {cmd:clear()}:
           {it:result}:   {it:void}
         
