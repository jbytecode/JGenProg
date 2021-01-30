using DataStructures

include("../stdlib.jl")
include("../types.jl")
include("../random.jl")
include("../gp.jl")

# Trying
myops = [
    GpOperator(:+, 2, +),
    GpOperator(:GpIf, 3, GpIf),
    GpOperator(:GpSqrt, 1, GpSqrt)
]
setting = GpSetting(myops, [:x, :y])

p1 = Program(randomExpr(setting, maxdepth=3), 0.0)
p2 = Program(randomExpr(setting, maxdepth=3), 0.0)


