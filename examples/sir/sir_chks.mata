include examples/sir/sir_locals.mata

mata:

void sir::is_id(real scalar id)
{
	if (id < 0 | id > N | id!=ceil(id)) {
		_error("argument is not a valid id")
	}
	
}

void sir::is_time(real scalar t)
{
	if (t<0 | t > tdim | t!=ceil(t)) {
		_error("argument is not a valid time")
	}
}
end
