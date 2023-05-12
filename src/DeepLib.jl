module DeepLib

using Expectations, Distributions

function foo(μ=1., σ=2.)
    println("check mod")
    d = Normal(μ, σ)
    E = expectation(d)
    return E(x -> sin(x))
end

export foo

end
