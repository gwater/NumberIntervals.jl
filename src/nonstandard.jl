
import Base: <, iszero, ==, <=, >=, sign, signbit, isinteger, isfinite
export <, iszero, ==, <=, >=, sign, signbit, isinteger, isfinite

function isinteger(a::NumberInterval)
    if !issingleton(a)
        throw(IndeterminateException())
    end
    return isinteger(a.lo)
end

function isfinite(a::NumberInterval)
    # FIXME: express condition as a set operation
    if isfinite(a.lo) && isfinite(a.hi)
        return true
    end
    # NOTE unsure if the opposite case can be expressed at all
    # since (Inf, Inf) could have infinite width between the infinities
    throw(IndeterminateException())
end

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

>=(a::NumberInterval, b::NumberInterval) = b <= a

function iszero(a::NumberInterval)
    if !contains_zero(a)
        return false
    end
    if a ⊆ zero(typeof(a))
        return true
    end
    throw(IndeterminateException())
end

function ==(a::NumberInterval, b::NumberInterval)
    if isdisjoint(a, b)
        return false
    elseif issingleton(a) && issingleton(b) && a ⊆ b
        return true
    end
    throw(IndeterminateException())
end

function sign(a::NumberInterval)
    z = zero(typeof(a))
    if strictprecedes(a, z)
        return -1
    elseif strictprecedes(z, a)
        return +1
    elseif a ⊆ z
        return  0
    end
    throw(IndeterminateException())
end

function signbit(a::NumberInterval)
    z = zero(typeof(a))
    if strictprecedes(a, z)
        return true
    elseif precedes(z, a)
        return false
    end
    throw(IndeterminateException())
end
