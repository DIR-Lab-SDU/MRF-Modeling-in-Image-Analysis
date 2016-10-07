using Distributions, Images

Σ = sum

# Sampling Algorithm 2
# Figure 3.8: Generating a texture using a Gibbs sampler.
function gibbs!(L::Vector, F::Matrix, β::Vector, α=0)
    # S = {(i,j) | 1 ≤ i,j ≤ n} correspond to the pixels of an n×n image in the 2D plane
    S = CartesianRange(size(F))
    S₁, Sn = first(S), last(S)
    # (2) for i ∈ S do
    for i ∈ S
        # neighbors system N & corresponding cliques
        #   ╲ | ╱       |         ╲      ╱
        #   - o -  =>   o   o -    o    o
        #   ╱ | ╲       β1   β2   β3   β4   <= interaction parameters
        N = CartesianRange(max(S₁, i-S₁), min(Sn, i+S₁))
        U = Float64[]
        # (2.1) compute pl = P{fᵢ = l | fNᵢ} for all l ∈ L
        for l ∈ L
            ΣV₂ = 0
            for i′ ∈ N
                if i′ != i    # exclude o o
                    #  V₂(f) = {  β  if sites on clique {i,i′} = c ∈ C₂ have the same label
                    #          { -β  otherwise
                    if i[1] == i′[1]                          # clique:   o -
                        ΣV₂ += (F[i′] == l) ? β[1] : -β[1]    #       (x,y) (x,y±1)
                    end
                    if i[2] == i′[2]                          # clique:    |    (x±1, y)
                        ΣV₂ += (F[i′] == l) ? β[2] : -β[2]    #            o    (x±1, y)
                    end
                    if prod((i′-i).I) == 1                    # clique:   ╲    (x∓1, y∓1)
                        ΣV₂ += (F[i′] == l) ? β[3] : -β[3]    #            o   ( x,   y)
                    end
                    if prod((i′-i).I) == -1                   # clique:    ╱   (x∓1, y±1)
                        ΣV₂ += (F[i′] == l) ? β[4] : -β[4]    #           o    ( x,   y)
                    end
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


# label set L (Ising model)
labels = [0, 1]

# interaction parameters
beta = [1, -1, -1, -1]

# labeling F
img = grayim(rand(100,100))

for i = 1:10
    gibbs!(labels, img.data, beta)
end

img
