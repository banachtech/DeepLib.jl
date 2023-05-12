"""
    importance(model,lossfn,features; iters=10,seed=1234,target=nothing)

Compute feature importance using mean changes in objective. 

# Arguments
- `features::Matrix{Float32}`: matrix of features; columns are feature vectors.
- `model::Flux.Chain`: Flux model
- `lossfn::Function` is a scalar real-valued function with signature `lossfn(model,features; target=nothing)`
- `iters::Integer`: number of samples used to calculate mean objective.
- `target` is of the dimension `model(features)` and defaults to `nothing`.

Returns a vector of mean changes in objective.
"""
function importance(model,lossfn,features; iters=10,seed=1234,target=nothing)
    RNG = MersenneTwister(seed)
    m,n = size(features)
    δ = zeros(m)
    yref = lossfn(model,features,target=target)
    x = copy(features)
    for i in 1:m
        for _ in 1:iters
            x[i,:] .= features[i,randperm(RNG, n)]
            loss = lossfn(model,x,target=target)
            δ[i] +=  (loss - yref)
        end
        x[i,:] .= features[i,:]
    end
    δ ./= iters
    return δ
end