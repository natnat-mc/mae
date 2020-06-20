import perform from require 'mae.perform'

effectmeta = {
	__call: (...) =>
		@, ...

	perform: (...) =>
		perform @, ...

	default: (imp) =>
		@defaultimp = imp
}
effectmeta.__index = effectmeta

Effect = (name="Unnamed effect") ->
	setmetatable {:name}, effectmeta

{
	:Effect
}

