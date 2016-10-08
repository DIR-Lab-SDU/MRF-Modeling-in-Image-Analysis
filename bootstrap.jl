dir = dirname(@__FILE__)

# 2-Mathematical MRF Models
include(joinpath(dir, "2-Mathematical MRF Models", "IsingModel.jl"))
include(joinpath(dir, "2-Mathematical MRF Models", "AutologicModel.jl"))
include(joinpath(dir, "2-Mathematical MRF Models", "MLL.jl"))

# 3-4-Texture Synthesis and Analysis
include(joinpath(dir, "3-4-Texture Synthesis and Analysis", "Gibbs-julia", "Gibbs.jl"))
