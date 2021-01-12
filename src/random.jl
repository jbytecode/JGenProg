function randomExpression(exprpool::Array, numpool::Array, varpool::Dict)
    #  select the lucky operation
    luckyExpr = rand(exprpool, 1)[1]
    
    #  number of arguments that the lucky operaiton takes
    argsc = getArgsCount(luckyExpr)
    
    #  postfix Array
    postfixarr = []

    for i in 1:argsc
        if rand() < 0.5
            push!(postfixarr, rand(numpool, 1)[1])
        else
            randomPairValue = rand(varpool, 1)[1]
            key, val = randomPairValue
            push!(postfixarr, key)
        end
    end

    push!(postfixarr, luckyExpr)

    return postfixarr
end