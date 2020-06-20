import perform, handle, Effect from require 'mae'

Print = Effect 'print'

print handle {
	->
		a = 1
		perform Print a
		perform Print 'test'
		'worked'

	[Print]: (v) ->
		print v
}

-- prints:
-- 1
-- test
-- worked

import effects, value, perform, Effect from require 'mae'

Print = Effect 'print'

print value with effects!
	\handle Print (v) ->
		print v

	\run ->
		a = 1
		perform Print a
		perform Print 'test'
		'worked'

-- prints:
[[
1
test
worked
]]

