{smcl}
{* *! version 1.0.0 04Feb2021 MLB}{...}
{vieweralsosee "help abm" "help abm"}{...}
{vieweralsosee "help abm_grid_protected" "help abm_grid protected"}{...}
{p2colset 1 19 21 2}{...}
{p2col:{bf:abm_grid class} {hline 2}}class for managing a grid in agent based 
models{p_end}
{p2colreset}{...}

{marker description}{...}
{title:Description}

{pstd}
An important type of Agent Based Models lets the agents occupy a position
in a square grid. The importance of that is that the grid defines 
who the neighbours of the agents are. This typically determines with whom 
an agent interacts. The {cmd:abm_grid} class contains a set of functions
that allows one to set up such a grid, find neighbourhoods of cells, and 
manipulate the contents.

{pstd}
An instance of an {cmd:abm_grid} class can store for each cell the id of one or 
more agents that lives there. It does not store the characteristics of those 
agents. That is typically done in a separate matrix,
{help mf_associativearray:associative array}, or {help abm_pop} class.

{p 4 4 2}
You will mainly interact with the {cmd:abm_grid} class through the following
public functions:

{p 5 5 2}{it:Public functions}{p_end}
{p2colset 8 24 26 8}{...}
{p2line -2 0}
{p2col 6 23 25 8:{it:Setup}}{p_end}
{p2col:{helpb abm_grid_rdim:rdim()}}set or return the number of rows {p_end}
{p2col:{helpb abm_grid_rdim:cdim()}}set or return the number of columns {p_end}
{p2col:{helpb abm_grid_rdim:tdim()}}set or return the number of iterations {p_end}
{p2col:{helpb abm_grid_rdim:idim()}}set or return the number of agents that can 
occupy a cell{p_end}
{p2col:{helpb abm_grid_neumann:neumann()}}set or return whether Von Neumann (1) 
or Moore (0) neighbourhoods are used {p_end}
{p2col:{helpb abm_grid_torus:torus()}}set or return whether (1) or not (0) the 
grid wraps around {p_end}
{p2col:{helpb abm_grid_randit:randit()}}set or return whether (1) 
{help abm_grid_schedule:schedule()} returns a list of all coordinates in random 
order, or (0) in a fixed order. {p_end}
{p2col:{helpb abm_bc_abm_version:abm_version()}}sets the version of {cmd:abm} used. {p_end}
{p2col:{helpb abm_grid_setup:setup()}}sets defaults and creates the necessary 
internal variables. {p_end}

{p2col 6 23 25 8:{it:Return}}{p_end}
{p2col:{helpb abm_grid_size:size()}}returns the number of cells ({it:rdim} X 
{it:cdim}) {p_end}
{p2col:{helpb abm_grid_findring:find_ring()}}returns coordinates of a ring of 
neighbouring cells{p_end}
{p2col:{helpb abm_grid_findspiral:find_spiral()}}returns coordinates of a spiral 
of neighbouring cells
{p_end}
{p2col:{helpb abm_grid_schedule:schedule()}}returns coordinates of all cells{p_end}
{p2col:{helpb abm_grid_random_cell:random_cell()}}returns coordinates of a 
random cell{p_end}

{p2col 6 23 25 8:{it:Agents}}{p_end}
{p2col:{helpb abm_grid_create_agent:create_agent()}}create an agent id at a given 
location on a given cell{p_end}
{p2col:{helpb abm_grid_delete_agent:delete_agent()}}delete an agent id at a given 
location on a given cell{p_end}
{p2col:{helpb abm_grid_delete_agents:delete_agents()}}delete all agent ids at a given cell{p_end}
{p2col:{helpb abm_grid_has_agent:has_agent()}}returns whether (1) or not (0) a 
cell contains one or more agents{p_end}
{p2col:{helpb abm_grid_agent_id:agent_id()}}returns the agent id for a given 
location in a cell{p_end}
{p2col:{helpb abm_grid_agent_ids:agent_ids()}}returns the agent ids for all 
agents living in a given cell{p_end}
{p2col:{helpb abm_grid_free_spot:free_spot()}}returns a position in a cell (dimension {it:i} 
in the adress {it:r}, {it:c}, {it:t}, {it:i}) that is free{p_end}
{p2col:{helpb abm_grid_copy_agent:copy_agent()}}copies the agent id from a given location at a given 
cell to a new location on a new cell{p_end}
{p2col:{helpb abm_grid_copy_agents:copy_agents()}}copy all agent ids from a given cell to another 
cell{p_end}
{p2col:{helpb abm_grid_copy_grid:copy_grid()}}copy all agent ids from all cells at a given 
iteration to another iteration{p_end}
{p2col:{helpb abm_grid_move_agent:move_agent()}}move an agent id from one location on one cell to
 another location on another cell{p_end}
{p2col:{helpb abm_grid_move_agents:move_agents()}}move all agent ids from a given cell to another 
cell{p_end}

{p2col 6 23 25 8:{it:relationship between two cells}}{p_end}
{p2col:{helpb abm_grid_dist:dist()}}returns the distance between two cells{p_end}
{p2col:{helpb abm_grid_find_line:find_line()}}returns the coordinates of all cells
on a straight line between two cells{p_end}

{p2col 6 23 25 8:{it:Export}}{p_end}
{p2col:{helpb abm_grid_extract:extract()}}returns a matrix, where each row contains the row, 
column, iteration, location number and the agent id{p_end}
{p2line -2 0}


{title:Remarks}

{p 4 4 2}
The {cmd:abm_grid} class also contains a number of protected functions and 
variables. These cannot be accessed directly, but if you create a new class that
inherits from {cmd:abm_grid} you will, within that class, have access to them. 
This is helpful if you want to change function (functions with the same name 
in the new class will take precedence over the functions with that name in 
{cmd:abm_grid}), or add functions. These are documented 
{help abm_grid_protected:here}.


{title:Example}

{pstd}
Below is an example Agent Based Model that illustrates how a sufficiently high
immunization rate protects even the non-immunized individuals in a population, 
and also allows one to explore at what immunization rate this protection 
disappears.

{pstd}
In this model a single agent lives in each cell and does not move. So as far as
the grid is concerned the row and column number are enough to identify the agent.

{pstd}
An agent could have 5 states. She could be:

{pmore}immunized{p_end}
{pmore}not-immunized and vulnerable{p_end}
{pmore}not-immunized and infected{p_end}
{pmore}not-immunized and infectious{p_end}
{pmore}not-immunized, healed, and no longer vulnerable{p_end} 

{pstd}
In the first round a single random vulnerable agent becomes infected. In all 
subsequent rounds all infected agents become infectious, and infect all 
vulnerable agents within {it:radius} cell radius. All infectious agents become 
healed and non longer vulnerable.

{pstd}
Notice that the immunized agents do nothing in this model, other than not get 
infected and thus potentially block the spread of the disease. So to save space
and time the immunized agents are not even created in this implementation of the
model.

{pstd}
Also notice that there is a time dimension in this model, but it is not part of
the grid but part of the associative array that stores the agents' 
characteristics.


{cmd}
    set seed 1234567
    clear all
    // -----------------------------------class definitions
    
    // define different statuses the agents could have
    local vulnerable = 0
    local infected   = 1
    local infectious = 2
    local healed     = 3
    local immunized  = 4
    
    mata
    
    // this allows you to change or add to the grid class when needed
    class grid extends abm_grid
    {
    
    }
    
    // the main agent based model
    class immune extends abm_util
    {
        private:
            class grid scalar universe
            class AssociativeArray scalar agents

            real scalar  not_vaccinated
            real scalar  tdim
            real scalar  radius
            real matrix  infected
            real scalar  n_infected
            
            void         setup_grid()
            void         setup_agents()
            void         create_agents()
            void         populate_universe()
            void         copy_agents()
            void         infect()
            real scalar  status()
            void         initial_infection()
            
        public:
            transmorphic rdim()
            transmorphic cdim()
            transmorphic tdim()
            transmorphic torus()
            transmorphic not_vaccinated()
            transmorphic radius()
            void         run()
            real scalar  n_infected()
            void         extract()
    }

    // --------------------------------------setup the grid
    transmorphic immune::rdim(| real scalar dim) 
    {
        if (args() == 1) {
            is_posint(dim)
            universe.rdim(dim)
        }
        else {
            return(universe.rdim())
        }
    }
    transmorphic immune::cdim(| real scalar dim) 
    {
        if (args() == 1) {
            is_posint(dim)
            universe.cdim(dim)
        }
        else {
            return(universe.cdim())
        }
    }
    transmorphic immune::torus(| real scalar val)
    {
        if (args() == 1) {
            is_bool(val)
            universe.torus(val)
        }
        else {
            return(universe.torus())
        }
    }
    void immune::setup_grid()
    {
        universe.abm_version("0.1.4")
        if (universe.torus() == . ) {
            universe.torus(1)
        }
        universe.setup()
    }
    
    // ------------------------------------- setup agents
    
    transmorphic immune::not_vaccinated(| real scalar dim) 
    {
        if (args() == 1) {
            is_posint(dim)
            
            not_vaccinated = dim
        }
        else {
            return(not_vaccinated)
        }
    }    
    transmorphic immune::tdim(| real scalar dim)
    {
        if (args() == 1) {
            is_posint(dim)
            tdim = dim
        }
        else {
            return(tdim)
        }
    }
    
    transmorphic immune::radius(| real scalar number)
    {
        if (args() == 1) {
            is_posint(number)
            radius = number
        }
        else {
            return(radius)
        }
    }

    void immune::setup_agents()
    {
        if (tdim == .) {
            _error(3000, "tdim must be specified")
        }
        if (not_vaccinated == .) {
            _error(3000, "not_vaccinated must be specified")
        }
        if (not_vaccinated > universe.size()) {
            _error(3000, "specified more not vaccinated agents than cells on grid")
        }
        if (radius == .) {
            radius = 2
        }
        
        agents.reinit("real", 2)
    }
    
    // -------------------------------- helper functions
    
    real scalar immune::status(real scalar r, real scalar c, real scalar t)
    {
        real scalar    id
        real rowvector key
        
        if (universe.has_agent(r,c)) {
            id = universe.agent_id(r,c)
            key = id, t
            return(agents.get(key))    
        }
        else {
            return(`immunized')
        }
    }
    
    void immune::copy_agents(real scalar t) 
    {
        real scalar    i, content
        real rowvector key
        
        for(i=1 ; i <= not_vaccinated ; i++) {
            key = i,t
            content = agents.get(key)
            key = i,t+1
            agents.put(key,content)
        }
    }
    
    // ----------------- return the results of the model
    
    real scalar immune::n_infected() {
        return(n_infected)
    }
    
    void immune::extract(string rowvector names) 
    {
        real matrix grid, ag
        real rowvector idx
        real colvector status
        real scalar i
        
        if (cols(names) != 5) {
            _error(3000, "5 names need to be specified")
        }
        grid = universe.extract()
        _sort(grid,5)
        grid = grid[.,(1,2)]
        grid = J(tdim+1,1,grid)
        
        ag = agents.keys()
        _sort(ag,(2,1))
        
        status = J(rows(ag),1,.)
        for(i=1 ; i<= rows(ag); i++) {
            status[i] = agents.get(ag[i,.])
        }
        ag = ag, status, grid
        
        idx = st_addvar("float", names)

        if (st_nobs() < rows(ag) ) {
            st_addobs(rows(ag) - st_nobs())
        }
        st_store(.,idx,ag)
    }
    
    // ----------------------------------- run the model
    
    void immune::create_agents() 
    {
        real scalar i, id
        real matrix unvac
        
        for (i = 1 ; i <= not_vaccinated ; i++) {
            agents.put((i,1),0)
        }
    }
    
    void immune::populate_universe()
    {
        real scalar    i
        real matrix grid
        
        grid = jumble(universe.schedule())

        infected = grid[1,.]
        
        for(i = 1 ; i <= not_vaccinated ; i++) {
            universe.create_agent(grid[i,1],grid[i,2],i)
        }
    }
    
    void immune::initial_infection()
    {
        real scalar id

        id = universe.agent_id(infected[1], infected[2])
        agents.put((id,1),`infected')
        n_infected = 1
    }
    
    void immune::infect(real scalar t)
    {
        real scalar    i, id, r, c, j, rn, cn, idn
        real rowvector key
        real colvector tokeep
        real matrix    neighbours, toadd

        tokeep = J(rows(infected),1,1)
        toadd = J(0,2,.)
        for(i = 1 ; i <= rows(infected) ; i++) {
            r = infected[i,1]
            c = infected[i,2]
            id = universe.agent_id(r, c)
            
            if ( status(r, c, t) == `infectious' ) {
                agents.put((id,t+1),`healed')
                tokeep[i] = 0
            }
            else{
                key = id, t+1
                agents.put(key, `infectious')
                neighbours = universe.find_spiral(r,c,radius)
                
                for (j = 1 ; j <= rows(neighbours); j++) {
                    rn = neighbours[j,1]
                    cn = neighbours[j,2]
                    if ( status(rn,cn,t+1) == 0  ) {
                        idn = universe.agent_id(rn,cn)
                        key = idn,t + 1
                        agents.put(key,`infected')
                        n_infected = n_infected + 1
                        toadd = toadd \ (rn,cn)
                    }
                }
            }
        }
        infected = select(infected, tokeep)
        infected = infected \ toadd
    }
    
    void immune::run()
    {    
        real scalar t

        setup_grid()
        setup_agents()
        create_agents()
        populate_universe()
        initial_infection()
        for(t=1; t <= tdim ; t++) {
            copy_agents(t)
            infect(t)
        }
    }
    end
    
    // run a single model and graph the evolution of the infection over time
    mata
    season = immune()
    season.rdim(40)
    season.cdim(40)
    season.tdim(20)
    season.radius(2)
    season.not_vaccinated(400)
    season.run()
    season.extract(("id", "time", "status", "y", "x"))
    st_local("rdim", strofreal(season.rdim()))
    st_local("cdim", strofreal(season.cdim()))
    st_local("tdim", strofreal(season.tdim()))
    end
    
    replace y = - y // I think of the (1,1) cell in a grid as the top left cell

    tempfile data
    save `data'
    drop _all
    set obs `rdim'
    gen x = _n
    expand `cdim'
    bys x : gen y = -_n
    expand `tdim' + 1
    bys y x : gen time = _n
    merge 1:1 x y time using `data'
    assert _merge != 2
    drop _merge
    
    forvalues t = 1/21 {
        scatter y x if status == 0 & time == `t' ,    ///
            msymbol(Oh)                            || ///
        scatter y x if status == 1 & time == `t' ,    ///
            msymbol(S) mcolor(gs8)                 || ///
        scatter y x if status == 2 & time == `t' ,    ///
            msymbol(S)                             || ///
        scatter y x if status == 3 & time == `t' ,    ///
            msymbol(+)                             || ///
        scatter y x if status == . & time == `t',     ///
            msymbol(o) msize(*.10) mcolor(gs8)        ///
            aspect(1) name(gr`t', replace)            ///
            yscale(off range(-41.5 0.5))              ///
            xscale(off range(-0.5 41.5))              ///
            plotregion(margin(zero))                  ///
            legend(order( 1 "vulnerable"              ///
                          2 "infected"                ///
                          3 "infectious"              ///
                          4 "healed/immunized"        ///
                          5 "immunized"))
    }
    
    // run multiple models and plot the seriousness of the infection against 
    // the immunization rate
    mata
    scen = (16, 80, 120, 160, 200, 240, 280, 320, 360, 400)
    res = J(200,2,.)
    k=0
    for (i = 1; i <= 10 ; i++) {
        printf("number of infected: %3.0f \n", scen[i])
        season.not_vaccinated(scen[i])
        for(j = 1; j<= 20; j++) {
            k = k +1
            season.run()
            res[k,.] = scen[i], season.n_infected()
        }
    }
    
    idx =  st_addvar("float", ("N","n"))
    st_addobs(200)
    st_store((1..200)',idx,res)
    end
    
    gen perc_notvac = N/(40*40)*100
    gen perc_inf    = n/N*100
    
    scatter perc_inf perc_notvac, msymbol(o) mcolor(%20) ///
        xtitle("percentage not vaccinated")              ///
        ytitle("percentage infected of not vaccinated ")
{txt}


