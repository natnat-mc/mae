import handle, perform from require 'mae.perform'

describe 'coroutine', ->
	describe 'wrap', ->
		import wrap, yield from require 'mae.coroutine'

		it 'returns a function', ->
			assert.equal 'function', type wrap ->

		it 'works like the native wrap', ->
			w = wrap ->
				yield 1
				yield 2
				yield 9
				5
			assert.equal 1, w!
			assert.equal 2, w!
			assert.equal 9, w!
			assert.equal 5, w!

		it 'works inside handle', ->
			handle {
				->
					w = wrap ->
						yield 1
						5
					assert.equal 1, w!
					assert.equal 5, w!
			}

		it 'works through handle', ->
			w = wrap ->
				handle {
					->
						yield 6
				}
				5
			assert.equal 6, w!
			assert.equal 5, w!

		it 'transparently handles effects', ->
			handle {
				->
					w = wrap ->
						yield 1
						yield perform 'add', 5, 1
						yield 2
						3
					assert.equal 1, w!
					assert.equal 6, w!
					assert.equal 2, w!
					assert.equal 3, w!
				add: (a, b) -> a+b
			}

	describe 'resume', ->
		import resume, yield from require 'mae.coroutine'

		it 'works like the native resume', ->
			coro = coroutine.create ->
				yield 1
				b = yield 5
				b+2
			assert.same {true, 1}, {resume coro}
			assert.same {true, 5}, {resume coro}
			assert.same {true, 6}, {resume coro, 4}

		it 'works inside handle', ->
			handle {
				->
					coro = coroutine.create ->
						2+yield 1
					assert.same {true, 1}, {resume coro}
					assert.same {true, 4}, {resume coro, 2}
			}

		it 'works through handle', ->
			coro = coroutine.create ->
				handle {
					->
						yield 2
				}
				3
			assert.same {true, 2}, {resume coro}
			assert.same {true, 3}, {resume coro}

		it 'transparently handles effects', ->
			handle {
				->
					coro = coroutine.create ->
						yield 1
						yield perform 'add', 5, 1
						yield 2
						3
					assert.same {true, 1}, {resume coro}
					assert.same {true, 6}, {resume coro}
					assert.same {true, 2}, {resume coro}
					assert.same {true, 3}, {resume coro}
				add: (a, b) -> a+b
			}

