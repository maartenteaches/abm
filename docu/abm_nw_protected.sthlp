{smcl}
{* *! version 0.1.0 22Jan2019 MLB}{...}
{vieweralsosee "help abm_nw" "help abm_nw"}{...}
{p2colset 1 28 30 2}{...}
{p2col:{bf:abm_nw class, protected} {hline 2}} protected functions and 
variables in the abm_nw class
models{p_end}
{p2colreset}{...}

{title:Description}

{p 4 4 2}
The {cmd:abm_nw} class has {help abm_nw:public functions} that the user can 
directly interact with and a number of protected functions and variables that 
are used internally but the user cannot access directly. However, if a user 
creates a new class that inherits from {cmd:abm_nw}, then, within that new 
class, the user does have access to these protected functions and variables. 
This can be helpful if your agent based model requires an additional function or 
that existing functions work differently.


{p2colset 8 24 26 8}{...}
{p2line -2 0}
{p2col 6 23 25 8:{it:Protected functions}}{p_end}
{p2col:{helpb abm_nw_error:is_setup()}}aborts with an error if the scalar 
{cmd:setup} is not 1{p_end}
{p2col:{helpb abm_nw_error:is_nodesset()}}aborts with an error if the the number
of nodes at time 0 is not set{p_end}
{p2col:{helpb abm_nw_error:is_frozen()}}aborts with an error if the network is
frozen{p_end}
{p2col:{helpb abm_nw_error:is_symmetric()}}aborts with an error if the network is
not symmetric{p_end}
{p2col:{helpb abm_nw_store_nw:copy_adjlist()}}copy a column from {it:adjlist} to another column{p_end}
{p2col:{helpb abm_nw_store_nw:copy_nodes()}}copy nodes from one time to another{p_end}
{p2col:{cmd:new()}}runs when an instance of the {cmd:abm_nw}
class is created. It sets the scalars {cmd:setup}, {cmd:nw_set}, {cmd:nodes_set}, 
and {cmd:N_edges0} to 0. It also initializes {cmd:network} to be a three dimensional
associative array.{p_end}

{p2col 6 23 25 8:{it:Protected variables}}{p_end}
{p2col: {cmd:tdim}}scalar that stores the setting set by {help abm_nw_tdim:tdim()}{p_end}
{p2col: {cmd:directed}}scalar that stores the setting set by {help abm_nw_directed:directed()}{p_end}
{p2col: {cmd:weighted}}scalar that stores the setting set by {help abm_nw_directed:weighted()}{p_end}
{p2col: {cmd:randomit}}scalar that stores the setting set by {help abm_nw_randomit:randomit()}{p_end}
{p2col: {cmd:N_edges}}vector storing the number of edges. The row number corresponds to the time{p_end}
{p2col: {cmd:N_edges0}}scalar storing the number of edges at time 0{p_end}
{p2col: {cmd:N_nodes}}vector storing the number of nodes. The row number corresponds to the time{p_end}
{p2col: {cmd:N_nodes0}}scalar storing the number of nodes at time 0{p_end}
{p2col: {cmd:maxnodes}}scalar storing the number of nodes that have ever been specified{p_end}
{p2col: {cmd:nodes_set}}scalar storing whether (1) or not (0) the number of nodes at time 0 has been specified{p_end}
{p2col: {cmd:nw_set}}scalar storing whether (1) or not (0) a network has been imported 
or created by either {help abm_nw_random:random()} or {help abm_nw_sw:sw()}. {p_end}
{p2col: {cmd:setup}}vector storing whether or not {help abm_nw_setup:setup()} has been run.{p_end}
{p2col: {cmd:frozen}}a vector storing whether the network is frozen. The 
column number is the time.{p_end}
{p2col: {helpb abm_nw_store_nw:network}}Associative array storing the weights of the edges{p_end}
{p2col: {helpb abm_nw_store_nw:adjlist}}matrix of pointers storing with which nodes a node is connected. The 
rows correspond to the nodes, and the columns to the time{p_end}
{p2col: {helpb abm_nw_store_nw:adjlist0}}vector of pointers storing with which nodes a node is connected at
time 0. The rows correspond to the node ids.{p_end}
{p2col: {helpb abm_nw_store_nw:nodes0}}vector of node ids that are valid on time 0{p_end}
{p2col: {helpb abm_nw_store_nw:nodes}}vector of pointers, that point to vectors 
of node ids that are valid. The row number is corresponds to the time{p_end}
{p2col: {helpb abm_nw_store_nw:dropped_nodes}}vector of pointers that point to vectors that store a list of
node ids that ever exist, but are not valid now. The row number corresponds to the time.{p_end}
{p2col: {helpb abm_nw_store_nw:dropped_nodes0}}A vector that stores a list of nodes that existed or will 
exist, but are not valid on time 0{p_end}
{p2line -2 0}

{pstd}
In addition, {cmd:abm_nw} inherits protected functions from the 
{help abm_chk}, and {help abm_bc_protected:abm_bc} classes. 
