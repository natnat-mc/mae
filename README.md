# mae
A smol library for algebraic effects in moonscript (and lua), backed by coroutines

## What is this
See [the overreacted post](https://overreacted.io/algebraic-effects-for-the-rest-of-us/) for an explanation.

Basically, you can see this like errors you can recover from, or actions you can define somewhere else.

This implementation probably doesn't cover the full potential of algebraic effects, but is enough for a few basic uses

## Why is this
- First, because I could
- Second, because I don't like [eff](https://github.com/Nymphium/eff.lua)'s syntax

## Should I use this
Probably not

If you're in a situation that requires you to use algebraic effects, you probably shouldn't be using moonscript (or lua).
This is also quite slow, because it uses coroutines, and can cause problems if other libraries also use coroutines

## Do you have examples
Yes, see `examples/*.moon`

## Can I use this in lua
Yes, but it's going to look uglier

## What's the license
MIT

