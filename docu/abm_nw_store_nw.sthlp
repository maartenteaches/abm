{smcl}
{* *! version 0.1.0 29Mar2019 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{vieweralsosee "help abm_nw_protected" "help abm_nw_protected"}{...}
{p2colset 1 29 31 2}{...}
{p2col:{bf:how network is stored}}{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:copy_adjlist(}{it:real scalar t0}, {it:real scalar t1}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:copy_nodes(}{it:real scalar t0}, {it:real scalar t1}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
To store a network {cmd:abm_nw} stores a list of nodes, for each of these nodes
a list of nodes to which it is connected, and, if {help abm_nw_directed:weighted}
was set to 1, an associative array storing the weights.

{pmore}
The list of nodes for time 0 is stored in the vector {cmd:nodes0}. The lists of
nodes for subsequent time points are stored in the vector of 
{help [M-2] pointers:pointers} {cmd:nodes}. The row number corresponds with the 
time point, and it points to a vector of valid nodes for that time point. It also
stores corresponding list of node ids that have or will exist, but are not valid
now in {cmd:dropped_nodes} and {cmd:dropped_nodes0}.

{pmore}
The adjacency list for time 0 is stored in the vector of pointers {cmd:adjlist0}.
The row numbers correspond to the node id, and it points to a rowvector of 
node ids to which that node is connected. The adjacency list for subsequent time 
points is stored in the matrix of pointers {cmd:adjlist}. As before, the rows 
indicate the node id. The columns correspond to the time. If a node id is not 
valid for a point in time, then it will point to an empty rowvector, {cmd:J(1,0,.)}

{pmore}
The above two objects are sufficient for an unweighted network. For a weighted
network one also needs to store the weights of the edges. This is done in the 
{help mf_associativearray:associative array} {cmd:network}. The key is a vector
of three real numbers: the time, the id of ego, and the id of alter.

{p 4 4 2}
{cmd:copy_adjlist} is called by {help abm_nw_copy_nw:copy_nw()} to copy the 
adjacency list from {it:t0} to {it:t1}.

{p 4 4 2}
{cmd:copy_nodes} is called by {help abm_nw_copy_nw:copy_nw()} to copy the lists
of valid nodes from {it:t0} to {it:t1}.

 
{marker conformability}{...}
{title:Conformability}

    {cmd:copy_adjlist(}{it:t0}, {it:t1}{cmd:)}:
           {it:result}:    {it:void}
           {it:t0}:       1 {it:x} 1
           {it:t1}:       1 {it:x} 1
    
    {cmd:copy_nodes(}{it:t0}, {it:t1}{cmd:)}:
           {it:result}:    {it:void}
           {it:t0}:       1 {it:x} 1
           {it:t1}:       1 {it:x} 1           
          
		  
{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:copy_adjlist()} and {cmd:copy_nodes} will abort with an error if {it:t0} or 
{it:t1} are not valid times
