using CovarianceMatrices, GLM

function newey_west(r)
    d = DataFrame(:x => r)
    ols = lm(@formula(x ~ 1), d)
    se = only(stderror(ols, QuadraticSpectralKernel(NeweyWest)))
    μ = only(coef(ols))
    t = μ/se
    return (mean=μ, serr=se, tstat=t)
end

function winsorize(y::Array{Float64}, p)
x = deepcopy(y)
q = quantile(x, [p, 1-p])
x[x .> q[2]] .= q[2]
x[x .< q[1]] .= q[1]
return x
end

function truncate(x::Array{Float64}, p)
z = convert(Array{Union{Missing, Float64}}, x)
q = quantile(x, [p, 1-p])
z[(z .> q[2])] .= missing
z[isless.(z, q[1])] .= missing
return z
end