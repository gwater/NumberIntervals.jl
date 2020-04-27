
import IntervalArithmetic: ∩, ∪, entireinterval, ∈

export ∩, ∪, entireinterval, ∈

for f in (:∩, :∪, :∈)
    @eval $f(a::NumberInterval, b::NumberInterval) =
        NumberInterval($f(Interval(a), Interval(b)))
    @eval $f(a::Interval{T}, b::NumberInterval{T}) where T =
        NumberInterval($f(a, Interval(b)))
    @eval $f(a::NumberInterval, b::Interval) = $f(b, a)
end
∈(a::Number, b::NumberInterval) = ∈(a, Interval(b))

for f in (:entireinterval, )
    @eval $f(a::NumberInterval) = NumberInterval($f(Interval(a)))
end
