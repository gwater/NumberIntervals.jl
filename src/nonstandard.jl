
import Base: <, iszero, ==, <=
export <, iszero, ==, <=

for (numberf, setf) in ((:<, :strictprecedes), (:<=, :precedes))
    @eval function $numberf(a::NumberInterval, b::NumberInterval)
        if $setf(a, b)
            return true
        elseif $setf(b, a)
            return false
        end
        throw(IndeterminateException())
    end
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

function ==(a::NumberInterval, b::NumberInterval)
    if disjoint(a, b)
        return false
    elseif issingleton(a) && issingleton(b) && a ⊆ b
        return true
    end
    throw(IndeterminateException())
end
