# coroutine wrapper
Wrappers around the coroutine lib to make it safe to use with `mae`

## `resume(co, args): coroutine, any... -> (true, any... | false, string)`
Wraps the native `coroutine.resume` function with one that transparently forwards effects

## `yield(args): any... -> any...`
Wraps the native `coroutine.yield` function with one that doesn't trigger effects

## `wrap(fn): fn -> fn`
Wraps the native `coroutine.wrap` function with one that transparently forwards effects

## everything else
Everything else comes directly from the native coroutine lib, so you can just import this one in its place

