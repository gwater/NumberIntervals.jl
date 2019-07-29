
import IntervalArithmetic: radius, mid
export radius, mid

# missing are: inf/sup, wid, mag/mig
for f in (:radius, :mid)
    @eval $f(a::NumberInterval) = $f(Interval(a))
end
