cscript
cd "d:\mijn documenten\projecten\stata\abm\abm"
do abm_bc\abm_bc.mata
do abm_chk\abm_chk.mata
do abm_pop\abm_pop.mata

lmbuild labm.mlib, replace dir(.)
mata : mata describe using labm
