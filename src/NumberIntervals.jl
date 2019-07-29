module NumberIntervals

using IntervalArithmetic

# basic type definitions, conversion rules, etc
include("types.jl")

# import set-like (IEEE conform) behaviors from IntervalArithmetic
include("boolean.jl")
include("numeric.jl")
include("basic.jl")

# define strict number-like arithmetic
include("nonstandard.jl")

end # module
