{smcl}
{* *! version 0.1.0 26Mar2020 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 19 21 2}{...}
{p2col:{bf:from_adjmatrix} {hline 2}}import a network from an adjacency matrix{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void}{bind:       }
{cmd:from_adjmatrix(}{it:real matrix adjmat}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
{cmd:from_adjmatrix()} imports a network from an adjacency matrix. An adjacency
matrix is an {it:N x N} matrix, where {it:N} is the number of nodes. The row 
and column numbers correspond to the id number of the nodes, and the numbers in
the cells are the weights for that edge. If there is no edge, then the weight 
is 0.

	
{title:Example}
    
{cmd}{...}
    // import abm_nw class
    run abm_nw.mata
    
    mata:
    // the adjacency matrix:
		adjmat = J(5,5,0)
		adjmat[1,2] = 1
		adjmat[2,1] = 1
		adjmat[1,3] = 1
		adjmat[3,1] = 1
		adjmat[4,5] = 1
		adjmat[5,4] = 1
               
    // start the network           
    model = abm_nw()
    model.N_nodes(0,5)
    model.directed(0)
	model.weighted(0)
    
    // import the network from the edgelist
    model.from_adjmatrix(adjmat)
    
    // look at stored network in the form of
    // an adjacency matrix
    model.export_adjmat(0)
    end
{txt}{...}


{marker conformability}{...}
{title:Conformability}

    {cmd:from_adjmatrix(}{it:adjmat}{cmd:)}:
           {it:result}:   {it:void}
           {it:adjmat:}   {it:n x n}  

           
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:from_adjmatrix()} aborts with an error if the number of rows in {it:adjmat}
is not equal to the initial number of nodes or the number of columns in 
{it:adjmat} is not equal to the initial number of nodes.

{p 4 4 2}
{cmd:from_adjmatrix()} aborts with an error if {cmd:directed} was set to 0 and 
{it:adjmat} is not symmetric.

{p 4 4 2}
{cmd:from_adjmatrix()} aborts with an error if a network was already imported.

{p 4 4 2}
{cmd:from_adjmatrix()} aborts with an error if nodes were dropped with 
{help abm_nw_remove_node:remove_node()} in the initial network (t=0).
