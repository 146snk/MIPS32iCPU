# MIPS32iCPU
An RTL implementation of MIPS 32i CPU processor in Verilog
![MIPS32I Single Cycle Processor](/figures/SingleCycle.png "MIPS32I Single Cycle Processor")
## Introduction to project

This is a clean sheet design and implementation of a family of CPUs based on the MIPS 32-bit ISA, 
implemented in Verilog.
Current Implemented parts are as follows:   
1. [LASALU - Look-Ahead Standard ALU - implemented for logical and arithmetic instructions](/documentation/alu.md)
2. [Shifter - barrel shifter implemented for shift operations](/documentation/alu.md)
3. Single Cycle CPU - simple single cycle implementation of MIPS32iCPU

## How to run project
1. Launch the selected vivado project (currently, only single cycle is available)
2. Write assembly code in MARS and output to the vivado simulation folder 
(path = project_name/project_name.sim/sim_1/behav/xsim/ROM_data.txt)
3. Launch behavioral simulation and observe waveforms.

## TODO
- five stage pipelining
- branch predictor
