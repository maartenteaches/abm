mata:
real matrix abm_grid::extract()
{

	real matrix res
	real scalar i
	
	is_setup() 
	
	res = universe.keys()
	res = select(res, res[.,4]:!=0)
	res = sort(res,(1,2,3,4))
	res = res, J(rows(res),1,.)
	for(i = 1; i <= rows(res); i++){
		res[i,5] = universe.get(res[i,1..4]) 
	}
	return(res)
	
}

end
