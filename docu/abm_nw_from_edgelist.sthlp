{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 18 20 2}{...}
{p2col:{bf:from_edgelist} {hline 2}}import a network from a list of edges{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:from_edgelist(}{it:real matrix edges}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:from_edgelist()} imports a network from a matrix containing a list of edges.
Each row in the matix {it:edges} is an edge, the first column is the id number of
the "sending" node and the second column the id number of the "receiving" node. 
The nodes are given consecutive numbers. This matrix can have a third column,
containing the weights of that edge, if {help abm_nw_directed:weighted} has
been set to 1

{p 4 4 2}
You only have to specify one edge for each pair of edges, if you specified that 
this is an undirected network, i.e. {help abm_nw_directed:directed} has been set 
to 0. For example, if {cmd:directed} was set to 1 the edgelist below will add a
connection between nodes 1 and 2, 4 and 5, and 2 and 3. However, if {cmd:directed}
was set to 0, then this edgelist will add connections between nodes 1 and 2, 
2 and 1, 4 and 5, 5 and 4, 2 and 3 and 3 and 2. 

{cmd}{...}
        edglist = 1,2 \
                  4,5 \
                  2,3
{txt}{...}
    
	
{title:Example}
    
{cmd}{...}
    // import abm_nw class
    run abm_nw.mata
    
    mata:
    // the edgelist:
    edgelist = 1,2 \ 
               1,3 \
               4,5
               
    // start the network           
    model = abm_nw()
    model.N_nodes(0,5)
    model.directed(0)
	model.weighted(0)
    
    // import the network from the edgelist
    model.from_edgelist(edgelist)
    
    // look at stored network in the form of
    // an adjacency matrix
    model.export_adjmat(0)
    end
{txt}{...}


{marker conformability}{...}
{title:Conformability}

    {cmd:from_edgelist(}{it:edgelist}{cmd:)}:
           {it:result}:   {it:void}
           {it:edgelist:} {it:k x} 2 or {it:k x} 3 

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:from_edgelist()} aborts with an error if {it:edgelist} contains 1 column or
more than 3 columns.

{p 4 4 2}
{cmd:from_edgelist()} aborts with an error if {cmd:weighted} was set to 0, and
{it:edgelist} contains 3 columns.

{p 4 4 2}
{cmd:from_edgelist()} aborts with an error if {cmd:directed} was not set.

{p 4 4 2}
{cmd:from_edgelist()} aborts with an error if a network was already imported.

{p 4 4 2}
{cmd:from_edgelist()} aborts with an error if nodes were dropped with 
{help abm_nw_remove_node:remove_node()} in the initial network (t=0).

{p 4 4 2}
{cmd:from_edgelist()} aborts with an error if {it:edgelist} contains duplicates.
If {cmd:directed} was set to 0, then an edge between 1 and 2 and an edge between
2 and 1 are considered duplicates.
