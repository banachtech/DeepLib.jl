using DeepLib
using Test


@testset "DeepLib.jl" begin
    @test foo(0.0) < 1e-16
end
