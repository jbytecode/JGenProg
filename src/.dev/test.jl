using Test
using Random

include("playground.jl")

@testset "Single Plus" begin
    codelist = [2, 2, PlusFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 4
end

@testset "Single Minus" begin
    codelist = [3, 2, MinusFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 1
end

@testset "Single Product" begin
    codelist = [3, 2, ProductFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 6
end

@testset "Single Division" begin
    codelist = [10, 2, DivideFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 5
end

@testset "Single Power" begin
    codelist = [10, 2, PowerFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 100
end

@testset "+ - * / Power Compound" begin
    #  (10 * ((4 + 5) - 2)^2) / 2
    codelist = [4, 5, PlusFunction, 2, MinusFunction, 2, PowerFunction, 10, ProductFunction, 2, DivideFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 245
end


@testset "Negate" begin
    codelist = [10, NegateFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == -10
end

@testset "Exp" begin
    codelist = [5, ExpFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == exp(5)
end


@testset "Basic eval with symbols" begin
    codelist = [:x, :y, PlusFunction]
    stack = createstack()
    dict = Dict(:x => 5, :y => 15)
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 20

    codelist = [:x, :y, MinusFunction, NegateFunction, 3, ProductFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 30
end

@testset "And function" begin
    codelist = [5, 6, AndFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 1

    codelist = [5, 0, AndFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 0

    codelist = [0, 0, AndFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 0

    codelist = [1, 1, AndFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 1

end

@testset "Or function" begin
    codelist = [1, 0, OrFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 1

    codelist = [0, 0, OrFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 0

    codelist = [1, 1, OrFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 1
end


@testset "Xor function" begin
    codelist = [1, 0, XorFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 1

    codelist = [0, 1, XorFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 1

    codelist = [0, 0, XorFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 0

    codelist = [1, 1, XorFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 0
end


@testset "Not function" begin
    codelist = [1, NotFunction]
    stack = createstack()
    dict = Dict()
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 0

    codelist = [0, NotFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 1

    codelist = [5, NotFunction]
    interprete(codelist, stack, dict)
    value = pop!(stack)
    @test value == 0
end


@testset "Create Random Binary Expression" begin
    exprlist = [AndFunction, OrFunction, NotFunction, XorFunction]
    numpool = [0, 1]
    varpool = Dict(:x => 1, :y => 1)
    for i in 1:1000
        e = randomExpression(exprlist, numpool, varpool, maxdepth=1000)
        stack = createstack()
        interprete(e, stack, varpool)
        
        # Stack must include a single result
        @test length(stack) == 1
    
        # Binary operators should produce binary output
        value = pop!(stack)
        @test value in [true, false]
    end
end


@testset "Create Random Arithmetic Expression" begin
    exprlist = [PlusFunction, MinusFunction, ProductFunction, DivideFunction]
    numpool = collect(1:20)
    varpool = Dict(:x => 1, :y => 2)
    for i in 1:1000
        e = randomExpression(exprlist, numpool, varpool, maxdepth=1000)
        stack = createstack()
        interprete(e, stack, varpool)

        # Stack mut include a single result
        @test length(stack) == 1    

        #  Arithmetic operators should produce a number
        value = pop!(stack)
        @test isa(value, Number)
    end
end



@testset "Get Args Count" begin
    @test getArgsCount(NegateFunction) == 1
    @test getArgsCount(OrFunction) == 2
end