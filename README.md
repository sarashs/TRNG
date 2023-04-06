# True Random Number Generator (TRNG)

This repository contains the design and implementation of a True Random Number Generator (TRNG) using single-stage ring oscillators (ROs) on an Avnet Ultra96-V2 development board. The implementation consists of 32 ROs sampled by D flip-flop primitives and utilizes a simple hash for bit mixing and uniformization.
## Requirements
- Avnet Ultra96-V2 development board
- PYNQ v3.1
- Vivado Design Suite version 2022.1

## Hardware design

### Pre-design assessments:

For random number generation on a Zync Ultrascale+ device, I decided to utilize the jitter noise present in ring oscillators (ROs). To investigate the nature of this jitter noise, I utilized simple counters to count the number of rising edges of the ROs over various spans of time, measured using the MPSoC clock. Through this process, I observed that the time series of the counts over five different randomly placed ROs were not correlated with each other for short durations, but highly correlated for longer durations.

This suggests the existence of significant zero-mean jitter noise (or some other zero-mean phenomenon that leads to the fluctuation of the counts). To illustrate this correlation behavior, I have included a figure depicting correlations for various time durations. The following figure depicts the correlations for various time durations,

![Alt text](https://github.com/sarashs/TRNG/blob/main/Images/ro_correlations.png)
 

### The design:

My design is simple, featuring a single-stage ring oscillator (RO) connected to a D flip-flop and clocked by it. While some academic papers may underestimate the value of such simple designs, my own assessments and final outcomes have demonstrated that this approach produces high-quality random numbers. However, I did need to address the issue of an appropriate balance between 0s and 1s, which I achieved by incorporating a simple hash function into the Verilog code.

To optimize power usage, I decided to use a NAND gate with a control signal that comes from the Axi Lite interface to turn the ROs on and off. Additionally, I utilized the Xilinx Axi Lite IP interface with two registers - one for the control signal and the other for the generated random number.

My design balances simplicity, power efficiency, and high-quality random number generation. It is a well-thought-out solution that meets the needs of my project.

![Alt text](https://github.com/sarashs/TRNG/blob/main/Images/Design.png)

The block diagram of the system coupled with the MPSoC is as follows, where the TRNG_Axi_lite_0 is the IP depicted above.

![Alt text](https://github.com/sarashs/TRNG/blob/main/Images/block_diagram.jpg)

## Building the TRNG

There are two options for building the TRNG:
1. Easy Method (pre-built bitstream): The .bit and .hwh files are provided in the PYNQ folder along with a simple jupyter notebook to generate random numbers and save them. PYNQ v3.1 is required to run the PYNQ version
2. Developer Method (customize and build from source):
Take the following steps,

	1. Clone the GitHub repository containing the project files, including the Tcl script for the block design, the IP repository, and the constraints file.
	2. Create a new Vivado project and select the appropriate settings, such as the target device and/or board (Ultra96-V2).
	3. Open Vivado Tcl Console: In Vivado, go to Window > Tcl Console to open the Tcl Console.
	4. Set IP repository path: In the Tcl Console, set the IP repository path to the ip_repo folder. Replace <path_to_ip_repo> with the actual path to the ip_repo folder:
		```tcl
		set_property ip_repo_paths <path_to_ip_repo> [current_project]
		```
	5. Source the block design Tcl script:
		```tcl
		source <path_to_Vivado_project>/Vivado_project/TRNG.tcl
		```
	This command will create the block design based on the Tcl script.
	6. Add the constraint files: Import the constraint files into the project. In the Tcl Console, use the add_files command to add the constraint files to the project. Replace <path_to_constraints_folder> with the actual path to the folder containing the constraint file:
		```tcl
		add_files -fileset constrs_1 <path_to_Vivado_project>/Vivado_project/loop.xdc
		```
	7. Generate the bitstream: In the Flow Navigator, click on "Generate Bitstream" to generate the bitstream for the design.

	Note: The data folder includes some sample data for statistical analysis.

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


*Note: Random Excursions Test and Random Excursions Variant Test results have been omitted from the table for brevity but our TRNG passes those as well.
