module JGenProg

using DataStructures

include("types.jl")
include("interpreter.jl")
include("random.jl")



export GpFunction, GpFunction1p, GpFunction2p, GpFunction3p, GpFunction4p
export interprete, getArgsCount

export NegateFunction, ExpFunction, NotFunction

export PlusFunction, MinusFunction,ProductFunction, DivideFunction
export PowerFunction, AndFunction, OrFunction 

end # module





