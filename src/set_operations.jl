
import IntervalArithmetic: ∩

export ∩

for f in (:∩, )
    @eval $f(a::NumberInterval, b::NumberInterval) =
        NumberInterval($f(Interval(a), Interval(b)))
end
