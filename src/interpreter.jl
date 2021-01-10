function createstack()
    return Stack{Union{Symbol,Number,GpFunction}}()
end


function interprete(codelist, stack)
    for element in codelist
        if element isa Number || element isa Symbol
            push!(stack, element)
        elseif element <: GpFunction
            eval!(element, stack)
        end
    end
end

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