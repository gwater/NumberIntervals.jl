import IntervalArithmetic: (==), (⊆), (≺), contains_zero

export (==), (⊆), (≺), contains_zero

#NOTE missing: interior, disjoint
for f in (:(==), :(⊆), :(≺))
    @eval $f(a::NumberInterval, b::NumberInterval) = $f(Interval(a), Interval(b))
end

for f in (:contains_zero, )
    @eval $f(a::NumberInterval) = $f(Interval(a))
end
