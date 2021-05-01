{smcl}
{* *! version 0.1.2 01Feb2021 MLB}{...}
{vieweralsosee "help abm" "help abm"}{...}
{vieweralsosee "help abm_chk" "help abm_chk"}{...}
{phang}{cmd:abm_util} {hline 2} Class with utility functions{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:dots(}{it:real scalar t}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
This class is intended to be inherrited by a model class.  When it is inherited, it 
will make some functions available as protected functions.  It inherrits the argument
checking functions from {help abm_chk} plus it adds the {cmd:dots()} function. 

{pstd}
{cmd:dots()} displays a table of dots that allows the user to monitor the progress
of the simulation. {cmd:dots(0)} will display a ruler for the table of dots on screen.
Other values of {it:t} will add a dot on screen in the table of dots, and values of 
{it:t} that are multiples of 50 will result in a new row in the table of dots.


{marker example}{...}
{title:Example}

{pstd}
Say we are developing a model {cmd:mymodel}, and we want the user to be able to
set some parameter {it:tdim}, which has to be a positive integer. Than we can inherrit
{cmd:abm_util}, which in turn inherits {help abm_chk} in our model and use 
{cmd:is_posint()}.  Inheritting {cmd:abm_util} also makes the {cmd:dots()} function 
available inside {cmd:mymodel}.

{cmd}
    mata:
    mata set matastrict on
    
    class example_model extends abm_util
    {
        protected:
            real scalar  tdim
            void         setup()
        
        public:
            void         run()
            transmorphic tdim()
    }
    
    transmorphic example_model::tdim(| real scalar val)
    {
        if (args() == 1) {
            is_posint(val)
            tdim = val
        }
        else {
            return(tdim)
        }
        
    }
    
    void example_model::setup()
    {
        if (tdim == .) _error("tdim needs to be set first")
        dots(0)
    }
    
    void example_model::run()
    {
        real scalar t
        
        setup()
        
        for (t=1; t<=tdim; t++) {
            dots(t)
        }
    }

    model = example_model()
    model.tdim(500)
    model.run()
    end
{txt}


{marker conformability}{...}
{title:Conformability}

    {cmd:dots(}{it:t}{cmd:)}:
           {it:result}:    {it:void}
           {it:t}:         1 {it:x} 1 
           