import effects, perform, Effect from require 'mae'

Print = Effect 'print'
Readline = Effect 'readline'

with effects!
	\handle Print (v) ->
		print v

	\run ->
		perform Print 'before'
		
		with effects!
			\handle Readline ->
				return "not real IO"

			\run ->
				val = perform Readline
				perform Print val

				with effects!
					\handle Print (v) ->
						perform Print "transformed #{v}"

					\run ->
						perform Print val

		perform Print 'after'

		perform Readline -- crashes, nothing handles Readline above here

-- prints:
[[
before
not real io
transformed not real IO
after
[crahes]
]]

