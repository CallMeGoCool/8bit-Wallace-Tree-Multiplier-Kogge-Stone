## =========================================================
## WT_KS - Nexys 4 DDR Constraints
## Target Device:
## XC7A100T-CSG324-1
##
## SW[7:0]   -> Multiplicand A
## SW[15:8]  -> Multiplicand B
## LED[15:0] -> Product
## =========================================================


## =========================================================
## INPUT A - SWITCHES SW[7:0]
## =========================================================

set_property PACKAGE_PIN J15 [get_ports {A[0]}]
set_property PACKAGE_PIN L16 [get_ports {A[1]}]
set_property PACKAGE_PIN M13 [get_ports {A[2]}]
set_property PACKAGE_PIN R15 [get_ports {A[3]}]
set_property PACKAGE_PIN R17 [get_ports {A[4]}]
set_property PACKAGE_PIN T18 [get_ports {A[5]}]
set_property PACKAGE_PIN U18 [get_ports {A[6]}]
set_property PACKAGE_PIN R13 [get_ports {A[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {A[*]}]


## =========================================================
## INPUT B - SWITCHES SW[15:8]
## =========================================================

set_property PACKAGE_PIN T8 [get_ports {B[0]}]
set_property PACKAGE_PIN U8 [get_ports {B[1]}]
set_property PACKAGE_PIN R16 [get_ports {B[2]}]
set_property PACKAGE_PIN T13 [get_ports {B[3]}]
set_property PACKAGE_PIN H6 [get_ports {B[4]}]
set_property PACKAGE_PIN U12 [get_ports {B[5]}]
set_property PACKAGE_PIN U11 [get_ports {B[6]}]
set_property PACKAGE_PIN V10 [get_ports {B[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {B[*]}]


## =========================================================
## OUTPUT PRODUCT - LED[15:0]
## =========================================================

set_property PACKAGE_PIN H17 [get_ports {Product[0]}]
set_property PACKAGE_PIN K15 [get_ports {Product[1]}]
set_property PACKAGE_PIN J13 [get_ports {Product[2]}]
set_property PACKAGE_PIN N14 [get_ports {Product[3]}]
set_property PACKAGE_PIN R18 [get_ports {Product[4]}]
set_property PACKAGE_PIN V17 [get_ports {Product[5]}]
set_property PACKAGE_PIN U17 [get_ports {Product[6]}]
set_property PACKAGE_PIN U16 [get_ports {Product[7]}]

set_property PACKAGE_PIN V16 [get_ports {Product[8]}]
set_property PACKAGE_PIN T15 [get_ports {Product[9]}]
set_property PACKAGE_PIN U14 [get_ports {Product[10]}]
set_property PACKAGE_PIN T16 [get_ports {Product[11]}]
set_property PACKAGE_PIN V15 [get_ports {Product[12]}]
set_property PACKAGE_PIN V14 [get_ports {Product[13]}]
set_property PACKAGE_PIN V12 [get_ports {Product[14]}]
set_property PACKAGE_PIN V11 [get_ports {Product[15]}]

set_property IOSTANDARD LVCMOS33 [get_ports {Product[*]}]


## =========================================================
## TIMING CONSTRAINT
## =========================================================
##
## WT_KS is a combinational design and has no internal clock.
##
## Therefore, a virtual 100 MHz clock is used as a timing
## reference. This allows Vivado to analyze the combinational
## input-to-output path.
##
## Clock period = 14.706 ns (for 68MHz clock)
##
## =========================================================

create_clock -name virtual_clk -period 14.706


## Input arrival time
set_input_delay 0.000 -clock virtual_clk [get_ports {A[*]}]
set_input_delay 0.000 -clock virtual_clk [get_ports {B[*]}]


## Output required time
set_output_delay 0.000 -clock virtual_clk [get_ports {Product[*]}]