# Final Project: Advanced CPU Architecture and Hardware Accelerators Lab

## Overview

This project focuses on the design, synthesis, and analysis of a Single Cycle MIPS CPU with support for memory-mapped I/O and interrupt handling. The implementation was carried out using Quartus Prime and the model is realized on an FPGA board.

*Contributors*:  
- Yehonatan Arama  
- Yuval Yacov Said  

## Project Features

- *MIPS CPU*: A single-cycle processor based on the MIPS ISA with support for instruction and data memory, and interrupt handling.
- *Divider Unit*: Performs division operations, optimized for fast execution.
- *Interrupt Controller*: Handles external hardware interrupts and manages system priority.
- *Timer*: Programmable timer with PWM (Pulse Width Modulation) support and interrupt generation.
- *GPIO Interface*: For interaction with user inputs (switches, LEDs, and 7-segment displays).
- *System Clock: Operates at a frequency of **30 MHz*, with critical paths optimized for efficiency.

## Design & Implementation

1. *MCU Top Module*: The core module includes the CPU, interrupt controller, and other peripheral modules.
2. *Fmax Analysis: Maximum frequency of the system is calculated at **30.48 MHz*, with critical paths analyzed for further optimization.
3. *Divider Unit: A fast clock-based division module running at **60 MHz*, capable of completing division in 32 cycles.
4. *GPIO*: Interfaces with external components via buttons and switches.
5. *Simulation & Validation: Performed using **ModelSim* to verify functionality, such as timing and PWM generation.

## Project Files

- *Quartus Project Files*: Contains all the necessary files for FPGA implementation.
- *ModelSim Simulation Files*: Used for testing the system's performance and timing.

## Contact

For any questions or collaboration opportunities, feel free to contact the contributors:
- Yehonatan Arama: yoni1arama@gmail.com
- Yuval Yacov Said: yuvalisaid@gmail.com