using CalibrationErrorsDistributions
using Distances
using LinearAlgebra
using MathOptInterface
using OptimalTransport
using PDMats
using Random
using Test

using CalibrationErrorsDistributions:
    Wasserstein,
    SqWasserstein,
    MixtureWasserstein,
    SqMixtureWasserstein,
    sqwasserstein,
    optimal_transport_map
using Tulip: Tulip

Random.seed!(1234)

const MOI = MathOptInterface

@testset "CalibrationErrorsDistributions" begin
    @testset "optimal transport" begin
        include("optimaltransport.jl")
    end

    @testset "distances" begin
        @testset "Bures metric" begin
            include("distances/bures.jl")
        end
        @testset "Wasserstein distance" begin
            include("distances/wasserstein.jl")
        end
    end

    @testset "kernels" begin
        include("kernels.jl")
    end

    @testset "Normal" begin
        include("normal.jl")
    end
    @testset "MvNormal" begin
        include("mvnormal.jl")
    end
end
