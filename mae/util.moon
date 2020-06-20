unpack = table.unpack or _G.unpack
pack3rd = (a, b, ...) ->
	c = {...}
	c.n = select '#', ...
	a, b, c

pack2nd = (a, ...) ->
	b = {...}
	b.n = select '#', ...
	a, b

pack = (...) ->
	a = {...}
	a.n = select '#', ...
	a

unpackn = (packed) ->
	unpack packed, 1, packed.n

{
	:pack3rd, :pack2nd, :pack
	:unpackn
}

