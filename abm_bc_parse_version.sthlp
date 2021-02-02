{smcl}
{* *! version 1.0.0 02Feb2021 MLB}{...}
{vieweralsosee "help abm_bc protected" "help abm_bc_protected"}{...}
{vieweralsosee "help abm_version" "help abm_bc_abm_version"}{...}
{phang}
{cmd:parse_version()} {hline 2} parses the version string{p_end}

{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{it:real vector}
{cmd:parse_version(}{it:string scalar valstr}{cmd:)}


{marker description}{...}
{title:Description}

{pstd}
{cmd:parse_version()} parses a string that is supposed to contain a 
version number, and if succesful returns that version number as a 
three column numeric row vector. If the string violates the rules
for a version number, it will exit with an error. 

{pstd}
These rules are: 

{pmore}
{it:strval} should have the basic form "#.#.#", where "#" has 
to be a positive integer (including 0, and integers larger than 9). 

{pmore}
One can abreviate the version as "#" or "#.#", meaning #.0.0 or 
#.#.0 respectively. However, a version cannot have more than 
three levels.

{pmore}
Spaces are ignored. Any character other than a number, dot, or 
space will result in an error. 


{marker conformability}{...}
{title:Conformability}

    {cmd:parse_version(}{it:valstr}{cmd:)}:
           {it:result}:   1 {it:x} 3
           {it:valstr}:   1 {it:x} 1

