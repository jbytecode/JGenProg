using DataStructures

include("../types.jl")
include("../interpreter.jl")
include("../random.jl")

# Trying
exprlist = [AndFunction, OrFunction, NegateFunction]
numpool = [0, 1]
varpool = Dict(:x => 1, :y => 1)
e = randomExpression(exprlist, numpool, varpool)
println(e)