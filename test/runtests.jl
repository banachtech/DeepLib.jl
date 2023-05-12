using DeepLib
using Test


@testset "DeepLib.jl" begin
    # fake data
    X = Float32.(randn(4,100))
    Y = X[2,:].^2 - 3.0*X[3,:].^3
    Y = reshape(Y,1,:)
    # define a simple MLP
    model = Flux.Chain(Dense(4,2,tanh),Dense(2,2,tanh),Dense(2,1))
    # mse loss function
    lossfn(m,x;target=nothing) = Flux.mse(m(x),target)
    res = importance(model,lossfn,X,target=Y)
    @test length(res) == 4
end
