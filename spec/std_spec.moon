import Effect from require 'mae.effect'
import perform, handle from require 'mae.perform'

describe 'std', ->
	std = require 'mae.std'

	describe 'io', ->
		import io, with_std_io from std

		describe 'effects', ->
			emt = getmetatable Effect!
			import Write, Read, Flush, Close from io

			it 'exists', ->
				assert.equal emt, getmetatable Write
				assert.equal emt, getmetatable Read
				assert.equal emt, getmetatable Flush
				assert.equal emt, getmetatable Close

				assert.equal 'std.io.Write', Write.name
				assert.equal 'std.io.Read', Read.name
				assert.equal 'std.io.Flush', Flush.name
				assert.equal 'std.io.Close', Close.name

		describe 'with_std_io', ->
			it 'calls functions on io.stdout and io.stdin', ->
				pending "can't really be implemented, busted crashes when I mock IO"

	describe 'log', ->
		import log, with_io_log from std

		describe 'effects', ->
			emt = getmetatable Effect!
			import Fatal, Error, Warn, Info, Debug, Trace from log

			it 'exists', ->
				assert.equal emt, getmetatable Fatal
				assert.equal emt, getmetatable Error
				assert.equal emt, getmetatable Warn
				assert.equal emt, getmetatable Info
				assert.equal emt, getmetatable Debug
				assert.equal emt, getmetatable Trace

				assert.equal 'std.log.Fatal', Fatal.name
				assert.equal 'std.log.Error', Error.name
				assert.equal 'std.log.Warn', Warn.name
				assert.equal 'std.log.Info', Info.name
				assert.equal 'std.log.Debug', Debug.name
				assert.equal 'std.log.Trace', Trace.name

		describe 'with_io_log', ->
			it 'calls the Write effect', ->
				pending "how do I test for this, when it needs systime"

