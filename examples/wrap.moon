import wrap, perform, Effect from require 'mae'

Print = Effect 'Print'

withprint = wrap {
	[Print]: print
}

withprint ->
	perform Print 'test'

-- prints:
[[
test
]]

