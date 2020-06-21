maeperform = require 'mae.perform'
stub maeperform, 'handle'

match = require 'luassert.match'

describe 'sugar', ->
	describe 'effects', ->
		import effects from require 'mae.sugar'

		it 'creates a table with handlers', ->
			a = effects!
			assert.equal 'table', type a.handlers
			assert.same {}, a.handlers

		it 'can add handlers', ->
			a = effects!
			a\handle 'a', 'b'
			assert.same {a: 'b'}, a.handlers
			a\handle 'c', 'd'
			assert.same {a: 'b', c: 'd'}, a.handlers

		it 'can remove handlers', ->
			a = effects!
			a\handle 'a', 'b'
			a\handle 'c', 'd'
			a\unhandle 'a'
			assert.same {c: 'd'}, a.handlers
			a\unhandle 'c'
			assert.same {}, a.handlers

		it 'can call functions', ->
			a = effects!
			f = ->
			a\run f
			assert.stub(maeperform.handle).was.called_with f, match.is_same {}

	describe 'value', ->
		import value from require 'mae.sugar'

		it 'returns the value property of things', ->
			a = {value: 1}
			assert.equal 1, value a

	describe 'wrap', ->
		import wrap from require 'mae.sugar'

		it 'wraps handle', ->
			handlers = {}
			f = ->
			w = wrap handlers
			assert.equal 'function', type w
			w f
			assert.stub(maeperform.handle).was.called_with f, handlers

