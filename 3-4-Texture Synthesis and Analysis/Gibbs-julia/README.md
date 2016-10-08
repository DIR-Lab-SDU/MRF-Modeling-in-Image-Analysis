```julia
# in playground.jl
using Images

# label set L
labels = [0, 1]

# interaction parameters
beta = [1, -1, -1, -1]

# labeling F
img = grayim(rand(100,100))

# MCMC
for i = 1:10
    gibbs!(labels, img.data, beta)
end

img
```