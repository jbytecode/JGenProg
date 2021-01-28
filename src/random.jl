function randomTerminal(setting::GpSetting)
    return rand(setting.numpool, 1)[1]
end

function randomExpr(setting::GpSetting; depth::Int=1, maxdepth=3)
    if depth == maxdepth
        return randomTerminal(setting)
    end

    gpop = rand(setting.operatorpool, 1)[1]
    argc = getGpArgsCount(gpop)
    args = []

    for i in 1:argc
        push!(args, randomExpr(setting, depth=depth + 1, maxdepth=maxdepth))
    end

    if argc == 1
        return Expr(:call, gpop.sym, args[1])
    elseif argc == 2
        return Expr(:call, gpop.sym, args[1], args[2])
    elseif argc == 3
        return Expr(:call, gpop.sym, args[1], args[2], args[3])
    elseif argc == 4
        return Expr(:call, gpop.sym, args[1], args[2], args[3], args[4])
    end
    throw("Can not handle expression builder with arguments count $(argc)")
end



function randomPlus(setting::GpSetting; depth::Int=1, maxdepth=3)
    args1 = randomExpr(setting, depth=depth + 1, maxdepth=maxdepth)
    args2 = randomExpr(setting, depth=depth + 1, maxdepth=maxdepth)
    return Expr(:call, :+, args1, args2)
end

