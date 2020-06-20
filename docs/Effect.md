# `Effect<'a, 'b>`
An `Effect` represents an algebraic effect.

The `'a` type is the type of the arguments the effect takes, and `'b` is the type of the value the effect returns

## `Effect.name: string`
The name of the effect, only used for debugging (it is included in the error message if the effect cannot be dispatched)

## `Effect(args): 'a -> Effect<'a, 'b>, 'a`
Calling an `Effect` just returns the effect and the arguments, it's useful for making syntax more legible

```moon
perform Print 'test'
-- sugar for
perform Print, 'test'
```

## `Effect\perform(args): 'a -> 'b`
Calling the `perform` method on an `Effect` is just sugar for calling `perform` with the effect

```moon
Print\perform 'test'
-- sugar for
perform Print, 'test'
```

## `Effect\default(fn): fn<'a -> 'b> -> nil`
Sets the default implementation of the effect, to be called if the effect cannot be dispatched instead of crashing.

Not saying you shouldn't do this, but you probably shouldn't do this

