cscript
cd "d:\mijn documenten\projecten\stata\abm\abm"
do abm.mata

do bench\certify_bc.mata
do bench\certify_chk.mata
do bench\certify_pop.mata
do bench\certify_nw.mata
do bench\certify_grid.mata
do bench\certify_util.mata

do examples/schelling/schelling_run.mata
do examples/sir/sir_run.mata
do examples/sir_nw/nw_run.mata
do examples/game_of_life/gol_run.do
