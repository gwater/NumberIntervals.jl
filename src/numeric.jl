
import IntervalArithmetic: radius, mid, mag, mig, sup, inf, diam, bisect, dist
export radius, mid, mag, mig, sup, inf, diam, bisect, dist

for f in (:radius, :mid, :mag, :mig, :sup, :inf, :diam)
    @eval $f(a::NumberInterval) = $f(Interval(a))
end

mid(a::NumberInterval, α) = mid(Interval(a), α)

function bisect(a::NumberInterval, α = IntervalArithmetic.where_bisect)
    c, d = bisect(Interval(a), α)
    return NumberInterval(c), NumberInterval(d)
end

function dist(a::NumberInterval, b::NumberInterval)
    return dist(Interval(a), Interval(b))
end
