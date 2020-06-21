mae = require 'mae'

describe 'mae', ->
	it 'exports Effect', ->
		import Effect from require 'mae.effect'
		assert.equal mae.Effect, Effect

	it 'exports handle and perform', ->
		import handle, perform from require 'mae.perform'
		assert.equal mae.handle, handle
		assert.equal mae.perform, perform

	it 'exports effects and value', ->
		import effects, value, wrap from require 'mae.sugar'
		assert.equal mae.effects, effects
		assert.equal mae.value, value
		assert.equal mae.wrap, wrap

	it 'exports coroutine', ->
		coroutine = require 'mae.coroutine'
		assert.equal mae.coroutine, coroutine

	it 'exports std', ->
		std = require 'mae.std'
		assert.equal mae.std, std

