# SKCE

# predicted normal distributions with squared exponential kernel for the targets
function CalibrationErrors.unsafe_skce_eval_targets(
    kernel::SqExponentialKernel,
    p::Normal,
    y::Real,
    p̃::Normal,
    ỹ::Real
)
    # extract parameters
    μ = p.μ
    σ = p.σ
    μ̃ = p̃.μ
    σ̃ = p̃.σ

    # compute scaling factors
    α = inv(hypot(1, σ))
    β = inv(hypot(1, σ̃))
    γ = inv(hypot(1, σ, σ̃))

    return kernel(y, ỹ) - α * kernel(α * μ, α * ỹ) - β * kernel(β * y, β * μ̃) + γ * kernel(γ * μ, γ * μ̃)
end

# UCME

function CalibrationErrors.unsafe_ucme_eval_targets(
    kernel::SqExponentialKernel,
    p::Normal,
    y::Real,
    ::Normal,
    testy::Real
)
    # compute scaling factor
    α = inv(hypot(1, p.σ))

    return kernel(y, testy) - α * kernel(α * p.μ, α * testy)
end

# kernels with input transformations
# TODO: scale upfront?

function CalibrationErrors.unsafe_skce_eval_targets(
    kernel::TransformedKernel{SqExponentialKernel,<:Union{ScaleTransform,ARDTransform}},
    p::Normal,
    y::Real,
    p̃::Normal,
    ỹ::Real
)
    # obtain the transform
    t = kernel.transform

    return CalibrationErrors.unsafe_skce_eval_targets(
        SqExponentialKernel(), apply(t, p), t(y), apply(t, p̃), t(ỹ),
    )
end

function CalibrationErrors.unsafe_ucme_eval_targets(
    kernel::TransformedKernel{SqExponentialKernel,<:Union{ScaleTransform,ARDTransform}},
    p::Normal,
    y::Real,
    testp::Normal,
    testy::Real
)
    # obtain the transform
    t = kernel.transform

    # `testp` is irrelevant for the evaluation and therefore not transformed
    return CalibrationErrors.unsafe_ucme_eval_targets(
        SqExponentialKernel(), apply(t, p), t(y), testp, t(testy),
    )
end

# utilities

# internal `apply` avoids type piracy of transforms
apply(t::Union{ScaleTransform,ARDTransform}, d::Normal) = Normal(t(d.μ), t(d.σ))
