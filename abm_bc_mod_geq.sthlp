{smcl}
{* *! version 1.0.0 27Jan2021 MLB}{...}
{vieweralsosee "help abm_bc protected" "help abm_bc_protected"}{...}
{phang}
version comparison functions {hline 2} comparing the version stored with an argument{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real scalar}
{cmd:mod_geq(}{it: real rowvector tocheck}{cmd:)}

{p 8 12 2}
{it:real scalar}
{cmd:mod_gt(}{it: real rowvector tocheck}{cmd:)}

{p 8 12 2}
{it:real scalar}
{cmd:mod_leq(}{it: real rowvector tocheck}{cmd:)}

{p 8 12 2}
{it:real scalar}
{cmd:mod_lt(}{it: real rowvector tocheck}{cmd:)}

{p 8 12 2}
{it:real scalar}
{cmd:mod_lt(}{it: real rowvector tocheck}, {it:string scalar max}{cmd:)}


{marker description}{...}
{title:Description}

{pstd}
These function compares the version stored using 
{help abm_bc_abm_version:abm_version()} with the version in the argument.

{phang}
{cmd:mod_geq(}{it: real rowvector tocheck}{cmd:)} checks if the version stored is 
greater than or equal to {it:tocheck}. It returns a 1 if that is true and a 0 if 
that is false.

{phang}
{cmd:mod_gt(}{it: real rowvector tocheck}{cmd:)} checks if the version stored is 
greater than {it:tocheck}. It returns a 1 if that is true and a 0 if 
that is false.

{phang}
{cmd:mod_leq(}{it: real rowvector tocheck}{cmd:)} checks if the version stored is 
less than or equal to {it:tocheck}. It returns a 1 if that is true and a 0 if 
that is false.

{phang}
{cmd:mod_lt(}{it: real rowvector tocheck}{cmd:)} checks if the version stored is 
less than {it:tocheck}. It returns a 1 if that is true and a 0 if 
that is false.

{phang}
{cmd:mod_lt(}{it: real rowvector tocheck}, {it:string scalar max}{cmd:)} checks if 
the current version of {cmd:abm} is less than {it:tocheck}. It returns a 1 if that is true and a 0 if 
that is false.


{marker example}{...}
{title:Example}

{pstd}
Say we have a function {cmd:foo()} inside the {cmd:abm_nw()} class (we don't), and 
this function was updated in versions 1.0.5 and 1.1.0 in a way that would break 
models that use {cmd:abm_nw} from previous versions. We could ensure backwards 
compatability like this. 

{cmd}
    void abm_nw::foo()
    {
        if (mod_geq((1,1,0))) {

        }
        else if (mod_geq((1,0,5))) {

        }
        else {
            
        }
    }
{txt}


{marker conformability}{...}
{title:Conformability}

    {cmd:mod_geq(}{it:tocheck}{cmd:)}:
           {it:result}:   1 {it:x} 1
           {it:tocheck}:  1 {it:x} 3

    {cmd:mod_gt(}{it:tocheck}{cmd:)}:
           {it:result}:   1 {it:x} 1
           {it:tocheck}:  1 {it:x} 3

    {cmd:mod_leq(}{it:tocheck}{cmd:)}:
           {it:result}:   1 {it:x} 1
           {it:tocheck}:  1 {it:x} 3

    {cmd:mod_lt(}{it:tocheck}{cmd:)}:
           {it:result}:   1 {it:x} 1
           {it:tocheck}:  1 {it:x} 3

    {cmd:mod_lt(}{it:tocheck}, {it:max}{cmd:)}:
           {it:result}:   1 {it:x} 1
           {it:tocheck}:  1 {it:x} 3
           {it:max}:      1 {it:x} 1


{marker diagnostics}{...}
{title:Diagnostics}

{p 4 4 2}
{cmd:mod_geq()}, {cmd:mod_gt()}, {cmd:mod_leq()}, {cmd:mod_lt()} abort with an error
if {it:tocheck} is not a three column rowvector containing positive integers.
