# CalibrationErrorsDistributions.jl

Estimation of calibration errors for models that output probability distributions from
[Distributions.jl](https://github.com/JuliaStats/Distributions.jl).

[![Build Status](https://github.com/devmotion/CalibrationErrorsDistributions.jl/workflows/CI/badge.svg?branch=main)](https://github.com/devmotion/CalibrationErrorsDistributions.jl/actions?query=workflow%3ACI+branch%3Amain)
[![DOI](https://zenodo.org/badge/274106426.svg)](https://zenodo.org/badge/latestdoi/274106426)
[![Coverage](https://codecov.io/gh/devmotion/CalibrationErrorsDistributions.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/devmotion/CalibrationErrorsDistributions.jl)
[![Coverage](https://coveralls.io/repos/github/devmotion/CalibrationErrorsDistributions.jl/badge.svg?branch=main)](https://coveralls.io/github/devmotion/CalibrationErrorsDistributions.jl?branch=main)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![Bors enabled](https://bors.tech/images/badge_small.svg)](https://app.bors.tech/repositories/24611)

**There are also [Python](https://github.com/devmotion/pycalibration) and [R](https://github.com/devmotion/rcalibration) interfaces for this package**

## Related packages

This package extends calibration error estimation for classification models
in the package
[CalibrationErrors.jl](https://github.com/devmotion/CalibrationErrors.jl)
to more general probabilistic predictive models that output arbitrary probability
distributions.

[CalibrationTests.jl](https://github.com/devmotion/CalibrationTests.jl) implements
statistical hypothesis tests of calibration.

[pycalibration](https://github.com/devmotion/pycalibration) is a Python interface for CalibrationErrors.jl, CalibrationErrorsDistributions.jl, and CalibrationTests.jl.

[rcalibration](https://github.com/devmotion/rcalibration) is an R interface for CalibrationErrors.jl, CalibrationErrorsDistributions.jl, and CalibrationTests.jl.

## Reference

If you use CalibrationsErrorsDistributions.jl as part of your research, teaching, or other activities,
please consider citing the following publication:

Widmann, D., Lindsten, F., & Zachariah, D. (2019). [Calibration tests in multi-class
classification: A unifying framework](https://proceedings.neurips.cc/paper/2019/hash/1c336b8080f82bcc2cd2499b4c57261d-Abstract.html). In
*Advances in Neural Information Processing Systems 32 (NeurIPS 2019)* (pp. 12257–12267).

Widmann, D., Lindsten, F., & Zachariah, D. (2021).
[Calibration tests beyond classification](https://openreview.net/forum?id=-bxf89v3Nx).
To be presented at *ICLR 2021*.
