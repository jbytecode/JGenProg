using Test
using Random

include("playground.jl")

@testset "Find Gp Operators" begin
    op = findGpOperator(:+)
    argc = getGpArgsCount(op)
    @test argc == 2

    op = findGpOperator(:GpNeg)
    argc = getGpArgsCount(op)
    @test argc == 1

    op = findGpOperator(GpNeg)
    @test op.f(-5) == 5
end

@testset "Get Gp Function" begin
    f = getGpFunction(:GpNeg)
    result = f(10)
    @test result == -10

    g = getGpFunction(:+)
    e = Expr(:call, g, 5, 20)
    result = eval(e)
    @test result == 25
end

@testset "Random expression of deep 1" begin
    pool = [1 ,2, 3, :x, :y]
    myGpOperators = [
        GpOperator(:+, 2, +)
    ]
    setting = GpSetting(myGpOperators, pool)
    expr::Expr = randomExpr(setting, maxdepth=2)

    @test expr.head == :call
    @test expr.args[1] == :+
    @test expr.args[2] in pool
    @test expr.args[3] in pool

    result = @eval function ()
        x = 5
        y = 7
        $expr
    end
    @test isa(result(), Number)
end

