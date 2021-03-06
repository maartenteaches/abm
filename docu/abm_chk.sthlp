{smcl}
{* *! version 1.0.0 01Feb2021 MLB}{...}
{vieweralsosee "help abm" "help abm"}{...}
{phang}{cmd:abm_chk} {hline 2} Class with functions that aborts with 
an error if arguments don't meet requirements{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:void} 
{cmd:is_posint(}{it:real matrix val}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_posint(}{it:real matrix val}, {it:string scalar zero_ok}{cmd:)}

{p 8 12 2}
{it:void}
{cmd:is_int_inrange(}{it:real matrix val}, {it:real scalar lb}, {it:real scalar ub} {cmd:)}

{p 8 12 2}
{it:void}
{cmd: is_int(}{it:real matrix val}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_bool(}{it:real matrix val}{cmd:)}

{p 8 12 2}
{it:void} 
{cmd:is_pr(}{it:real matrix val}{cmd:)}


{marker description}{...}
{title:Description}

{p 4 4 2}
This class is intended to be inherrited by another class. When it is inherited, it 
will make some error checking functions available as protected functions.   
These functions test whether common requirements are met, and aborts with an 
error message when that is not the case. {cmd:abm_chk} is inherited 
by {help abm_pop}, {help abm_nw}, {help abm_grid}, and {help abm_util}.

{pmore}
{cmd:is_posint()} tests whether all elements in {it:val} are positive integers, 
and aborts with an error if that is not the case. The value 0 is allowed if the 
{it:zero_ok} argument is also specified, otherwise the value 0 will also result 
in an error.

{pmore}
{cmd:is_int_inrange} tests whether all elements in {it:val} are integers and 
between {it:lb} and {it:ub}, including {it:lb} and {it:ub}. 

{pmore}
{cmd:is_int()} tests whether all elements in {it:val} are integers, and aborts 
with an error if that is not the case.
 
{pmore}
{cmd:is_bool()} tests whether all elements in {it:val} are either 0 or 1, and 
aborts with an error if that is not the case.

{pmore}
{cmd:is_pr()} tests whether all elements in {it:val} are between 0 and 1 
(inclusive), and aborts with an error if that is not the case.

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
           {it:val}:       {it:r x c} 

    {cmd:is_posint(}{it:val}, {it:zero_ok}{cmd:)}:
           {it:result}:    {it:void}
           {it:val}:       {it:r x c}
           {it:zero_ok}:   1 {it:x} 1

    {cmd:is_int_inrange(}{it:val}, {it:lb}, {it:ub} {cmd:)}:
           {it:result}:    {it:void}
           {it:val}:       {it:r x c}
           {it:lb}:        1 {it:x} 1
           {it:ub}:        1 {it:x} 1

    {cmd:is_int(}{it:val}{cmd:)}:
           {it:result}:    {it:void}
           {it:val}:       {it:r x c}

    {cmd:is_bool(}{it:val}{cmd:)}:
           {it:result}:    {it:void}
           {it:val}:       {it:r x c} 

    {cmd:is_pr(}{it:val}{cmd:)}:
           {it:result}:    {it:void}
           {it:val}:       {it:r x c}            
           