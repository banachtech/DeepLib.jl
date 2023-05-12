using DeepLib, Test
using Random


@testset "DeepLib.jl" begin
    # fake data
    X = Float32.(randn(4,100))
    Y = X[2,:].^2 - 3.0*X[3,:].^3
    # simple model
    model(x) = vec(sum(x,dims=1))
    # mse loss function
    lossfn(m,x;target=nothing) = sum(abs2, m(x) .- target)
    res = importance(model,lossfn,X,target=Y)
    @test length(res) == 4
end
