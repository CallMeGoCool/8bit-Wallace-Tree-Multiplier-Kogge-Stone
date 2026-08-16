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
