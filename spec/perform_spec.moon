import handle, perform from require 'mae.perform'

describe 'handle', ->
	it 'calls functions', ->
		handlers = {}
		f = spy.new -> 'b'
		w = (...) -> f ... -- spies are tables, not functions
		ret = handle w, handlers
		assert.equal ret, 'b'
		assert.spy(f).was.called_with!

	it 'works with a single table', ->
		handlers = {}
		f = spy.new -> 'b'
		w = (...) -> f ...
		handlers[1] = w
		ret = handle handlers
		assert.equal ret, 'b'
		assert.spy(f).was.called_with!

describe 'perform', ->
	it 'works, basically', ->
		handlers = {}
		handlers.test = spy.new (a) -> a*2
		mock(handlers)
		f = ->
			perform 'test', 2
		ret = handle f, handlers
		assert.equal ret, 4
		assert.spy(handlers.test).was.called_with 2

	it 'works when stacked', ->
		ret = handle {
			->
				a = 1
				a = perform 'test', a -- 2
				a = handle {
					->
						perform 'test', a -- 6
					test: (v) -> v*3
				}
				perform 'test', a -- 12
			test: (v) -> v*2
		}
		assert.equal ret, 12

