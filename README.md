# NumberIntervals.jl

A package for strict intervals-as-numbers.

[![Build Status](https://travis-ci.org/gwater/NumberIntervals.jl.svg?branch=master)](https://travis-ci.org/gwater/NumberIntervals.jl)
[![codecov](https://codecov.io/gh/gwater/NumberIntervals.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/gwater/NumberIntervals.jl)

# Description

This package aims to provide intervals which can be safely used as drop-in replacements for numbers in [Julia](https://julialang.org).

It builds on the [IntervalArithmetic.jl](https://github.com/JuliaIntervals/IntervalArithmetic.jl) implementation of the [IEEE 1788-2015](https://standards.ieee.org/standard/1788-2015.html) standard.

However, our `NumberInterval` type behaves more predictably and cautious in many contexts than the `Interval` type:

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

In this case, we cannot tell if the interval (-1, 1) represents zero or not; so the `NumberInterval` raises an exception. The `IntervalArithmetic` is more forgiving which increases the risk of silent failure in algorithms expecting Number-like behavior.

In safe cases, `NumberInterval` yields the expected result:

```
julia> iszero(NumberInterval(-2, -1))
false

julia> iszero(NumberInterval(-0, +0))
true
```

Check our [example](examples/DifferentialEquationsExample.ipynb) demonstrating how `NumberInterval`s can act as drop-in replacements for numbers without sacrificing numerical validatity.
