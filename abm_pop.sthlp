{smcl}
{* *! version 0.1.0 03Aug2020 MLB}{...}
{p2colset 1 18 20 2}{...}
{p2col:{bf:abm_pop class} {hline 2}}class for storing and retrieving properties 
of agent that can change over time in an agent based model{p_end}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
{cmd:abm_pop} is a Mata {help [M-2] class:class} intended to store and retrieve
the state of characteristics of agents at a point in time for use in an Agent 
Based models. So an agent can have one or more characteristics (think of them as
variables in a Stata dataset), that can change over time. The value of a 
characteristic of an agent at a particular point in time will be called the 
state. The agents and characteristics are not named but numbered from 1 till the 
number of agents or the number of characteristics respectively. 

{pmore}
For example: We want to model the way a disease spreads in a population of 10 
agents, and we want to store for each agent whether is has the disease or not, 
and with whom that agent is in contact. So we have agents 1 till 10, and  
characteristics 1 and 2. At each point in time characteristic 1 for an agent 
could have the state "diseased" or "healthy", while the state of characteristic 
2 would be a vector of ids for agents with which it was in contact.

{pstd}
In {cmd:abm_pop} time is assumed to be discrete and starts at 1. So time can 
have the values 1, 2, 3, ... Moreover, a state is presumed to persist until a 
new state is saved. So you only have to store something in {cmd:abm_pop} when it 
changes. It is thus not neccessary to copy the states of the entire population 
at each iteration in your agent based model, which can lead to a noticalbe 
increase in speed. It also means that you have to store the development of the 
agent in chronological order; if you stored a change for time 10, you can no 
longer store a change for time 9.

{pmore}
To continue the example: Most agents start with the state "healthy" at time 1,
and this characteristic only has to be updated when an agent becomes infected.

{pstd}
Before you can use an instance of {cmd:abm_pop} you fist have to set the number
of agents (with the {cmd:N()} function) and the number of characteristics you 
wish to store for each agent (with the {cmd:k()} function), and run 
{cmd:setup()}. After that you store pretty much anything with the {cmd:put()} 
function, and retrieve it again with the {cmd:get()} function.

{pstd}
You can intract with the {cmd:abm_pop} class through these functions:

{p2colset 8 26 28 8}{...}
{p2line -2 0}
{p2col 6 23 25 8:{it:Setup}}{p_end}
{p2col:{helpb abm_pop_N:N()}}sets or returns the number of agents{p_end}
{p2col:{helpb abm_pop_k:k()}}sets or returns the number of things stored per 
agent{p_end}
{p2col:{helpb abm_pop_setup:setup()}}sets defaults and performs checks on 
settings{p_end}

{p2col 6 23 25 8:{it: Store and retrieve}}{p_end}
{p2col:{helpb abm_pop_put:put()}}stores a change in characteristic of an aget at 
a point in time{p_end}
{p2col:{helpb abm_pop_get:get()}}retrieves a characteristic of an agent at a 
point in time{p_end}

{p2col 6 23 25 8:{it: Miscellaneous}}{p_end}
{p2col:{helpb abm_pop_add:add()}}adds one or more agents after setup(){p_end}
{p2col:{helpb abm_pop_extract:extract()}}returns a pointer matrix that for each
agent (row) at each point in time (column) points to the content of a 
characteristic {p_end}
{p2line -2 0}


{title:Example}

{cmd}{...}
    // create the abm_pop class
    run abm_pop.mata
    
    // I often like to use local macros to use meaningful names for characteristics
    local diseased 1
    local contacts 2
    
    mata:
    // setup an instance of abm_pop called agents
    agents = abm_pop()
    agents.N(10)
    agents.k(2)
    agents.setup()
    
    // store the value 3 for agent 1, characteristic 1, time 1
    agents.put((1,`diseased',1),3)
    
    // retrieve it again
    agents.get((1,`diseased',1))
    
    // this characteristic persists, i.e. at time 2 it is still 3
    agents.get((1,`diseased',2))
    
    // for agent 2 we store for the first characteristic at time 5 a matrix
    agents.put((2,`diseased',5), (1, 2 \ 3, 4))
    
    // this means that before t=5 nothing is stored for 
    // this agent and this characteristic
    agents.get((2,`diseased',4)) == J(0,0,.)
    
    // but at t=5 and later it contains the matrix
    agents.get((2,`diseased',5)) 
    agents.get((2,`diseased',6)) 
    
    // until you store a change
    agents.put((2,`diseased',7), "something else")
    agents.get((2,`diseased',7))
    agents.get((2,`diseased',8))
    end
{txt}{...}