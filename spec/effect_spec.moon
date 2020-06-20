insulate 'effect', ->
	import Effect from require 'mae.effect'

	it 'creates a table with a name', ->
		a = Effect 'test'
		assert.equal 'table', type a
		assert.equal 'test', a.name

	it 'returns itself with arguments when called', ->
		a = Effect 'test'
		b, c = a 'val'
		assert.equal b, a
		assert.equal c, 'val'

		b, c, d = a 'c', 'd'
		assert.equal b, a
		assert.equal c, 'c'
		assert.equal d, 'd'

	it 'can have a default implementation', ->
		a = Effect 'test'
		assert.equal a.defaultimp, nil
		f = ->
		a\default f
		assert.equal a.defaultimp, f

insulate 'effect performing', ->
	maeperform = require 'mae.perform'
	stub maeperform, 'perform'
	import Effect from require 'mae.effect'

	it 'can be performed', ->
		a = Effect 'test'
		a\perform 'aza'
		assert.stub(maeperform.perform).was.called_with a, 'aza'

