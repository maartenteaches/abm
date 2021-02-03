mata:

real matrix abm_nw::export_adjmat(|real scalar t) 
{
	real matrix res
	real vector dropped, cols
	real scalar i, j

	is_valid_time(t)
	if (t==.) t=0
	if (t== 0) {
		dropped = dropped_nodes0 
	}
	else {
		dropped = *dropped_nodes[t]
	}
	res=J(maxnodes, maxnodes, 0)
	for(i=1; i<=length(dropped); i++) {
	    res[|dropped[i],1\dropped[i],maxnodes|] = J(1,maxnodes,.)
		res[|1,dropped[i]\maxnodes, dropped[i]|] = J(maxnodes,1,.)
	}
	for(i=1; i<=maxnodes; i++) {
	    if(t==0) {
		    cols = *adjlist0[i]
		}
		else {
		    cols = *adjlist[i,t]
		}
		for(j=1; j<=length(cols);j++){
		    res[i,cols[j]] = weight(i,cols[j],t)
		}
	}
	return(res)
}

real matrix abm_nw::export_edgelist(| real scalar t, string scalar ego_all)
{
    real matrix res, temp
	real vector orig, cols, all_nodes, sel
	real scalar i, j, k
	
	is_valid_time(t)
	if (t==.) t=0
	if (t==0) {
		orig = nodes0
	}
	else {
		orig = *nodes[t]
	}
	res = J(0,3,.)
	for(i=1; i<= length(orig); i++) {
		cols = neighbours(orig[i], t)
		temp = J(length(cols),3, .)
		for(j=1; j<=length(cols); j++) {
			temp[j,.] = (orig[i],cols[j],weight(orig[i],cols[j],t))
		}
		res = res \ temp
	}
	if (directed == 0) {
	    res = select(res,res[.,1]:<res[.,2])
	}
	if (args() == 2) {
		all_nodes = schedule(t)
		sel=J(1,cols(all_nodes),1)
		for(i=1; i <= rows(res); i++) {
			k = selectindex(all_nodes:==res[i,1])
			if(cols(k) ==1){
				sel[k] = 0
			}
		}
		temp = select(all_nodes,sel)'
		temp = temp, J(rows(temp),2,.)
		res = res \ temp
	}

	
	_sort(res,(1,2))
	return(res)
}

end
