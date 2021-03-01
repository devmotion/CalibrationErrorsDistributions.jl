# CalibrationErrorsDistributions.jl

Estimation of calibration errors for models that output probability distributions from
[Distributions.jl](https://github.com/JuliaStats/Distributions.jl).

[![Build Status](https://github.com/devmotion/CalibrationErrorsDistributions.jl/workflows/CI/badge.svg?branch=master)](https://github.com/devmotion/CalibrationErrorsDistributions.jl/actions?query=workflow%3ACI+branch%3Amaster)
[![DOI](https://zenodo.org/badge/274106426.svg)](https://zenodo.org/badge/latestdoi/274106426)
[![Coverage](https://codecov.io/gh/devmotion/CalibrationErrorsDistributions.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/devmotion/CalibrationErrorsDistributions.jl)
[![Coverage](https://coveralls.io/repos/github/devmotion/CalibrationErrorsDistributions.jl/badge.svg?branch=master)](https://coveralls.io/github/devmotion/CalibrationErrorsDistributions.jl?branch=master)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Bors enabled](https://bors.tech/images/badge_small.svg)](https://app.bors.tech/repositories/24611)

## Related packages

This package extends calibration error estimation for classification models
in the package
[CalibrationErrors.jl](https://github.com/devmotion/CalibrationErrors.jl)
to more general probabilistic predictive models that output arbitrary probability
distributions.

[CalibrationTests.jl](https://github.com/devmotion/CalibrationTests.jl) implements
statistical hypothesis tests of calibration.

## Reference

If you use CalibrationsErrorsDistributions.jl as part of your research, teaching, or other activities,
please consider citing the following publication:

Widmann, D., Lindsten, F., & Zachariah, D. (2019).
[Calibration tests beyond classification](https://openreview.net/forum?id=-bxf89v3Nx).
To be presented at *ICLR 2021*.

Widmann, D., Lindsten, F., & Zachariah, D. (2021).
[Calibration tests beyond classification](https://openreview.net/forum?id=-bxf89v3Nx).
To be presented at *ICLR 2021*.
