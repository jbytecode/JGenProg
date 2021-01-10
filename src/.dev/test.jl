using Test

include("playground.jl")

@testset "Single Plus" begin
    codelist = [2, 2, PlusFunction]
    stack = createstack()
    interprete(codelist, stack)
    value = pop!(stack)
    @test value == 4
end

@testset "Single Minus" begin
    codelist = [3, 2, MinusFunction]
    stack = createstack()
    interprete(codelist, stack)
    value = pop!(stack)
    @test value == 1
end

@testset "Single Product" begin
    codelist = [3, 2, ProductFunction]
    stack = createstack()
    interprete(codelist, stack)
    value = pop!(stack)
    @test value == 6
end

@testset "Single Division" begin
    codelist = [10, 2, DivideFunction]
    stack = createstack()
    interprete(codelist, stack)
    value = pop!(stack)
    @test value == 5
end

@testset "Single Power" begin
    codelist = [10, 2, PowerFunction]
    stack = createstack()
    interprete(codelist, stack)
    value = pop!(stack)
    @test value == 100
end

@testset "+ - * / Power Compound" begin
    #  (10 * ((4 + 5) - 2)^2) / 2
    codelist = [4, 5, PlusFunction, 2, MinusFunction, 2, PowerFunction, 10, ProductFunction, 2, DivideFunction]
    stack = createstack()
    interprete(codelist, stack)
    value = pop!(stack)
    @test value == 245
end


@testset "Negate" begin
    codelist = [10, NegateFunction]
    stack = createstack()
    interprete(codelist, stack)
    value = pop!(stack)
    @test value == -10
end