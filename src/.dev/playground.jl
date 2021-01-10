using DataStructures

include("../types.jl")
include("../interpreter.jl")


# Trying
codelist = [
    2,
    2,
    PlusFunction,
    1,
    MinusFunction
]

stack = createstack()

dict = Dict(:x => 1, :y => 1)

interprete(codelist, stack, dict)

println(stack)