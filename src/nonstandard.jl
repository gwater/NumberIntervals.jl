import Base: <, iszero
export <, iszero

function <(a::NumberInterval, b::NumberInterval)
    if a ≺ b
        return true
    elseif b ≺ a
        return false
    end
    throw(IndeterminateException())
end

function iszero(a::NumberInterval)
    aa = Interval(a)
    if !contains_zero(aa)
        return false
    end
    if aa ⊆ zero(Interval)
        return true
    end
    throw(IndeterminateException())
end
