import perform, handle, Effect from require 'mae'

Print = Effect 'print'
Readline = Effect 'readline'

handle {
	->
		perform Print 'before'
		handle {
			->
				val = perform Readline
				perform Print val
				handle {
					->
						perform Print val

					[Print]: (v) ->
						perform Print 'transformed '..v
				}

			[Readline]: ->
				'not really IO'
		}
		perform Print 'after'
		val = perform Readline -- crashes, nothing handles Readline here

	[Print]: (v) ->
		print v
}

-- prints:
-- before
-- not really IO
-- transformed not really IO 
-- after
-- [crashes]

