# synonyms
Σ = sum

# Sampling Algorithm 1
# Figure 3.7: Generating a texture using a Metropolis sampler.
"""
metropolis!(L, F, Model, β)
* L : label set
* F : labeling | configuration | image
* Model : ising | autologic | MLL
* β : interaction parameters
"""
function metropolis!(L::Vector, F::Matrix, Model::Function, β::Vector, α=0)
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
        # (2.1) let F′[i′] = F[i′] for all i′ ≠ i;
        #       choose fᵢ ∈ L at random
        fᵢ = rand(L, 1)[]    # fill the missing slot of F′ with fᵢ => new labeling F′
        # (2.2) let p = min{1, P(f′)/P(f)}
        # calculate Pf & Pf′
        ΣV₂ = 0
        ΣV₂′ = 0
        for i′ ∈ N
            if i′ != i
                ΣV₂ += Model(i, i′, F[i], F[i′], β)
                ΣV₂′ += Model(i, i′, fᵢ, F[i′], β)
            end
        end
        # U(fᵢ) = V₁(fᵢ) + Σ V₂(fᵢ)
        #       =  αfᵢ   + Σ βᵢᵢ′fᵢfᵢ′
        Uf = α*F[i] + ΣV₂
        Uf′ = α*fᵢ + ΣV₂′
        # P(f) = e^-U(f) / Z
        # where P is the given Gibbs distribution
        #       U is energy function
        Pf = e.^-Uf   # / Z
        Pf′ = e.^-Uf′ # / Z
        # calculate p
        p = min(1, Pf/Pf′)
        # (2.3) replace F by F′ with probability p;
        if rand() < p
            # here we only need to change F[i]
            F[i] = fᵢ
        end
    end
end
