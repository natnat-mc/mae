import effects, perform, Effect, coroutine from require 'mae'

import create, wrap, yield, resume from coroutine

Print = Effect 'Print'

with effects!
	\handle Print print

	\run ->
		perform Print 'begin'
		fn = wrap ->
			for i=1, 5
				perform Print i
				yield i
			'done'
		for i=1, 5
			val = fn!
			perform Print "#{val}."
		perform Print fn!
		perform Print 'end'

-- prints:
[[
begin
1
1.
2
2.
3
3.
4
4.
5
5.
done
end
]]

