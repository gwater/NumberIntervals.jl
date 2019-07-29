
import IntervalArithmetic: (⊆), (≺), contains_zero, isempty, isnan, precedes

export (⊆), (≺), contains_zero, isempty, isnan, precedes

#NOTE missing: interior, disjoint
for f in (:(⊆), :(≺), :precedes)
    @eval $f(a::NumberInterval, b::NumberInterval) = $f(Interval(a), Interval(b))
end

for f in (:contains_zero, :isempty, :isnan)
    @eval $f(a::NumberInterval) = $f(Interval(a))
end

# these fit better in IntervalArithmetic so we don't export them here
issingleton(a::NumberInterval) = iszero(radius(a))
disjoint(a, b) = isempty(a ∩ b)
