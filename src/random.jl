function randomExpression(exprpool::Array, numpool::Array, varpool::Dict; depth::Int=1, maxdepth=3)
    #  select the lucky operation
    luckyExpr = rand(exprpool, 1)[1]
    
    #  number of arguments that the lucky operaiton takes
    argsc = getArgsCount(luckyExpr)
    
    #  postfix Array
    postfixarr = []

    for i in 1:argsc
        myrand = rand()
        if myrand < 0.35
            push!(postfixarr, rand(numpool, 1)[1])
        elseif myrand < 0.70
            randomPairValue = rand(varpool, 1)[1]
            key, val = randomPairValue
            push!(postfixarr, key)
        else 
            if depth <= maxdepth
                randexp = randomExpression(exprpool, numpool, varpool, depth=depth + 1, maxdepth=maxdepth)
                for element in randexp
                    push!(postfixarr, element)
                end
            else
                push!(postfixarr, rand(numpool, 1)[1])
            end
        end
    end

    push!(postfixarr, luckyExpr)

    return postfixarr
end