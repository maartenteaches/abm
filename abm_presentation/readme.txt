Readme
======

This .zip file contains the presentation on Agent Based Models I 
gave at the 2021 Belgian Stata Conference. If you extract this 
.zip file, you will get 3 folders:

presentation
------------

This is the folder contains the .smcl presentation. To view this:
o open Stata, 
o use -cd- to change to this directory
o type -view presentation.smcl- 

To run the examples in the presentation you will need the -abm- 
package, swhich you can install by typing in Stata:
-net install abm, from("https://raw.githubusercontent.com/maartenteaches/abm/release")-
For this presentation I used version 0.1.5 of the -abm- package.
The presentation also requires Benn Jann's -heatmap-, -palettes-, 
-colrspace- packages. These can be obtained from SSC.

handout
-------

This contains the .html handout created for this presentation. This 
is particularly useful for quickly looking things up and if you don't 
have Stata installed on your current devise.

source
------

This folder contains the source used to create the presentation. To 
create the presentation from this source:

o open Stata
o Install smclpres by typing -ssc install smclpres-
o use -cd- to change to this directory
o make the presentation by typing 
  -smclpres using presentation.do , dir(../presentation) replace-
o make the handout by changing to presentation directory and type:
  -pres2html using presentation.smcl, dir(../handout) replace-


