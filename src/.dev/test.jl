using Test
using Random

include("playground.jl")

@testset "Find Gp Operators" begin
    op = findGpOperator(:+)
    argc = getGpArgsCount(op)
    @test argc == 2

    op = findGpOperator(:negate)
    argc = getGpArgsCount(op)
    @test argc == 1

    op = findGpOperator(negate)
    @test op.f(-5) == 5
end

@testset "Get Gp Function" begin
    f = getGpFunction(:negate)
    result = f(10)
    @test result == -10

    g = getGpFunction(:+)
    e = Expr(:call, g, 5, 20)
    result = eval(e)
    @test result == 25
end

@testset "Random plus operator" begin
    pool = [1 ,2, 3, :x, :y]
    setting = GpSetting(gpOperators, pool)
    expr::Expr = randomPlus(setting, maxdepth=2)
    @test expr.head == :call
    @test expr.args[1] == :+
    @test expr.args[2] in pool
    @test expr.args[3] in pool

    x = 5
    y = 6
    @test isa(eval(expr), Number)
end

