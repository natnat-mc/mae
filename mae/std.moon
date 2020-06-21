import Effect from require 'mae.effect'
import wrap from require 'mae.sugar'
import perform from require 'mae.perform'

io = {
	Write: Effect 'std.io.Write'
	Read:  Effect 'std.io.Read'
	Flush: Effect 'std.io.Flush'
	Close: Effect 'std.io.Close'
}

with_std_io = do
	import \write, \flush, \close from _G.io.stdout
	import \read from _G.io.stdin

	wrap {
		[io.Write]: write
		[io.Read]:  read
		[io.Flush]: flush
		[io.Close]: close
	}

log = {
	Fatal: Effect 'std.log.Fatal'
	Error: Effect 'std.log.Error'
	Warn:  Effect 'std.log.Warn'
	Info:  Effect 'std.log.Info'
	Debug: Effect 'std.log.Debug'
	Trace: Effect 'std.log.Trace'
}

with_io_log = do
	import upper, rep, format from string
	import date from os

	logimp = (level, fmt, ...) ->
		spaces   = rep ' ', 5-#level
		datetime = date '%Y-%m-%d %H:%M:%S'
		prefix   = format '[%s]%s %s ', level, spaces, datetime

		perform io.Write prefix..(format fmt, ...)..'\n'

	wrap {
		[log.Fatal]: (fmt, ...) -> logimp 'FATAL', fmt, ...
		[log.Error]: (fmt, ...) -> logimp 'ERROR', fmt, ...
		[log.Warn]:  (fmt, ...) -> logimp 'WARN',  fmt, ...
		[log.Info]:  (fmt, ...) -> logimp 'INFO',  fmt, ...
		[log.Debug]: (fmt, ...) -> logimp 'DEBUG', fmt, ...
		[log.Trace]: (fmt, ...) -> logimp 'TRACE', fmt, ...
	}

{
	:io, :with_std_io
	:log, :with_io_log
}

