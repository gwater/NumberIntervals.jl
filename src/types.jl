
import Base: promote_rule, convert, real, show, ==, !
import IntervalArithmetic: Interval

export convert, real, show, ==, !
export NumberInterval, Indeterminate, IndeterminateException,
    is_indeterminate_exception

"""
    IndeterminateException(msg = "")

Exception raised when the result of a numerical operation on a `NumberInterval`
is indeterminate.

See documentation of `Indeterminate` for information on enabling this behavior.
"""
struct IndeterminateException <: Exception
    msg
end
IndeterminateException() = IndeterminateException("")

intercept_exception(::Any) = true

"""
    Indeterminate()

Value returned when the result of a numerical operation on a `NumberInterval`
is indeterminate.

To throw an `IndeterminateException()` instead (*only* for debugging purposes),
extend the `intercept_exception()` function from this module by defining:
```julia
    NumberIntervals.intercept_exception(::IndeterminateException) = false
```
Note that this changes behavior *globally*, across all packages processing
`NumberInterval`s and therefore should never be used in production code.
"""
struct Indeterminate
    function Indeterminate(msg = nothing)
        exc = IndeterminateException(msg)
        intercept_exception(exc) && return new()
        throw(exc)
    end
end

==(a::Indeterminate, b) = Indeterminate(b)
==(a, b::Indeterminate) = ==(b, a)
!(i::Indeterminate) = i

"""
    is_indeterminate_exception(exc::Exception)

Returns boolean indicating whether an exception was caused by an indeterminate
logical operation on intervals. Specifically supports `IndeterminateException`
and `TypeError` (due to *non-Boolean used in Boolean context*).
"""
is_indeterminate_exception(::Exception) = false
is_indeterminate_exception(::IndeterminateException) = true
is_indeterminate_exception(exc::TypeError) = isa(exc.got, Indeterminate)

function _is_valid_interval(lo, hi)
    if isinf(lo) && lo == hi
        return false # intervals cannot represent infinities
    elseif hi >= lo
        return true
    elseif hi == -Inf && lo == Inf
        return true # allow empty interval
    elseif isnan(hi) && isnan(lo)
        return true # allow NaN interval
    end
    return false
end

"""
    NumberInterval(lo, hi)

Interval which behaves like a number under standard arithmetic operations and
comparisons and raises an `IndeterminateException` when the results of these
operations cannot be rigorously determined.
"""
struct NumberInterval{T <: AbstractFloat} <: AbstractFloat
    lo::T
    hi::T
    NumberInterval(lo, hi) = _is_valid_interval(lo, hi) ?
        new{typeof(lo)}(lo, hi) : error("invalid interval ($lo , $hi)")
end

# for now only treat Reals; restriction from IntervalArithmetic
NumberInterval(a::T, b::T) where T <: Union{Integer, Rational, Irrational} =
    NumberInterval(float(a), float(b))

NumberInterval(a::Interval) = NumberInterval(a.lo, a.hi)
(::Type{NumberInterval{T}})(a::NumberInterval{T}) where T = a

Interval(a::NumberInterval) = Interval(a.lo, a.hi)

NumberInterval(a) = NumberInterval(Interval(a))
NumberInterval(a::NumberInterval) = a
NumberInterval{T}(a) where T = NumberInterval(Interval{T}(a))
NumberInterval{S}(a::T) where {S, T <: Union{Integer, Rational, Irrational}} =
    NumberInterval(Interval{S}(a))

real(a::NumberInterval{T}) where {T <: Real} = a

_promote_interval_type(::Type{Interval{T}}) where T = NumberInterval{T}
_promote_interval_type(a::Type) = a

# promote everything like Interval, except promote Interval to NumberInterval
promote_rule(::Type{NumberInterval{T}}, b::Type) where T =
    _promote_interval_type(promote_rule(Interval{T}, b))

function show(io::IO, i::NumberInterval)
    print(io, "x ∈ ")
    show(io, Interval(i))
end
