using Distributions

# synonyms
Σ = sum

# Sampling Algorithm 2
# Figure 3.8: Generating a texture using a Gibbs sampler.
"""
gibbs!(L, F, Model, β)
* L : label set
* F : labeling | configuration | image
* Model : ising | autologic | MLL
* β : interaction parameters
"""
function gibbs!(L::Vector, F::Matrix, Model::Function, β::Vector, α=0)
    # S = {(i,j) | 1 ≤ i,j ≤ n} correspond to the pixels of an n×n image in the 2D plane
    S = CartesianRange(size(F))
    S₁, Sn = first(S), last(S)
    # (2) for i ∈ S do
    for i ∈ S
        # 8-neighborhood system N & corresponding cliques
        #   ╲ | ╱            |    ╲      ╱
        #   - o -  =>  o -   o     o    o
        #   ╱ | ╲      β1   β2    β3   β4   <= interaction parameters
        N = CartesianRange(max(S₁, i-S₁), min(Sn, i+S₁))
        U = Float64[]
        # (2.1) compute pl = P{fᵢ = l | fNᵢ} for all l ∈ L
        for l ∈ L
            ΣV₂ = 0
            for i′ ∈ N
                if i′ != i    # exclude o o, so N => Nᵢ
                    ΣV₂ += Model(i, i′, l, F[i′], β)
                end
            end
            # U(fᵢ) = V₁(fᵢ) + Σ V₂(fᵢ)
            #       =  αfᵢ   + Σ βᵢᵢ′fᵢfᵢ′
            # when fᵢ = l (see (2.1) above):
            Ul = α*l + ΣV₂
            push!(U, Ul)
        end
        # P(fᵢ|fn) = e^U(fᵢ) / Σᵢe^U(i)
        # where P is conditional probability
        #       U is energy function
        P = e.^U / Σ(e.^U)
        # sample from multinomial distribution
        Pl = rand(Multinomial(1, P), 1)
        # (2.2) set fᵢ to l with probability Pl
        F[i] = L[findfirst(Pl)]
    end
end
