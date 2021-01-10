using DataStructures

include("../src/types.jl")
include("../src/interpreter.jl")


# Trying
codelist = [
    2,
    2,
    PlusFunction,
    1,
    MinusFunction
]

stack = createstack()

interprete(codelist, stack)

println(stack)