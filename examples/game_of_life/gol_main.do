cscript

mata:
class gol extends abm_util
{
    class abm_pop  scalar state 
    class abm_grid scalar grid
    
    real           scalar rdim
    real           scalar cdim
    real           scalar tdim
    real           matrix init_state
    real           matrix N_alive
    real           matrix future_N_alive
    
    // gol_pars.do
    transmorphic          rdim()
    transmorphic          cdim()
    transmorphic          tdim()
    transmorphic          init_state()
    
    // gol_sim.do
    void                  setup()
    void                  step()
    real           scalar N_alive() 
    real           scalar make_id()
    void                  born()
    void                  died()
    void                  run()
    void                  extract()
    
}

end

do gol_pars.do
do gol_sim.do
