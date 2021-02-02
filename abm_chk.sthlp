{smcl}
{* *! version 1.0.0 01Feb2021 MLB}{...}
{phang}{cmd:abm_chk} {hline 2} Class with functions that aborts with 
an error if arguments don't meet requirements{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:is_posint(}{it:real scalar val}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_posint(}{it:real scalar val}, {it:string scalar zero_ok}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_bool(}{it:real scalar val}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_pr(}{it:real scalar val}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
This class is intended to be inherrited by another class. When it is inherited, it 
will make some error checking functions available as protected functions.   
 These functions test whether common requirements are met, and aborts with an 
error message when that is not the case. {cmd:abm_chk} is inherited 
by {help abm_pop}, {help abm_nw}, and {help abm_grid}.

{pmore}
{cmd:is_posint()} tests whether {it:val} is a positive integer, and aborts with 
an error if that is not the case. The value 0 is allowed if the {it:zero_ok} 
argument is also specified, otherwise the value 0 will also results in an error.

{pmore}
{cmd:is_bool()} tests whether {it:val} is either 0 or 1, and aborts with 
an error if that is not the case.

{pmore}
{cmd:is_pr()} tests whether {it:val} is between 0 and 1 (inclusive), and aborts 
with an error if that is not the case.

{pstd}
{cmd:abm_chk} also inherits from {help abm_bc_protected:abm_bc}.

{marker example}{...}
{title:Example}

{pstd}
Say we are developing a model {cmd:mymodel}, and we want the user to be able to
set some parameter {it:N}, which has to be a positive integer. Than we can inherrit
{cmd:abm_chk} in our model and use {cmd:is_posint()}

{cmd}
    class mymodel extends abm_chk 
    {
        protected:
            real scalar N

        public:
            transmorphic N() 
    }

    transmorphic mymodel::N(|real scalar val)
    {
        if (args()==1) {
            is_posint(val)
            N = val
        }
        else {
            return(N)
        }
    }
{txt}


{marker conformability}{...}
{title:Conformability}

    {cmd:is_posint(}{it:val}{cmd:)}:
           {it:result}:    {it:void}
           {it:val}:       1 {it:x} 1

    {cmd:is_posint(}{it:val}, {it:zero_ok}{cmd:)}:
           {it:result}:   {it:void}
           {it:val}:       1 {it:x} 1
           {it:zero_ok}:   1 {it:x} 1

    {cmd:is_bool(}{it:val}{cmd:)}:
           {it:result}:    {it:void}
           {it:val}:       1 {it:x} 1

    {cmd:is_pr(}{it:val}{cmd:)}:
           {it:result}:    {it:void}
           {it:val}:       1 {it:x} 1           
           