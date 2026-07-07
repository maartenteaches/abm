{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 11 13 2}{...}
{p2col:{bf:random} {hline 2}}creates a random network{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:random(}{it:real scalar pr}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:random()} creates a random network such that every possible edge occurs 
independently with probability {it:pr}. 


{marker example}{...}
{title:Example}

{cmd}{...}
    // import abm_nw class
    run abm.mata
    
    mata:
               
    // start the network           
    model = abm_nw()
    model.N_nodes(1,5)
    model.directed(0)
    model.weighted(0)
    
    // Create a random network
    model.random(0.5)
    
    // look at created network in the form of
    // an adjacency matrix
    model.export_adjmat(1)
    end
{txt}{...}


{marker conformability}{...}
{title:Conformability}

    {cmd:random(}{it:pr}{cmd:)}:
           {it:result}:   {it:void}
           {it:edgelist:} 1 {it:x} 1 

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:random()} aborts with an error if {cmd:weighted} was set to 1.

{p 4 4 2}
{cmd:random()} aborts with an error if a network was already imported.

{p 4 4 2}
{cmd:random()} aborts with an error if nodes were dropped with 
{help abm_nw_remove_node:remove_node()} in the initial network (t=1).

{p 4 4 2}
{cmd:random()} aborts with an error if the number of initial nodes has
not been set.
