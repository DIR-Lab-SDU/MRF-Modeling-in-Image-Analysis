# Ising Model
```julia
# in Jupyter
using Images

# label set L
labels = [-1, 1]

# interaction parameters
beta = [-1, 1]

# labeling F
labeling = rand([-1,1], 100, 100)
grayImg = (labeling+1)/maximum(labeling+1)  # normalize to 0~255
grayim(grayImg)

# burn-in
for i = 1:10
    metropolis!(labels, labeling, ising, beta)  # or Gibbs!
    IJulia.clear_output(true)
    grayImg = (labeling+1)/maximum(labeling+1)
    display(grayim(grayImg))
end
```

# Autologic Model
```julia
# in Jupyter
using Images

# label set L
labels = [-1, 1]

# interaction parameters
beta = [1, 1, -1, 1]

# labeling F
labeling = rand([-1,1], 100, 100)
grayImg = (labeling+1)/maximum(labeling+1)  # normalize to 0~255
grayim(grayImg)

# burn-in
for i = 1:10
    metropolis!(labels, labeling, autologic, beta)  # or Gibbs!
    IJulia.clear_output(true)
    grayImg = (labeling+1)/maximum(labeling+1)
    display(grayim(grayImg))
end
```

# MLL Model
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
    metropolis!(labels, labeling, MLL, beta)  # or Gibbs!
    IJulia.clear_output(true)
    display(grayim(labeling/maximum(labeling)))
end
```
