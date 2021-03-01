using CalibrationErrorsDistributions

using Test

@testset "normal.jl" begin
    @testset "SKCE: basic example" begin
        skce = UnbiasedSKCE(WassersteinExponentialKernel() ⊗ SqExponentialKernel())

        # only two predictions, i.e., one term in the estimator
        normal1 = Normal(0, 1)
        normal2 = Normal(1, 2)
        @test @inferred(calibrationerror(skce, ([normal1, normal1], [0, 0]))) ≈
            1 - sqrt(2) + 1 / sqrt(3)
        @test @inferred(calibrationerror(skce, ([normal1, normal2], [1, 0]))) ≈
            exp(-sqrt(2)) * (exp(-1/2) - 1 / sqrt(2) - 1 / sqrt(5) + exp(-1/12) / sqrt(6))
        @test @inferred(calibrationerror(skce, ([normal1, normal2], [0, 1]))) ≈
            exp(-sqrt(2)) * (exp(-1/2) - exp(-1/4) / sqrt(2) - exp(-1/10) / sqrt(5) + exp(-1/12) / sqrt(6))
    end

    @testset "SKCE: basic example (transformed)" begin
        skce = UnbiasedSKCE(WassersteinExponentialKernel() ⊗ transform(SqExponentialKernel(), 0.5))

        # only two predictions, i.e., one term in the estimator
        normal1 = Normal(0, 1)
        normal2 = Normal(1, 2)
        @test @inferred(calibrationerror(skce, ([normal1, normal1], [0, 0]))) ≈
            1 - 2 / sqrt(1.25) + 1 / sqrt(1.5)
        @test @inferred(calibrationerror(skce, ([normal1, normal2], [1, 0]))) ≈
            exp(-sqrt(2)) * (exp(-1/8) - 1 / sqrt(1.25) - 1 / sqrt(2) + exp(-1/18) / sqrt(2.25))
        @test @inferred(calibrationerror(skce, ([normal1, normal2], [0, 1]))) ≈
            exp(-sqrt(2)) * (exp(-1/8) - exp(-1/10) / sqrt(1.25) - exp(-1/16) / sqrt(2) + exp(-1/18) / sqrt(2.25))
    end

    @testset "SKCE: basic properties" begin
        skce = UnbiasedSKCE(WassersteinExponentialKernel() ⊗ SqExponentialKernel())

        estimates = Vector{Float64}(undef, 10_000)
        for i in 1:length(estimates)
            predictions = map(Normal, randn(20), rand(20))
            targets = map(rand, predictions)
            estimates[i] = calibrationerror(skce, predictions, targets)
        end
        
        @test any(x -> x > zero(x), estimates)
        @test any(x -> x < zero(x), estimates)
        @test mean(estimates) ≈ 0 atol=1e-4
    end

    @testset "UCME: basic example" begin
        # one test location
        ucme = UCME(
            WassersteinExponentialKernel() ⊗ SqExponentialKernel(),
            [Normal(0.5, 0.5)], [1]
        )

        # two predictions
        normal1 = Normal(0, 1)
        normal2 = Normal(1, 2)
        @test @inferred(calibrationerror(ucme, ([normal1, normal2], [0, 0.5]))) ≈
            (exp(-1/sqrt(2)) * (exp(-1/2) - exp(-1/4) / sqrt(2)) +
             exp(- sqrt(5 / 2)) * (exp(-1/8) - 1 / sqrt(5)))^2 / 4

        # two test locations
        ucme = UCME(
            WassersteinExponentialKernel() ⊗ SqExponentialKernel(),
            [Normal(0.5, 0.5), Normal(-1, 1.5)], [1, -0.5]
        )
        @test @inferred(calibrationerror(ucme, ([normal1, normal2], [0, 0.5]))) ≈
            (
                (exp(-1/sqrt(2)) * (exp(-1/2) - exp(-1/4) / sqrt(2)) +
                 exp(- sqrt(5 / 2)) * (exp(-1/8) - 1 / sqrt(5)))^2  +
                 (exp(-sqrt(5) / 2) * (exp(-1/8) - exp(- 1/16) / sqrt(2)) +
                  exp(-sqrt(17) / 2) * (exp(-1/2) - exp(- 9 / 40) / sqrt(5)))^2
            ) / 8
    end

    @testset "kernels with input transformations" begin
        nsamples = 100
        ntestsamples = 5

        # create predictions and targets
        predictions = map(Normal, randn(nsamples), rand(nsamples))
        targets = randn(nsamples)

        # create random test locations
        testpredictions = map(Normal, randn(ntestsamples), rand(ntestsamples))
        testtargets = randn(ntestsamples)

        for γ in (1.0, rand())
            kernel1 = WassersteinExponentialKernel() ⊗ transform(SqExponentialKernel(), γ)
            kernel2 = WassersteinExponentialKernel() ⊗ transform(SqExponentialKernel(), [γ])

            # check evaluation of the first two observations
            p1 = predictions[1]
            p2 = predictions[2]
            t1 = targets[1]
            t2 = targets[2]
            for f in (
                CalibrationErrors.unsafe_skce_eval_targets, CalibrationErrors.unsafe_ucme_eval_targets
            )
                out1 = f(kernel1.kernels[2], p1, t1, p2, t2)
                out2 = f(kernel2.kernels[2], p1, t1, p2, t2)
                @test out2 ≈ out1
                if isone(γ)
                    @test f(SqExponentialKernel(), p1, t1, p2, t2) ≈ out1
                end
            end

            # check estimates
            for estimator in (
                UnbiasedSKCE, x -> UCME(x, testpredictions, testtargets)
            )
                estimate1 = calibrationerror(estimator(kernel1), predictions, targets)
                estimate2 = calibrationerror(estimator(kernel2), predictions, targets)
                @test estimate2 ≈ estimate1
                if isone(γ)
                    @test calibrationerror(estimator(
                        WassersteinExponentialKernel() ⊗ SqExponentialKernel()
                    ), predictions, targets) ≈ estimate1
                end
            end
        end
    end
end
