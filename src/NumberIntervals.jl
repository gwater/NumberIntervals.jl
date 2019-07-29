module NumberIntervals

using IntervalArithmetic

import Base: +, -, *, /, iszero, isfinite, isnan, promote_rule, abs, <, >, abs2, sqrt, real
import IntervalArithmetic: Interval, convert

export +, -, *, /, iszero, isnan, abs, <, >, isfinite, abs2, sqrt, real
export NumberInterval, convert, IndeterminateException

struct IndeterminateException <: Exception end

struct NumberInterval{T <: Number} <: Number
    lo::T
    hi::T
    NumberInterval(lo, hi) = return hi >= lo ? new{typeof(lo)}(lo, hi) : error("invalid interval ($lo , $hi)")
end

NumberInterval(a::Interval) = NumberInterval(a.lo, a.hi)
(::Type{NumberInterval{T}})(a::NumberInterval{T}) where T = a

Interval(a::NumberInterval) = Interval(a.lo, a.hi)

NumberInterval(a) = NumberInterval(Interval(a))
NumberInterval{T}(a) where T = NumberInterval(Interval{T}(a))

real(a::NumberInterval{T}) where {T <: Real} = a

for f in (:-, :abs, :abs2, :sqrt)
    @eval $f(a::NumberInterval) = NumberInterval($f(Interval(a)))
end

for f in (:+, :-, :*, :/)
    @eval $f(a::NumberInterval, b::NumberInterval) = NumberInterval($f(Interval(a), Interval(b)))
end

_promote_interval_type(::Type{Interval{T}}) where T = NumberInterval{T}
_promote_interval_type(a::Type) = a

promote_rule(::Type{NumberInterval{T}}, b::Type) where T = _promote_interval_type(promote_rule(Interval{T}, b))

function <(a::NumberInterval, b::NumberInterval)
    if a.hi < b.lo
        return true
    elseif b.hi <= a.lo
        return false
    end
    throw(IndeterminateException())
end

function iszero(a::NumberInterval)
    aa = Interval(a)
    if !contains_zero(aa)
        return false
    end
    if aa ⊆ zero(Interval)
        return true
    end
    throw(IndeterminateException())
end

isfinite(a::NumberInterval) = isfinite(a.lo) && isfinite(a.hi)

end # module
