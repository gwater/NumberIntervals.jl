
import Base: -, +, *, /, abs, abs2, sqrt
export -, +, *, /, abs, abs2, sqrt

for f in (:-, :abs, :abs2, :sqrt)
    @eval $f(a::NumberInterval) = NumberInterval($f(Interval(a)))
end

for f in (:+, :-, :*, :/)
    @eval $f(a::NumberInterval, b::NumberInterval) = NumberInterval($f(Interval(a), Interval(b)))
end
