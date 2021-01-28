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
   GpOperator(:negate, 1, negate)
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



