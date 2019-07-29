
import Base: -, +, *, /, ^, abs, abs2, sqrt, exp, exp2, expm1, exp10, log, log2,
    log1p, log10, sin, sinpi, cos, cospi, tan, asin, acos, atan, sinh, cosh,
    asinh, acosh, tanh, atanh, inv, floor, ceil, min, max
export -, +, *, /, ^, abs, abs2, sqrt, exp, exp2, expm1, exp10, log, log2,
    log1p, log10, sin, sinpi, cos, cospi, tan, asin, acos, atan, sinh, cosh,
    asinh, acosh, tanh, atanh, inv, floor, ceil, min, max

for f in (:-, :abs, :abs2, :sqrt, :exp, :exp2, :expm1, :exp10, :log, :log2,
          :log1p, :log10, :sin, :sinpi, :cos, :cospi, :tan, :asin, :acos, :atan,
          :sinh, :cosh, :asinh, :acosh, :tanh, :atanh, :inv, :floor, :ceil)
    @eval $f(a::NumberInterval) = NumberInterval($f(Interval(a)))
end

for f in (:+, :-, :*, :/, :^, :atan, :min, :max)
    @eval $f(a::NumberInterval, b::NumberInterval) =
        NumberInterval($f(Interval(a), Interval(b)))
end

^(a::NumberInterval, n::Union{Integer, Rational, AbstractFloat}) =
    NumberInterval(Interval(a)^n)
