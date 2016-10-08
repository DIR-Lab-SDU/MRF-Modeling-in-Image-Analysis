```julia
# in Jupyter
using Images

# label set L
labels = [0, 1, 2]

# interaction parameters
beta = [1, -1, -1, -1]

# labeling F
labeling = rand(100,100)
grayim(labeling)

# burn-in
for i = 1:10                   
    gibbs!(labels, labeling, MLL, beta)
    IJulia.clear_output(true)
    display(grayim(labeling/maximum(labeling)))
end
```
