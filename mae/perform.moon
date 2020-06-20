import yield, resume, create, status from coroutine
import pack3rd, pack, unpackn from require 'mae.util'

calldefault = (effect, ...) ->
	unless effect.defaultimp
		error "no default implementation"
	effect.defaultimp ...

perform = (effect, ...) ->
	cok, eok, val = pcall yield, effect, ...
	unless cok -- yield failed, we don't have a parent coroutine or we have trouble with a C function above us
		eok, val = pcall calldefault, effect, ...
	unless eok -- effect failed, crash properly and log the error
		error "failed to run effect #{effect.name}: #{val}"
	val

handleimp = (fn, handlers) ->
	coro = create fn
	nextvals = {n: 0}

	while true
		-- resume the coroutine again and check for its status
		ok, effect, args = pack3rd resume coro, unpackn nextvals
		stat = status coro

		-- forward any error from the coroutine
		unless ok
			error effect

		-- if the coroutine exited successfuly, return whatever it returned
		if stat=='dead'
			return effect, unpackn args

		-- if the coroutine yielded because it had an effect to perform, perform it and give it the results next loop
		if effect
			handler = handlers[effect]
			if handler -- we can perform the effect ourselves
				nextvals = pack pcall handler, unpackn args
			else -- we can't, so we ask our parent to do it for us
				nextvals = pack pcall perform, effect, unpackn args

		-- it yielded for normal coroutine stuff, pass it along
		else
			nextvals = pack yield nil, unpackn args

-- allow for the 2 signatures of handle
handle = (fnortab, handlers) ->
	if (type fnortab)=='table'
		handleimp fnortab[1], fnortab
	else
		handleimp fnortab, handlers

{
	:perform, :handle
}

