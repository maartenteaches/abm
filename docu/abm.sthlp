{smcl}
{* *! version 1.0.0 03Feb2021 MLB}{...}
{phang}{cmd:abm} {hline 2} A collection of classes to help build an Agent Based Model{p_end}

{marker description}{...}
{title:Description}

{p 4 4 2}
An Agent Based Model is a simulation in which agents, that each follow
simple rules, interact with one another and thus produce a often
surprising outcome at the macro level. The purpose of an ABM is to explore 
mechanisms through which actions of the individual agents add up to a macro 
outcome, by varying the rules that agents have to follow or varying with 
whom the agent can interact.

{p 4 4 2}
For example, in Schelling's seggregation model there are blue and red agents, 
that live in cells on a square grid. Each cell can contain only one agent, 
but not all cells are occupied. An agent is happy if the proportion of agents 
of the same colour in her neighbourhood is above a certain cut-off value. If 
she is unhappy she will move to the nearest available cell that does satisfy 
her needs.

{p 4 4 2}
In that example we need to store two things: a list of agents with their 
corresponding color, and a list of cells with their occupant (if any). Each 
agent has a unique number linking the two lists. The classes in the {cmd:abm}
package are there to help manage these types of lists.

{pmore}
The {helpb abm_grid} class can store such a grid as it develops over time, and
has functions for determining who the neighbours of a cell are for different
definitions of neighbour (for example, do diagonal neighbours count and what 
happens on the borders of grids). 

{pmore}
The {helpb abm_pop} class can store a list of agents and their properties. It is 
particulary helpful when at each point in time most agents' properties are 
stable, but some change. For example, in a model modelling the spread of a 
disease, most agents will remain healthy for a long time, some get the disease, 
they stay ill for a time, and than (hopefully) recover and stay in that state 
for a long time. The {cmd:abm_pop} class only stores the changes. This prevents
the necessity at each time point for copying the states of all agents from the
previous time point, thus speeding up your model. However, {cmd:abm_pop} is 
less useful when the properties of the agents are completely fixed, like in 
Schelling's segregation model. In that case one could use a simple vector, 
where the row number is the agent id, and cell contain that agent's color. In 
case of models where agents have multiple characteristics of different types 
one can consider an {help mf_associativearray:associative array}.

{pmore}
The {helpb abm_nw} class can store a network as a way of governing who can
interact with who in your model. The network can be constant or changing over
time, it can be directed or undirected, and the connections can be weighted
or not.

{pstd}
In addition, the {cmd:abm} package also contains two helper classes: {help abm_chk}
and {help abm_bc}. The {cmd:abm_chk} class contains some functions for checking 
parameters. For example, if a number is a positive integer or not. Inherriting the 
{cmd:abm_chk} class into your model class can be useful if you want to perform
such tests as well. The {cmd:abm_bc} class is there to help with assuring backwards 
compatability for all the classes of the {cmd:abm} package. 
