function createstack()
    return Stack{Number}()
end

function interprete(codelist, stack, dict)
    for element in codelist
        if element isa Number 
            push!(stack, element)
        elseif element isa Symbol
            push!(stack, dict[element])
        elseif element <: GpFunction
            eval!(element, stack)
        end
    end
end #  End of interprete

function eval!(::Type{PlusFunction}, stack)
    p1 = pop!(stack)
    p2 = pop!(stack)
    push!(stack, p1 + p2)
end

function eval!(::Type{MinusFunction}, stack)
    p1 = pop!(stack)
    p2 = pop!(stack)
    push!(stack, p2 - p1)
end

function eval!(::Type{ProductFunction}, stack)
    p1 = pop!(stack)
    p2 = pop!(stack)
    push!(stack, p1 * p2)
end

function eval!(::Type{DivideFunction}, stack)
    p1 = pop!(stack)
    p2 = pop!(stack)
    push!(stack, p2 / p1)
end

function eval!(::Type{PowerFunction}, stack)
    p1 = pop!(stack)
    p2 = pop!(stack)
    push!(stack, p2^p1)
end


function eval!(::Type{NegateFunction}, stack)
    p = pop!(stack)
    push!(stack, -p)
end

function eval!(::Type{ExpFunction}, stack)
    p = pop!(stack)
    push!(stack, exp(p))
end

function eval!(::Type{AndFunction}, stack)
    p1::Bool = !iszero(pop!(stack)) 
    p2::Bool = !iszero(pop!(stack))
    push!(stack, p2 && p1)
end

function eval!(::Type{OrFunction}, stack)
    p1::Bool = !iszero(pop!(stack)) 
    p2::Bool = !iszero(pop!(stack))
    push!(stack, p2 || p1)
end

function eval!(::Type{XorFunction}, stack)
    p1::Bool = !iszero(pop!(stack)) 
    p2::Bool = !iszero(pop!(stack))
    push!(stack, xor(p1, p2))
end


function eval!(::Type{NotFunction}, stack)
    p::Bool = !iszero(pop!(stack))
    push!(stack, !p)
end