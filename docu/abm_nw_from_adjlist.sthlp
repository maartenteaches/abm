{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 18 20 2}{...}
{p2col:{bf:from_adjlist} {hline 2}}import a network from an adjacency list{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:from_adjlist(}{it:real matrix adj}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:from_adjlist()} imports a network from a matrix containing a list of 
adjacent nodes. The first column contains the id number of the sending node and 
the subsequent columns contain the id numbers of the nodes with which the 
sending node is connected or a missing value. The nodes are given consecutive 
numbers. The weights of all edges are assumed to be 1. 

{p 4 4 2}
You only have to specify one edge for each pair of edges, if you specified that 
this is an undirected network, i.e. {help abm_nw_directed:directed} has been set 
to 0. For example, if {cmd:directed} was set to 1 the adjacency list below will 
add a connection between nodes 1 and 2, 1 and 3, and 4 and 5. However, if 
{cmd:directed} was set to 0, then this edgelist will add connections between 
nodes 1 and 2, 2 and 1, 1 and 3, and 3 and 1, 4 and 5, and 5 and 4. 

{cmd}{...}
        adj = 1, 2, 3 \
              4, 5, . 
{txt}{...}
    
	
{title:Example}
    
{cmd}{...}
    // import abm_nw class
    run abm_nw.mata
    
    mata:
    // the adjacency list:
        adj = 1, 2, 3 \
              4, 5, . 
               
    // start the network           
    model = abm_nw()
    model.N_nodes(0,5)
    model.directed(0)
	model.weighted(0)
    
    // import the network from the edgelist
    model.from_adjlist(adj)
    
    // look at stored network in the form of
    // an adjacency matrix
    model.export_adjmat(0)
    end
{txt}{...}


{marker conformability}{...}
{title:Conformability}

    {cmd:from_adjlist(}{it:adj}{cmd:)}:
           {it:result}:   {it:void}
           {it:adj:}      {it:k x m}  

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:from_adjlist()} aborts with an error if {it:adj} contains 0 columns .

{p 4 4 2}
{cmd:from_adjlist()} aborts with an error if {cmd:directed} was not set.

{p 4 4 2}
{cmd:from_adjlist()} aborts with an error if a network was already imported.

{p 4 4 2}
{cmd:from_adjlist()} aborts with an error if nodes were dropped with 
{help abm_nw_remove_node:remove_node()} in the initial network (t=0).

{p 4 4 2}
{cmd:from_adjlist()} aborts with an error if {it:adj} contains duplicates.
If {cmd:directed} was set to 0, then an edge between 1 and 2 and an edge between
2 and 1 are considered duplicates.
