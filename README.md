# 8bit-Wallace-Tree-Multiplier-Kogge-Stone
Verilog HDL implementation and FPGA evaluation of an 8-bit Wallace Tree multiplier with Kogge-Stone carry propagation on the Nexys 4 DDR.

## Overview

This project implements an 8-bit unsigned multiplier using two hardware architectures:

- Wallace Tree for reducing the generated partial products.
- Kogge-Stone adder for fast carry propagation during the final addition.

The design produces a 16-bit multiplication result from two 8-bit inputs.

The project was developed as part of the Online Internship in RTL Design using Verilog HDL conducted by NIELIT Chennai.

## Architecture

The multiplication process is divided into the following main stages:

1. Generation of partial products from the two 8-bit inputs.
2. Reduction of partial products using the Wallace Tree structure.
3. Formation of the final sum and carry rows.
4. Addition of the final rows using a Kogge-Stone adder.
5. Generation of the 16-bit product.

<img width="940" height="231" alt="image" src="https://github.com/user-attachments/assets/692fc8ea-8c45-4a50-be0f-2aec89579f0d" />


## Target Hardware

| Parameter | Specification |
|---|---|
| FPGA Board | Nexys 4 DDR |
| FPGA Device | Xilinx Artix-7 XC7A100T |
| Package | CSG324 |
| LUTs Available | 63,400 |
| Flip-Flops Available | 126,800 |
| Block RAM | 135 |
| DSP Blocks | 240 |
| Development Tool | Xilinx Vivado |

## Design Specifications

| Parameter | Value |
|---|---:|
| Input A | 8-bit |
| Input B | 8-bit |
| Output Product | 16-bit |
| Multiplier Architecture | Wallace Tree |
| Final Adder | Kogge-Stone |
| HDL | Verilog |
| DSP Blocks Used | 0 |
| Final Operating Frequency | 68 MHz |

## Verification

The design was verified using a Verilog testbench containing both directed test cases and exhaustive verification.

The exhaustive verification tested every possible combination of the two 8-bit inputs:

256 × 256 = 65,536 combinations

All 65,536 combinations produced the expected multiplication result.

### Example

```text
A = FF
B = FF
Expected Product = FE01
Generated Product = FE01
```

###
Timing Characterization

The design was initially evaluated with a 100 MHz clock constraint. Static timing analysis showed that the design could not satisfy the 10 ns clock period after implementation.

The clock frequency was then reduced and evaluated at different values.
| Clock Frequency | Clock Period | Implementation WNS | Timing Status |
| --------------- | -----------: | -----------------: | ------------- |
| 100 MHz         |    10.000 ns |          -4.081 ns | Not Met       |
| 70 MHz          |    14.286 ns |          -0.125 ns | Not Met       |
| 68 MHz          |    14.706 ns |           0.148 ns | Met           |


The final operating frequency was selected as 68 MHz because it was the highest tested frequency at which the implemented design satisfied the specified timing constraints.

Final Implementation Results
| Parameter               |   Result |
| ----------------------- | -------: |
| LUTs                    |      133 |
| I/O Pins                |       32 |
| DSP Blocks              |        0 |
| Total On-Chip Power     |  0.124 W |
| Dynamic Power           |  0.027 W |
| Static Power            |  0.097 W |
| Setup WNS               | 0.148 ns |
| Hold WNS                | 2.799 ns |
| Setup TNS               | 0.000 ns |
| Failing Setup Endpoints |        0 |
| Operating Frequency     |   68 MHz |


Outputs:

<img width="1512" height="772" alt="Behavioral Simulation" src="https://github.com/user-attachments/assets/5c58bdae-6ea8-4641-b1dc-738fb8e67a97" />


<img width="644" height="364" alt="Implementation - Power Summary" src="https://github.com/user-attachments/assets/81636b02-9a77-4e9c-b543-583f6939e8cb" />


<img width="501" height="136" alt="Implementation - Utliization Summary" src="https://github.com/user-attachments/assets/662f28c2-b0f3-4475-a080-8c945f52a7f5" />


<img width="804" height="160" alt="Implementation - Design Timing Summary" src="https://github.com/user-attachments/assets/227f67b1-debb-47c7-b256-a6d3f9547358" />


<img width="649" height="141" alt="Implementation - Intra Clock Paths" src="https://github.com/user-attachments/assets/fd5e4940-8b69-48fc-802c-92c8de698d39" />


<img width="543" height="2841" alt="Overall Design and Verification Flow" src="https://github.com/user-attachments/assets/c7c784f7-b83d-4edd-aa60-b777e88191c5" />
