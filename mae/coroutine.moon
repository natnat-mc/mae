import create, resume, status, yield from coroutine
import pack3rd, pack2nd, pack, unpackn from require 'mae.util'

local coroutine
coroutine = setmetatable {}, {__index: _G.coroutine}

tryyield = (...) ->
	yield nil, ...

tryresume = (coro, ...) ->
	ok, effect, args = pack3rd resume coro, ...

	-- forward errors
	unless ok
		return ok, effect

	-- return last value
	if (status coro)=='dead'
		return true, effect, unpackn args

	if effect -- immediately pass the effect back and try again
		tryresume coro, yield effect, unpackn args
	else -- we didn't have an effect, we can safely go back to whatever we were doing
		ok, unpackn args

trywrap = (fn) ->
	coro = create fn
	(...) ->
		ok, args = pack2nd tryresume coro, ...
		if ok
			unpackn args
		else
			error args[1]

coroutine.yield = tryyield
coroutine.resume = tryresume
coroutine.wrap = trywrap

coroutine

