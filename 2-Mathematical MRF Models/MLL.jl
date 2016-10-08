function MLL(i, i′, fᵢ, fᵢ′, β)
    #  V₂(f) = {  β  if sites on clique {i,i′} = c ∈ C₂ have the same label
    #          { -β  otherwise
    if i[1] == i′[1]                        # clique:   o -
        V₂ = (fᵢ′ == fᵢ) ? β[1] : -β[1]     #       (x,y) (x,y±1)
    elseif i[2] == i′[2]                    # clique:    |    (x±1, y)
        V₂ = (fᵢ′ == fᵢ) ? β[2] : -β[2]     #            o    (x±1, y)
    elseif prod((i′-i).I) == 1              # clique:   ╲    (x∓1, y∓1)
        V₂ = (fᵢ′ == fᵢ) ? β[3] : -β[3]     #            o   ( x,   y)
    elseif prod((i′-i).I) == -1             # clique:    ╱   (x∓1, y±1)
        V₂ = (fᵢ′ == fᵢ) ? β[4] : -β[4]     #           o    ( x,   y)
    end
end
