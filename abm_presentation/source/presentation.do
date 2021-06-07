//layout toc secbold title(subsection) link(subsection)
//layout bottombar toc

//titlepage --------------------------------------------------------------------
//title Agent based models in Mata: Modelling aggregate processes, like the spread of a disease

/*txt
{center:{it:using the }{cmd:abm}{it: package}}


{center:Maarten Buis}
{center:University of Konstanz}

{center:maarten.buis@uni.kn}
txt*/
//endtitlepage

/*toctitle
Table of Contents
toctitle*/

//section What is an Agent Based Model?
//slide ------------------------------------------------------------------------
//title What is an Agent Based Model?

/*txt
{pstd}
An Agent Based Model is a simulation in which agents, that each follow simple rules, 
interact with one another and thus produce a often surprising outcome at the macro 
level. 

{pstd}
The purpose of an ABM is to explore mechanisms through which actions of the 
individual agents add up to a macro outcome, by varying the rules that agents have
to follow or varying with whom the agent can interact. 
txt*/

//endslide ---------------------------------------------------------------------



//slide ------------------------------------------------------------------------
//title Example: The spread of a disease 

/*txt
{pstd}
In this model each agent can be in one of three states:

{pmore}{it:Susceptible}: the agent is healthy, but can get the disease.{p_end}
{pmore}{it:Infectious}: the agent has the disease and can spread it to others.{p_end}
{pmore}{it:Recovered}: the agent has had the disease and is now immune.{p_end}

{pstd}
In the first round one or more agents get infected.

{pstd}
In all subsequent rounds:

{pmore}- All infectious agents have a chance to become recovered, and{p_end}
{pmore}- all recovered agents get a chance to become susceptible.{p_end}
{pmore}- All agents that are still infectious contact a random number of other 
agents{p_end}
{pmore}- Each of these contact has a chance of resulting in an infection if 
someone is susceptible.
txt*/

//ex
set seed 123456789
set scheme s1color
clear mata
drop _all
run sir_main.do

mata:

model = sir()
model.N(2000)
model.tdim(150)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0)
model.run()
model.export_sir()
end

twoway line S I R t,  name(sir1, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
   
drop _all
//endex
//graph sir1

/*txt
{pstd}
The number 0.045 for transmissibility was chosen to get a /*digr*/ of 2.5, which
in line with COVID-19.
txt*/

//file sir_chks.do       
//file sir_cscript.do    
//file sir_export.do     
//file sir_locals.do     
//file sir_main.do       
//file sir_set_pars.do   
//file sir_sim.do   

   
//endslide --------------------------------------------------------------------- 

//digr -------------------------------------------------------------------------
//label R0
//title R0

/*txt
{pstd}
14 days is a number that has floated around a lot for how long someone is 
infectious when having COVID-19. 

{pstd}
On average 4 contacts is just a convenient number 

{pstd}
The transmissibility is then chosen to make the R0 close to 2.5, another number
that has floated around a lot for COVID-19.

{pmore}
If someone is 14 days infectious, and contacts 4 persons each day, then there 
are 14*4=56 opportunities to infect someone. 

{pmore}
These should result in 2.5 infections, so the chance of a contact leading to an
infection is 2.5/56 = 0.045
txt*/

//enddigr ----------------------------------------------------------------------

//anc ------------------------------------------------------------------------
//title Other Scenarios

/*txt
{pstd}
What if the immunity against COVID-19 obtained from getting the disease does not 
persist?

{pstd}
We can change to model to see how that impacts the spread of the disease
txt*/

//ex
clear mata
drop _all
run sir_main.do

mata:

model = sir()
model.N(2000)
model.tdim(250)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0.02)
model.run()
model.export_sir()
end

twoway line S I R t,  name(anc1, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all
//endex
//graph anc1

/*txt
{pstd}
Similarly, we can study the potential impact of policies encouraging social
distancing or the wearing of masks by changing the transmissibility
txt*/

//ex
mata:
model.pr_loss(0)
model.tdim(150)
model.transmissibility(0.03)
model.run()
model.export_sir()
end

twoway line S I R t,  name(anc2, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all
//endex
//graph anc2

/*txt
{pstd}
or the potential impact of a lockdown, which would influence the number of 
people someone is in contact with
txt*/

//ex
mata:
model.transmissibility(0.045)
model.mcontacts(3)
model.run()
model.export_sir()
end

twoway line S I R t,  name(anc3, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all
//endex
//graph anc3

/*txt 
{pstd}
or the impact of vaccinating a quarter of the population
txt*/

//ex
mata:
model.mcontacts(4)
model.removed(500)
model.run()
model.export_sir()
end

twoway line S I R t,  name(anc4, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all
//endex
//graph anc4

//endanc ---------------------------------------------------------------------

//anc --------------------------------------------------------------------------
//title Quantifying uncertainty

/*txt
{pstd}
ABMs are simulations, so the outcome could easily differ from run to run

{pstd}
One could display the outcome from multiple runs

{pmore} Either because this gives a more complete description of an ABM

{pmore} or because this variation is interesting in and of itself
txt*/

//ex
set seed 123456789
clear mata
drop _all
run sir_main.do

mata:

model = sir()
model.N(2000)
model.tdim(150)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0)

base = "t", "S", "I", "R"
for(i=1; i<=10; i++){
    model.run()
    names = J(1,4,"")
    for(j=1; j<=4; j++) {
        names[j] = base[j] + strofreal(i)
    }
    model.export_sir(names)
}
end

twoway line S* t1, lcolor(green ..)            || ///
       line I* t1 , lcolor(orange ..)          || ///
       line R* t1, lcolor(blue ..)                ///
       legend(order(1 "S" 11 "I" 21 "R") cols(3)) ///
       ylab(,angle(0)) name(anc5, replace)
//endex
//graph anc5
//endanc -----------------------------------------------------------------------

//slide ------------------------------------------------------------------------
//title Adding a network

/*txt
{pstd}
The model thus far does not need a simulation; one can compute them with a set
of differential equations. 

{pstd}
In Stata you can do that with {cmd:epimodels} by Sergiy Radyakin and Paolo Verme

{pstd}
However, the advantage of Agent Based Models is that it is much easier to expand
the model.

{pstd}
For example, what if we don't believe that people contact each other randomly 
but instead it is a network that determines who contacts who. 

{pstd}
A common model that works fairly well for a lot of social networks is a small 
world network:

{pmore}
We assume all agents are on a circle, and that each agent is connected to the 4
closes agents.

{pmore}
However, a small number of these connections are replaced by a connection to a
random agent
txt*/

//ex
clear mata
drop _all
set seed 28863
run nw_main.do
mata:
model = sir_nw()
model.N(100)
model.tdim(10)
model.outbreak(2)
model.degree(4)
model.pr_long(.05)
model.transmissibility(0.1)
model.mindur(5)
model.meandur(6)
model.pr_loss(0.00)
model.run()
model.export_nw()
end

gen x_ego = cos((ego-1)/`n'*2*_pi)*(1+mod(ego,2)*.2)
gen y_ego = sin((ego-1)/`n'*2*_pi)*(1+mod(ego,2)*.2)
gen x_alter = cos((alter-1)/`n'*2*_pi)*(1+mod(alter,2)*.2)
gen y_alter = sin((alter-1)/`n'*2*_pi)*(1+mod(alter,2)*.2)
    

bys ego (alter) : gen first = _n == 1

forvalues t = 1/10{
    twoway pcspike y_ego x_ego y_alter x_alter,                ///
                  lcolor(gs8)                               || ///
        scatter y_ego x_ego if first & state`t'==1 ,           ///
                   mcolor(yellow) msymbol(O)                || ///
        scatter y_ego x_ego if first & state`t'==2 ,           ///
                   mcolor(red) msymbol(O)                   || ///
        scatter y_ego x_ego if first & state`t'==3 ,           ///
                   mcolor(black) msymbol(Oh)                   ///         
                   aspect(1) xscale(off) yscale(off)           ///
                   legend(order(2 "susceptible"                ///
                                3 "infected"                   ///
                                4 "recovered") rows(1))        ///
                   name(t`t', replace) title(Time `t')     
}
drop _all
//endex
//graph t1
//graph t2
//graph t3
//graph t4
//graph t5
//graph t6
//graph t7
//graph t8
//graph t9
//graph t10

//file nw_chks.do        
//file nw_cscript.do     
//file nw_export.do      
//file nw_locals.do      
//file nw_main.do        
//file nw_set_pars.do    
//file nw_sim.do  

/*txt
{pstd}
Close knit networks tend to slow down the spread of a disease, while the long 
distance ties tend 

{pstd}
So that is one way in which advise against unnecesary travel or "social buble"
rules in countries like Belgium works
txt*/
//endslide ---------------------------------------------------------------------

//anc ------------------------------------------------------------------------
//title Other scenarios

/*txt
{pstd}
We can try to quantify the impact of reducing the number of long distance 
by comparing the following models:
txt*/

//ex
clear mata
set seed 28863
run nw_main.do
mata:
model = sir_nw()
model.N(2000)
model.tdim(150)
model.outbreak(10)
model.degree(10)
model.pr_long(.2)
model.transmissibility(.018)
model.mindur(10)
model.meandur(14)
model.pr_loss(0.00)
model.run()
model.export_sir()
end

twoway line S I R t,  name(sir3, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 
drop _all

mata:
model.pr_long(.05)
model.run()
model.export_sir()
end

twoway line S I R t,  name(sir4, replace)          ///
   ylabel(,angle(0)) legend(rows(1)) lwidth(*1.5 ..) 

drop _all
//endex
//graph sir3
//graph sir4
//endanc -----------------------------------------------------------------------

//slide ------------------------------------------------------------------------
//title Multiple towns on a grid

/*txt
{pstd}
The basic SIR model could represent how a disease spreads in a specific town

{pstd}
we could place multiple SIR models on a grid (like a chessboard) and see how
the disease spreads across this space 

{pstd}
In the first round a number of people in a single town is infected 

{pstd}
In all subsequent rounds

{pmore}
the disease spreads within each town as before, but then

{pmore}
some agents visit neighbouring town and potentially spread the disease there
txt*/

//ex
set seed 123456789
clear mata
drop _all
run grid_main.do

mata:

model = sir_grid()
model.rdim(10)
model.cdim(10)
model.prop_close(0.15)
model.prop_far(0.01)

model.N(100)
model.tdim(50)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0)

model.run()
model.export_sir()

end

replace r = -r
foreach t of numlist 1 5(5) 50 {
     heatplot I r c if t==`t',          /// 
          discrete title(Time = `t')    ///
          name(grid`t', replace)        ///
          cuts(0(0.05)0.7)              /// 
          colors(plasma)                ///
          yscale(off range(-10.5 -.5))  ///
          xscale(off  range(.5 10.5))   ///
          ylab(none) xlab(none)         ///
          plotregion(margin(zero))      ///
          aspect(1)                                        
}
//endex
//graph grid1
//graph grid5
//graph grid10
//graph grid15
//graph grid20
//graph grid25
//graph grid30
//graph grid35
//graph grid40
//graph grid45
//graph grid50
//file grid_chks.do      
//file grid_export.do    
//file grid_locals.do    
//file grid_main.do      
//file grid_set_pars.do  
//file grid_sim.do       
//file grid_sir_set_pars.do
//file grid_sir_sim.do   
//endslide ---------------------------------------------------------------------

//anc --------------------------------------------------------------------------
//title Other scenarios

/*txt
{pstd}
In the real world population is not uniformly distributed over space

{pstd}
We could try to capture that by including a "big city" in our model.

{pstd}
This can be done by increasing the population in one of the towns.
txt*/

//ex
set seed 123456789
clear mata
drop _all
run grid_main.do

mata:

model = sir_grid()
model.rdim(10)
model.cdim(10)
model.prop_close(0.15)
model.prop_far(0.01)

N = J(10,10,100)
N[5,5] =2000
model.N(N)
model.tdim(100)
model.outbreak(5)
model.mcontacts(4)
model.transmissibility(0.045)
model.mindur(10)
model.meandur(14)
model.pr_loss(0)

model.run()
model.export_sir()

end

replace r = -r
foreach t of numlist 1 5(5) 100 {
     heatplot I r c if t==`t',          /// 
          discrete title(Time = `t')    ///
          name(ancgrid`t', replace)        ///
          cuts(0(0.05)0.7)              /// 
          colors(plasma)                ///
          yscale(off range(-10.5 -.5))  ///
          xscale(off  range(.5 10.5))   ///
          ylab(none) xlab(none)         ///
          plotregion(margin(zero))      ///
          aspect(1)                                        
}
//endex
//graph ancgrid1
//graph ancgrid5
//graph ancgrid10
//graph ancgrid15
//graph ancgrid20
//graph ancgrid25
//graph ancgrid30
//graph ancgrid35
//graph ancgrid40
//graph ancgrid45
//graph ancgrid50
//graph ancgrid55
//graph ancgrid60
//graph ancgrid65
//graph ancgrid70
//graph ancgrid75
//graph ancgrid80
//graph ancgrid85
//graph ancgrid90
//graph ancgrid95
//graph ancgrid100

//endanc -----------------------------------------------------------------------

//section How to implement an ABM in Mata

//slide ------------------------------------------------------------------------
//title The ABM package

/*txt
{pstd}
The Agent Based Models  implemented in Mata as a /*digr*/

{pstd}
They use a collection of helper classes available in the {browse "https://github.com/maartenteaches/abm":ABM}
package. 

{pstd}
The main classes availbe in the {cmd:abm} package are:

{pmore}
o {help abm_pop} can store a list of agents and their properties. It is 
particulary helpful when at each point in time most agents' properties are
stable, but some change.

{pmore}
o {help abm_nw} for storing and managing a network

{pmore}
o {help abm_grid} for storing and managing a grid (like a chessboard) on which 
agents can "live" and interact with one another.

{pmore}
o {help abm_util} useful functions that can be imported into the model class



txt*/

//endslide ---------------------------------------------------------------------


//digr ------------------------------------------------------------------------
//title Class
//label class

/*txt
{pstd}
We have a population of agents to keep track of

{pstd}
We need to repeatedly apply rules to them

{pstd}
Applying rules can be done by a function, but that function needs access to 
settings and the population. 

{pstd}
This is a good case for a class.

{pstd}
A class can be thought of as a tray with named slots for functions and data

{pstd}
The functions are local to the class

{pstd}
Each function has access to all material stored in the class

txt*/

//ex
clear mata

mata:

class arithmatic {

    real scalar a
    real scalar b
    
    real scalar sum()
    real scalar prod()
    void input()
    void run()
}

void arithmatic::input(real scalar aval, real scalar bval)
{
    a = aval
    b = bval
}

real scalar arithmatic::sum()
{
    return(a + b)
}

real scalar arithmatic::prod()
{
    return(a * b)
}

void arithmatic::run()
{
    sum()
    prod()
}

// how the user interacts with this program
math = arithmatic()
math.input(2,4)
math.run()
end
//endex
//enddigr ---------------------------------------------------------------------


//slide ------------------------------------------------------------------------
//title Basic SIR model

/*txt
{pstd}
Lets take a look at the code for the basic SIR model: 

//codefile sir_main.do here

{pstd}
The model is implemented as a class {cmd:sir}

{pstd}
The sir class inherrits (extends) from {help abm_util}

{pmore}
This gives us access to several {help abm_chk:argument checking functions} and
the {help abm_util:dots()} function

{pstd}
The population is stored is stored in an instance of the class {help abm_pop}.

{pmore}
Whatever is stored in {cmd:abm_pop} is assumed to persist until you store 
something else. So you only have to store the disease state of an agent when it
changes. This can save a lot of reading and writing and make the simulation run
quicker.

{pstd}
There are various checks perfomed and we can see those 

//codefile sir_chks.do here

{pstd}
The functions that set the parameters are shown 

//codefile sir_set_pars.do here 

{pstd}
The main simulation functions are

//codefile sir_sim.do here

{pstd}
The "variables" in {it:agents} are actually numbered and not named. To make it 
easier to read the code I use local macros defined in

//codefile sir_locals.do here

{pstd}
The functions that allow you to export the results to Stata are

//codefile sir_export.do here
txt*/
//endslide ---------------------------------------------------------------------

//slide ------------------------------------------------------------------------
//title SIR model in a network

/*txt
{pstd}
To add the network we make use the {helpb abm_nw} class.

{pstd}
This takes care of creating the network and keeps track of who can contact who.

{pstd}
With that the changes required are fairly small

{pstd}
The class definition is 

//codefile nw_main.do here

{pstd}
Checks and setting parameters are pretty much the same

{pstd}
The main simulation functions are

//codefile nw_sim.do here
txt*/
//endslide ---------------------------------------------------------------------

//slide ------------------------------------------------------------------------
//title SIR model on a grid

/*txt
{pstd}
The sir class remains largely unchanged

{pstd}
The main trick here is that one can create a 10x10 matrix of instances of a class, by 
specifying {cmd:town=sir(10,10)}

{pstd}
The {helpb abm_grid} class is mainly used to find neighbouring towns.


//codefile grid_main.do         "main"
//codefile grid_set_pars.do     "set grid parameters"
//codefile grid_sir_set_pars.do "set SIR parameters"
//codefile grid_chks.do         "checks"
//codefile grid_sir_sim.do      "simulate within the towns"
//codefile grid_sim.do          "simulate the grid"
//codefile grid_locals.do       "locals"
//codefile grid_export.do       "export to Stata"

txt*/

//endslide ---------------------------------------------------------------------

//section Final remarks
//slide ------------------------------------------------------------------------
//title Conclusion

/*txt
{pstd}
Implementing an ABM is doable in Mata 

{pstd}
We have seen four "helper classes" from {cmd:abm}: 

{pmore}{help abm_pop} for storing a population of agents{p_end}
{pmore}{help abm_nw} for managing a network{p_end}
{pmore}{help abm_grid} for managing a grid, like a chessboard.{p_end}
{pmore}{help abm_util} for importing useful functions in the model class{p_end}

txt*/
//endslide ---------------------------------------------------------------------

//anc --------------------------------------------------------------------------
//title Alternative platforms

/*txt
{pstd}
There are various dedicated environments for creating ABMs. 

{pmore}
{bf:netlogo} (netlogo) {browse "http://ccl.northwestern.edu/netlogo/"}

{pmore}
{bf:repast} (java, python, C++, and others) {browse "https://repast.github.io/"}

{pmore}
{bf:mason} (java) {browse "https://cs.gmu.edu/~eclab/projects/mason/"}

{pmore}
{bf:mesa} (python) {browse "https://mesa.readthedocs.io/"}

{pmore}
{bf:agents.jl} (julia) {browse "https://juliadynamics.github.io/Agents.jl/stable/"}

{pstd}
People who primarily create ABMs are not going to move away from those, and 
rightly so.

{pstd}
The toolkits discussed in this presentation are aimed at people who 
primarily use Stata and occationally want to make an ABM.
txt*/

//endanc -----------------------------------------------------------------------
