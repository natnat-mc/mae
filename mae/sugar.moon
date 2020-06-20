import handle from require 'mae.perform'

handlermeta = {
	__index: {
		handle: (effect, fn) =>
			@handlers[effect] = fn

		unhandle: (effect) =>
			@handlers[effect] = nil

		run: (fn) =>
			@value = handle fn, @handlers
	}
}

effects = ->
	setmetatable {handlers: {}}, handlermeta

value = (obj) ->
	obj.value

{
	:effects, :value
}

