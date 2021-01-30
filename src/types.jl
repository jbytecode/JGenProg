struct GpOperator
    sym::Symbol
    argc::Int64
    f::Function
end

struct GpSetting
    operatorpool::Array{GpOperator,1}
    numpool::Array{Union{Number,Symbol},1}
end

const gpOperators = [ 
   GpOperator(:+, 2, +),
   GpOperator(:-, 2, -),
   GpOperator(:*, 2, *),
   GpOperator(:/, 2, /),
   GpOperator(:GpPow, 2, GpPow),
   GpOperator(:GpSqrt, 1, GpSqrt),
   GpOperator(:GpLn, 1, GpLn),
   GpOperator(:GpNeg, 1, GpNeg),
   GpOperator(:GpOr, 2, GpOr),
   GpOperator(:GpAnd, 2, GpAnd),
   GpOperator(:GpEq, 2, GpEq),
   GpOperator(:GpIf, 3, GpIf)
]

function findGpOperator(s::Symbol)::GpOperator
    for op in gpOperators
        if op.sym == s 
            return op
        end
    end
    throw("Operator not found for symbol $s.")
end 

function findGpOperator(f::Function)::GpOperator
    for op in gpOperators
        if op.f == f 
            return op
        end
    end
    throw("Operator not found for function $f.")
end


getGpArgsCount(op::GpOperator) = op.argc
getGpArgsCount(sym::Symbol) = findGpOperator(sym).argc

getGpFunction(op::GpOperator) = op.f
getGpFunction(sym::Symbol) = findGpOperator(sym).f

getGpSymbol(op::GpOperator) = op.sym



Base.length(e::Expr) = length(e.args)
Base.length(::Symbol) = 1


function depth(e::Expr; current=1)::Int64 
    exprs = filter(x -> typeof(x) == Expr, e.args)
    t = current
    for element in exprs
        t = depth(element, current=current + 1)
    end
    return t
end

