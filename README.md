# Vector Multiplier Design in SystemVerilog

## Overview
This project presents the design, simulation, and hardware synthesis of a **Two-Input Vector Multiplier** implemented in SystemVerilog. The project explores two distinct architectural styles:
1.  **Purely Combinational Array Multiplier**: A fast, direct logic implementation using a grid of modified Full Adders.
2.  **Clock-Driven (Registered) Multiplier**: A sequential implementation with registered inputs and outputs to enhance timing stability and data integrity for FPGA deployment.

## Architecture & Design

### 1. Modified Full-Adder (FA) Block
The core of the multiplier is a modified Full-Adder. Unlike a standard FA, this unit integrates an internal **AND gate** to calculate partial products before performing the addition, effectively implementing the multiplication algorithm at the cell level.

<img width="1024" height="1024" alt="ChatGPT Image Feb 22, 2026, 04_56_20 PM" src="https://github.com/user-attachments/assets/8658fb65-c72e-43f5-863a-0e874dc3bf4e" />
*Figure: Internal logic of the modified FA for multiplication.*

### 2. Multiplier Structures
The design scales from a simple combinational flow to a robust sequential architecture.

#### Combinational Array Multiplier
Uses a direct flow from input vectors to the product output.
<img width="921" height="575" alt="arraymult" src="https://github.com/user-attachments/assets/4d8dda7c-e21b-46c0-8e35-8207ce61f0b7" />

#### Clock-Driven (Registered) Multiplier
Latches operands on the rising edge and stores the final product in output registers.
<img width="920" height="601" alt="clk-dr" src="https://github.com/user-attachments/assets/14464d2a-407c-48b2-a1ec-e9e374241713" />
---

## Simulation & Verification
Verification was performed using **ModelSim** with **Self-Checking Testbenches**. The testbenches automate the comparison between the Design Under Test (DUT) and expected mathematical results.

*   **Combinational Verification**: Observed deliberate synchronization delays in the testbench to ensure stable sampling of combinational logic.
*   **Sequential Verification**: Confirmed correct data latching. Note: Transient Hi-Z ('z') states observed in waveforms are artifacts of the testbench driver and do not affect functional correctness.

---

## 📊 Synthesis & Resource Utilization
Designs were synthesized using **Intel Quartus Prime** for FPGA targets.

### Resource Comparison Table
| Design Type | Nature | Registers Used | Resource Usage | Best For |
| :--- | :--- | :--- | :--- | :--- |
| **Array Multiplier** | Combinational | 0 | Low (LUTs only) | Fast, simple logic |
| **Clock-Driven** | Sequential | 32 | Moderate (LUTs + FFs) | High-speed FPGA timing |

---

## 🛠️ Tools Used
- **HDL**: SystemVerilog
- **Simulation**: ModelSim (Functional Verification)
- **Synthesis**: Intel Quartus Prime (Post-Fitting & RTL Analysis)
- **Methodology**: Self-Checking Testbenches

## Conclusion
The project demonstrates the trade-offs between combinational and sequential hardware design. While the Array Multiplier provides immediate results, the Clock-Driven version is significantly more robust for real-world FPGA applications by ensuring better timing closure and signal stability.
