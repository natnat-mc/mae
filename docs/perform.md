# perform
The heart of the library

Safe for use with coroutines, as long as you don't cross them with your effects.
If you need to cross a coroutine with an effect, use `mai.coroutine`

## `handle(fn, handlers): fn<nil -> 'v>, dict<Effect<'a, 'b>> -> 'v`
(also accepts a table with the handlers in hash part and the function in array part)

Calls the given function, and handles the given algebraic effects when the function calls them; returns whatever the function returned

## `perform(effect, args): Effect<'a, 'b>, 'a -> 'b`
Performs an effect, by dispatching it to any compatible handler above in the call stack, or calling the default behavior if one is defined.
If no implementation is found, raises an error

