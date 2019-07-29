# NumberIntervals.jl

A package for strict intervals-as-numbers.

# Description

This package aims to provide intervals which can be safely used as drop-in replacements for numbers in Julia.

It builds on `IntervalArithmetic.jl`s implementation of the IEEE 1788-2015 standard.

However, the `NumberInterval` type behaves more predictably and cautious in many contexts than the `Interval` type:

```
julia> using NumberIntervals, IntervalArithmetic

julia> iszero(Interval(-1, 1))
false

julia> iszero(NumberInterval(-1, 1))
ERROR: IndeterminateException()
Stacktrace:
 [1] iszero(::NumberInterval{Int64}) at /home/jgraw/Projekte/julia-packages/NumberIntervals/src/NumberIntervals.jl:59
 [2] top-level scope at none:0
```

In this case, we cannot tell if the interval (-1, 1) represents zero or not; so we provide an exception. The `IntervalArithmetic` is more generous, increasing risk of silent failure.

In safe cases, we provide the expected result:

```
julia> iszero(NumberInterval(-2, -1))
false

julia> iszero(NumberInterval(-0, +0))
true
```
