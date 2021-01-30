mutable struct Program
    expr::Expr
    cost::Float64
end

function Base.:*(p1::Program, p2::Program)
    #  Randomly pick a sub-expression from p1
    #  Randomly pick a sub-expression from p2
    # and exchange. 
end