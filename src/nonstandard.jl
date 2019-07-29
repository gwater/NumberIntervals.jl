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
    if !contains_zero(a)
        return false
    end
    if a ⊆ zero(NumberInterval)
        return true
    end
    throw(IndeterminateException())
end
