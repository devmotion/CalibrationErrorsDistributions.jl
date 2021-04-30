@testset "optimaltransport.jl" begin
    M = 200
    N = 250
    μ = rand(M)
    ν = rand(N)
    μ ./= sum(μ)
    ν ./= sum(ν)

    # create random cost matrix
    C = pairwise(SqEuclidean(), rand(1, M), rand(1, N); dims=2)

    # compute optimal transport map and cost with OptimalTransport.jl
    P_ot = emd(μ, ν, C, Tulip.Optimizer())
    cost_ot = emd2(μ, ν, C, Tulip.Optimizer())

    # compute optimal transport map and squared Wasserstein distance
    lp = Tulip.Optimizer()
    P = optimal_transport_map(μ, ν, C, lp)
    @test size(C) == size(P)
    @test MOI.get(lp, MOI.TerminationStatus()) == MOI.OPTIMAL
    @test maximum(abs, P .- P_ot) < 1e-2

    lp = Tulip.Optimizer()
    cost = sqwasserstein(μ, ν, C, lp)
    @test dot(C, P) ≈ cost atol = 1e-5
    @test MOI.get(lp, MOI.TerminationStatus()) == MOI.OPTIMAL
    @test cost ≈ cost_ot atol = 1e-5
end