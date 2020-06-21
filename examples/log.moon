import std, perform from require 'mae'
import with_std_io, with_io_log, log from std

with_std_io ->
	with_io_log ->
		perform log.Info '%s', "Some info message"
		perform log.Warn '%s %d', "Some warning message with a number", 5
		perform log.Error "An error message with %d errors", 2

