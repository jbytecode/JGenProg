function GpNeg(x::Number)
    return -x
end

function GpOr(x::Number, y::Number)::Bool
    p1 = !(x == 0)
    p2 = !(y == 0)
    return p1 || p2
end

function GpAnd(x, y)::Bool
    p1 = !(x == 0)
    p2 = !(y == 0)
    return p1 && p2
end

function GpEq(x, y)::Bool
    return x == y
end

function GpIf(cond, ifT, ifF)
    pcond = cond
    if !(pcond isa Bool)
        pcond = Bool(!(cond == 0))
    end
    if pcond
        return ifT
    else
        return ifF
    end 
end

function GpSqrt(val)
    if val < 0
        return 0
    else
        return sqrt(val)
    end
end


function GpLn(val)
    if val < 0
        return 0
    else
        return log(val)
    end
end

function GpPow(val, power)
    return Float64(val)^Float64(power)
end