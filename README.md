# True Random Number Generator (TRNG)

This repository contains the design and implementation of a True Random Number Generator (TRNG) using single-stage ring oscillators (ROs) on an Avnet Ultra96-V2 development board. The implementation consists of 32 ROs sampled by D flip-flop primitives and utilizes 16-stage Feistel networks for bit mixing and uniformization.
## Requirements
- Avnet Ultra96-V2 development board
- PYNQ v3.1
- Vivado Design Suite version 2022.1

## Building the TRNG

There are two options for building the TRNG:
1. Easy Method (pre-built bitstream)
2. Developer Method (customize and build from source)

(We will provide the detailed steps for these methods later.)
## Statistical Test Results

The TRNG has been tested using a variety of statistical tests. The results are presented in the following table:

| Type of Test                                  | P-Value              | Conclusion |
|-----------------------------------------------|----------------------|------------|
| Frequency Test (Monobit)                      | 0.16091524669521418  | Random     |
| Frequency Test within a Block                 | 0.35889430766856123  | Random     |
| Run Test                                      | 0.06316361136273455  | Random     |
| Longest Run of Ones in a Block                | 0.738966186955665    | Random     |
| Binary Matrix Rank Test                       | 0.7294109059369386   | Random     |
| Discrete Fourier Transform (Spectral) Test    | 0.424657690430292    | Random     |
| Non-Overlapping Template Matching Test        | 0.9000085988835507   | Random     |
| Overlapping Template Matching Test            | 0.019011763079515326 | Random     |
| Maurer's Universal Statistical test           | 0.9346024276397722   | Random     |
| Linear Complexity Test                        | 0.5692257862725456   | Random     |
| Serial test                                   | 0.07619527040105199  | Random     |
|                                               | 0.049819218851078734 | Random     |
| Approximate Entropy Test                      | 0.06604546100543333  | Random     |
| Cummulative Sums (Forward) Test               | 0.23329085025395324  | Random     |
| Cummulative Sums (Reverse) Test               | 0.2187507121731081   | Random     |


*Note: Random Excursions Test and Random Excursions Variant Test results have been omitted from the table for brevity.
