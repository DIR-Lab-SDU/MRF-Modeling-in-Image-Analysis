function ising(i, i′, fᵢ, fᵢ′, β)
    # V₂ = βᵢᵢ′fᵢfᵢ′
    i[1] == i′[1] && return V₂ = β[1] * fᵢ * fᵢ′    # clique:   o -
                                                    #       (x,y) (x,y±1)
    i[2] == i′[2] && return V₂ = β[2] * fᵢ * fᵢ′    # clique:    |    (x±1, y)
                                                    #            o    (x±1, y)
end
