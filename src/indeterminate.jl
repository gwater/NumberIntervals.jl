
import Base: ==, !

export Indeterminate, ==, !
export IndeterminateException, is_indeterminate_exception

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
