local Effect
Effect = require('mae.effect').Effect
local wrap
wrap = require('mae.sugar').wrap
local io = {
  Write = Effect('std.io.Write'),
  Read = Effect('std.io.Read'),
  Flush = Effect('std.io.Flush'),
  Close = Effect('std.io.Close')
}
local with_std_io = wrap({
  [io.Write] = (function()
    local _base_0 = io.stdout
    local _fn_0 = _base_0.write
    return function(...)
      return _fn_0(_base_0, ...)
    end
  end)(),
  [io.Read] = (function()
    local _base_0 = io.stdin
    local _fn_0 = _base_0.read
    return function(...)
      return _fn_0(_base_0, ...)
    end
  end)(),
  [io.Flush] = (function()
    local _base_0 = io.stdout
    local _fn_0 = _base_0.flush
    return function(...)
      return _fn_0(_base_0, ...)
    end
  end)(),
  [io.Close] = (function()
    local _base_0 = io.stdout
    local _fn_0 = _base_0.close
    return function(...)
      return _fn_0(_base_0, ...)
    end
  end)()
})
local log = {
  Fatal = Effect('std.log.Fatal'),
  Error = Effect('std.log.Error'),
  Warn = Effect('std.log.Warn'),
  Info = Effect('std.log.Info'),
  Debug = Effect('std.log.Debug'),
  Trace = Effect('std.log.Trace')
}
local upper, rep, format
do
  local _obj_0 = string
  upper, rep, format = _obj_0.upper, _obj_0.rep, _obj_0.format
end
local logimp
logimp = function(level, fmt, ...)
  return perform(Write(format("[" .. tostring(upper(level)) .. "]" .. tostring(rep(' ', 6 - #level)) .. "%s " .. tostring(fmt) .. "\n", (os.date('%Y-%m-%d %H:%M:%S')), ...)))
end
local with_io_log = wrap({
  [log.Fatal] = function(self, fmt, ...)
    return logimp('fatal', fmt, ...)
  end,
  [log.Error] = function(self, fmt, ...)
    return logimp('error', fmt, ...)
  end,
  [log.Warn] = function(self, fmt, ...)
    return logimp('warn', fmt, ...)
  end,
  [log.Info] = function(self, fmt, ...)
    return logimp('info', fmt, ...)
  end,
  [log.Debug] = function(self, fmt, ...)
    return logimp('debug', fmt, ...)
  end,
  [log.Trace] = function(self, fmt, ...)
    return logimp('trace', fmt, ...)
  end
})
return {
  io = io,
  with_std_io = with_std_io,
  log = log,
  with_io_log = with_io_log
}
