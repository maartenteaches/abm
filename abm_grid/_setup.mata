mata:
void abm_grid::is_setup() 
{
	if (setup == 0) {
		_error(3000, "running setup() before this function is required")
	}
}

void abm_grid::is_valid_cell(real matrix cells)
{
	if (torus == 0) {
		if (any(out_of_bounds(cells))) {
			_error("position invalid")
		}
	}
	else{
		is_setup()
		if (cols(cells)!=2) {
			_error("position invalid")
		}
		is_int(cells)
	}
}

void abm_grid::new()
{
	setup = 0
    bc_setup()
}

void abm_grid::setup()
{
	if (cdim==.) {
		_error(3351, "cdim() must be specified first")
	}
	if (rdim==.) {
		_error(3351, "rdim() must be specified first")
	}
	if (tdim==.) {
		tdim = 1
	}
	if (idim==.) {
		idim = 1
	}
	if (neumann==.) {
		neumann = 0
	}
	if (torus==.) {
		torus = 0
	}
	if (randit==.) {
		randit = 0
	}
	baserings()
	basecoords()
	universe.reinit("real", 4)
	universe.notfound(J(1,0,.))
	size = rdim*cdim
	setup = 1
}

end
