import IntervalArithmetic: (==), (⊆), (≺)

export (==), (⊆), (≺)

#NOTE missing: interior, disjoint
for f in (:(==), :(⊆), :(≺))
    @eval $f(a::NumberInterval, b::NumberInterval) = $f(Interval(a), Interval(b))
end
