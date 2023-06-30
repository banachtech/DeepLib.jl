"""
    importance(objfunc, features; iters=10, seed=1234)

Compute feature importance using mean changes in objective. 

# Arguments
- `features::Matrix{Float32}`: matrix of features; columns are feature vectors.
- `objfunc::Function` is a scalar real-valued function with signature `objfunc(features)`
- `iters::Integer`: number of samples used to calculate mean objective.

Returns a vector of mean changes in objective as defined by objfunc.
"""
function importance(objfunc, features; iters=10,seed=1234)
    RNG = MersenneTwister(seed)
    m,n = size(features)
    δ = zeros(m)
    baseline = objfunc(features)
    x = copy(features)
    for i in 1:m
        for _ in 1:iters
            x[i,:] .= features[i,randperm(RNG, n)]
            δ[i] +=  (objfunc(x)-baseline)
        end
        x[i,:] .= features[i,:]
    end
    δ ./= iters
    return δ
end
