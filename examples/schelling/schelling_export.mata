
mata:
void schelling::extract(string rowvector names)
{
	real matrix res
	real colvector color, happy
	real rowvector idx
	real scalar id, i, t, r, c
	
	if(cols(names)!=6){
		_error(3300, "names must contain 6 columns")
	}
	
	res = universe.extract()
	color = J(rows(res),1,.)
	happy = J(rows(res),1,.)
	for (i= 1 ; i <= rows(res) ; i++) {
		id = res[i,5]
		color[i] = ( agents[id] == "red" )
		r = res[i,1]
		c = res[i,2]
		t = res[i,3]
		happy[i] = is_happy(t,r,c,t,r,c)
	}
	
	res = res[.,1..3], res[.,5], color, happy
	
	idx = st_addvar("float", names)

	if (st_nobs() < rows(res) ) {
		st_addobs(rows(res) - st_nobs())
	}
	st_store(.,idx,res)
}

real matrix schelling::summ()
{
	real matrix res, prop
	real scalar t, k, r, c
	
	res = J(tdim+1, 3, .)
	res[.,1] = (0..tdim)'

	for(t=0; t <= tdim ; t++){
		prop = J(nagents,2,.)
		k=1
		for (r=1; r<=rdim ; r++) {
			for (c=1 ; c <= cdim ; c++) {
				if (universe.has_agent(r,c,t)) {
					prop[k,1] = sum_neighbours(t,r,c,t,r,c)
					prop[k,2] = is_happy(t,r,c,t,r,c)
					k = k+1
				}
			}
		}
		res[|t+1, 2 \ t+1,3|] = mean(prop)
	}
	return(res)
}

void schelling::summtable(| string scalar matname)
{
	real matrix res
	string scalar cmd
	
	res = summ()
	if (args()==0) {
		matname = st_tempname()
	}
	st_matrix(matname,res)
	st_matrixcolstripe(matname, (J(3,1, "") , ("Iteration" \ "prop_same" \ "prop_happy")) )
	cmd = "matlist " + matname + ", underscore format(%10.3g) names(columns) " +
          "border(rows) " + 
		  "title(Average proportion of neighbours with same color and average proportion of happy agents)"
	stata(cmd)
}

end