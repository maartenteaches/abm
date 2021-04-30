{smcl}
{* *! version 1.0.0 04Feb2021 MLB}{...}
{vieweralsosee "help abm" "help abm"}{...}
{p2colset 1 17 19 2}{...}
{p2col:{bf:abm_nw class} {hline 2}}class for managing a network in an agent 
based model{p_end}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{cmd:abm_nw} is a Mata {help [M-2] class:class} intended to help manage a 
network for Agent Based models. An Agent Based Model is a simulation in which 
agents, that each follow simple rules, interact with one another and thus 
produce a often surprising outcome at the macro level. The purpose of an ABM is 
to explore mechanisms through which actions of the individual agents add up to a 
macro outcome, by varying the rules that agents have to follow or varying with 
whom the agent can interact (i.e. varying the network).

{pstd}
Which agents can interact with one another is thus an important part of an ABM.
The {cmd:abm_nw} class contains a set of functions that allows one to set up 
such a network, find neighbourhoods of a node, and manipulate the network. 

{pstd}
The network consists of a set of nodes and connections between the nodes, the 
edges. For example, it could be a network of friends. In that case the nodes are
the agents and there is an edge between two nodes if they are friends. The edges
could be undirected (are person 1 and 2 friends) or directed (does person 1 
consider person 2 to be a friend, and does person 2 consider person 1 to be a 
friend). The edges could also be weighted (e.g. how often do person 1 and 2 
meet). The network can be constant, or can change over time. Often the nodes are 
the agents, but that does not have to be the case. For example, the nodes could 
be cities and edges could be the rail network, while the agents could be person 
who live and work in the cities.


{p 4 4 2}
You will mainly interact with the {cmd:abm_nw} class through the following
public functions:

{p 5 5 2}{it:Public functions}{p_end}
{p2colset 8 26 28 8}{...}
{p2line -2 0}
{p2col 6 23 25 8:{it:Setup}}{p_end}
{p2col:{helpb abm_nw_N_nodes:N_nodes()}}sets or returns the number of nodes{p_end}
{p2col:{helpb abm_nw_tdim:tdim()}}sets or returns the number of iterations{p_end}
{p2col:{helpb abm_nw_directed:directed()}}sets or returns whether or not this is a directed network{p_end}
{p2col:{helpb abm_nw_directed:weighted()}}sets or returns whether or not this is a weighted network{p_end}
{p2col:{helpb abm_nw_randomit:randomit()}}sets or returns whether or not {cmd:schedule()} returns a list 
of nodes in random order{p_end}
{p2col:{helpb abm_bc_abm_version:abm_version()}}Set the version of {cmd:abm} used.{p_end}
{p2col:{helpb abm_nw_setup:setup()}}sets defaults and performs checks on settings{p_end}

{p2col 6 23 25 8:{it: import and create a network}}{p_end}
{p2col:{helpb abm_nw_from_edgelist:from_edgelist()}}imports network from an edge list{p_end}
{p2col:{helpb abm_nw_from_adjlist:from_adjlist()}}imports network from an adjacency list{p_end}
{p2col:{helpb abm_nw_from_adjmatrix:from_adjmatrix()}}imports network from an adjancency matrix{p_end}
{p2col:{helpb abm_nw_random:random()}}creates a fuly random network{p_end}
{p2col:{helpb abm_nw_sw:sw()}}creates a random network with small-world properties (using a 
Watts-Strogatz model){p_end}
{p2col:{helpb abm_nw_clear:clear()}}clears the network, but keeps the settings.{p_end}

{p2col 6 23 25 8:{it: manipulate a network}}{p_end}
{p2col:{helpb abm_nw_add_edge:add_edge()}}adds an edge{p_end}
{p2col:{helpb abm_nw_remove_edge:remove_edge()}}removes and edge{p_end}
{p2col:{helpb abm_nw_change_weight:change_weight()}}changes the weight of an edge{p_end}
{p2col:{helpb abm_nw_rewire:rewire()}}replaces the start and end nodes of an edge with other nodes{p_end}
{p2col:{helpb abm_nw_add_node:add_node()}}adds a node{p_end}
{p2col:{helpb abm_nw_remove_node:remove_node()}}removes a node{p_end}
{p2col:{helpb abm_nw_return_node:return_node()}}returns a node that was previously removed{p_end}
{p2col:{helpb abm_nw_copy_nw:copy_nw()}}copy the network from one point in time to another point in 
time{p_end}

{p2col 6 23 25 8:{it:Return}}{p_end}
{p2col:{helpb abm_nw_neighbours:neighbours()}}returns a row vector of neighbouring nodes{p_end}
{p2col:{helpb abm_nw_weight:weight()}}returns the weight of an edge{p_end}
{p2col:{helpb abm_nw_schedule:schedule()}}returns a list of all nodes{p_end}
{p2col:{helpb abm_nw_no_edge:no_edge()}}returns whether or not an edge exists{p_end}
{p2col:{helpb abm_nw_no_edge:edge_exists()}}returns an error when no edge exists{p_end}
{p2col:{helpb abm_nw_N_edges:N_edges()}}returns the number of edges{p_end}
{p2col:{helpb abm_nw_export_edgelist:export_edgelist()}}returns the network as an edgelist{p_end}
{p2col:{helpb abm_nw_export_adjmat:export_adjmat()}}returns the network as an adjacency matrix{p_end}
{p2line -2 0}


{title:Remarks}

{p 4 4 2}
The {cmd:abm_nw} class also contains a number of protected functions and 
variables. These cannot be accessed directly, but if you create a new class that
inherits from {cmd:abm_nw} you will, within that class, have access to them. 
This is helpful if you want to change function (functions with the same name 
in the new class will take precedence over the functions with that name in 
{cmd:abm_nw}, or add functions. These are documented 
{help abm_nw_protected:here}.


{title:Example}

{pstd}
Below is an example Agent Based Model that illustrates how so called "weak ties"
fascilitate the spread of information, a rumor, or a disease in a network with
"small-world" properties. In such a network most nodes form cliques, i.e. 
friends of friends are also more likely to be friends. However, there are a small
number of "long distance" or "weak" ties outside these cliques. 

{pstd}
so the agents are the nodes, and an agent can be in two states: it either heard 
the rumor or not. The rumor starts with person 1. At each tick all agents who 
have heard the rumor tell all their neighbours. 

{pstd}
If you are in a clique, you will often be telling the rumor to someone who 
already heared it. It is this reduncy of ties in cliques that slows down the 
spread of a rumor in a network. However, if you heared the rumor from a weak 
tie, the rumor will be new to most of your neighbours, thus speeding the spread
of the rumor. 

{pstd}
Notice that only the properties of the agents change, but the network remains
constant. So the {cmd:tdim()} of the {cmd:spread()} class influences the 
dimension of the matrix that stores whether or not an agent heared the rumor.
This {cmd:tdim()} is not passed on to the {cmd:tdim()} of the {cmd:abm_nw()} 
class; the network is constant, so its {cmd:tdim()} is 0. 

{cmd}
    set seed 12345678
    clear all
    
    // ----------------------------------- class definitions
    
    mata:
    mata set matastrict on
    
    // the main agent based model
    class spread extends abm_util
    {
        class abm_nw          scalar   nw
        real                  matrix   infected
        real                  scalar   degree
        real                  scalar   pr
        real                  scalar   N
        real                  scalar   tdim
        
        transmorphic                   degree()
        transmorphic                   pr()
        transmorphic                   N()
        transmorphic                   tdim()
          
        void                           setup()
        void                           run()
        void                           step()
    
        void                           toStata()
    }
    
    // ------------ -----------------------setup the network
    transmorphic spread::N(| real scalar val)
    {
        if (args()==1) {
            is_posint(val)
            nw.N_nodes(0,val)
            N = val
        }
        else {
            return(N)
        }
    }
    
    transmorphic spread::tdim(| real scalar val)
    {
        if (args()==1) {
            is_posint(val)
            tdim = val
        }
        else {
            return(tdim)
        }
    }
    
    transmorphic spread::degree(| real scalar val) 
    {
        if (args()==1) {
            is_posint(val)
            degree = val
        }
        else {
            return(degree)
        }
    }
    
    transmorphic spread::pr(| real scalar val)
    {
        if (args() == 1){
            is_pr(val)
            pr = val
        }
        else {
            return(pr)
        }
    }
    
    void spread::setup()
    {
        if (tdim==.) tdim = 10
        if (N==.) {
            N=30
            nw.N_nodes(0,30)
        }
        if (degree==.) degree = 4
        if (pr==.) pr=.1
        
        nw.abm_version("0.1.2")
        nw.directed(0)
        nw.weighted(0)
        nw.tdim(0)
        nw.sw(degree, pr)
        nw.setup()
        
        infected = J(N,tdim,0)
        infected[1,1] = 1
    }
    
    // --------------------------------------- run the model
    void spread::step(real scalar t)
    {
        real scalar i, j
        real vector neigh
        
        infected[.,t+1] = infected[.,t]
    
        for(i=1; i <= N; i++) {
            if(infected[i,t]==1) {  
                neigh = nw.neighbours(i)
                for(j=1; j<= length(neigh); j++) {
                    infected[neigh[j],t+1] = 1
                }
            }
        }   
    }
    
    void spread::run()
    {
        real scalar i
        setup()
        for(i=1; i<tdim; i++) {
            step(i)
        }
    }
    
    // ------------------------- export the results to Stata
    void spread::toStata()
    {
        real vector xid
        real matrix result
        real scalar i, k, n
        string vector varnames
        
        // collect what we want to export in a matrix
        result = nw.export_edgelist(0, "ego_all") 
        result = result, J(rows(result),tdim,.)
        for (i=1; i<=rows(result);i++) {
            result[|i,4 \ i, .|] = infected[result[i,1],.]
        }
    
        // move matrix to Stata
        k = cols(result)
        varnames = J(1,k,"")
        varnames[1..3] = "ego", "alter","weight"
        for(i = 4 ; i <= k; i++) {
            varnames[i] = "inf" + strofreal(i-3)
        }
        xid = st_addvar("long", varnames)
        n = st_nobs()
        n = rows(result) - n
        if (n > 0) {
            st_addobs(n)
        }
        st_store(.,xid, result)
        st_local("n", strofreal(N))
    }
    
    
    end
    
    // --------------------------------------- run the model
    mata:
    model = spread()
    model.N(40)
    model.degree(4)
    model.pr(.1)
    model.tdim(10)
    model.run()
    model.toStata()
    end
    
    // A nice display of this type of network can be created
    // by putting the nodes in order on a circle 
    // remember your trigonometry? (if not, Wikipedia helps)
    gen x_ego = cos((ego-1)/`n'*2*_pi)*(1+mod(ego,2)*.2)
    gen y_ego = sin((ego-1)/`n'*2*_pi)*(1+mod(ego,2)*.2)
    gen x_alter = cos((alter-1)/`n'*2*_pi)*(1+mod(alter,2)*.2)
    gen y_alter = sin((alter-1)/`n'*2*_pi)*(1+mod(alter,2)*.2)
    
    // each node can appear multiple times in the data
    // once for each edge, 
    // but we want to display each node only once
    bys ego (alter) : gen first = _n == 1
    
    // the graphs
    forvalues t = 1/10{
        twoway pcspike y_ego x_ego y_alter x_alter,                ///
                      lcolor(gs8) scheme(s1mono) ||                ///
            scatter y_ego x_ego if first & inf`t'==1 ,             ///
                       mcolor(red) msymbol(O) ||                   ///
            scatter y_ego x_ego if first & inf`t'==0,              ///
                       mcolor(black) msymbol(Oh)                   ///
                       aspect(1) xscale(off) yscale(off)           ///
                       legend(order(1 "infected" 2 "susceptible")) ///
                       name(t`t', replace) title(Time `t')     
    }
{txt}

{pstd}
Once you have this basic model, you can start exploring its properties by vary 
the degree (the average number of ties each agent has) and probability of a weak 
tie and see how that influences the average time till everybody heared the rumor.
What if we change the rules such that an agent only accepts a rumor if she heared 
it from two different agents?
