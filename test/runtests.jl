using DeepLib, Test
using Random


@testset "DeepLib.jl" begin
    # fake data
    X = Float32.(randn(4,100))
    Y = X[2,:].^2 - 3.0*X[3,:].^3
    # simple model
    model(x) = vec(sum(x,dims=1))
    objfunc(x) = sum(abs2, model(x) .- Y)
    res = importance(objfunc,X)
    @test length(res) == 4
end
