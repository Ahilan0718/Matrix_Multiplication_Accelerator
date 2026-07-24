# Matrix Multiplication Accelerator

A parameterized 2×2 Matrix Multiplication Accelerator designed in Verilog HDL using four parallel Processing Elements (PEs) and Multiply-Accumulate (MAC) units. The accelerator performs matrix multiplication in four clock cycles under the control of a finite state machine (FSM). The design was functionally verified using Icarus Verilog and GTKWave and synthesized using Xilinx Vivado.

## Repository Structure

```text
Matrix_Multiplication_Accelerator/
│
├── codes/
│   ├── mat_accel.v            # Top-level matrix multiplication accelerator
│   ├── control_fsm.v          # Control FSM
│   ├── pe.v                   # Processing Element
│   ├── mac.v                  # Multiply-Accumulate Unit
│   └── multiplier.v           # Parameterized Multiplier
│
├── tb/
│   ├── mat_accel_tb.v
│   ├── controller_tb.v
│   ├── pe_tb.v
│   ├── mac_tb.v
│   └── multiplier_tb.v
│
├── simulation/
│   ├── dump_top.vcd
│   └── dump_multi.vcd
│
├── vivado/
│   ├── Synthesis_Report.pdf
│   └── Utilization_Report.pdf
│
├── pics/
│   ├── Schematic1.png
│   ├── Schematic2.png
│   ├── Waveform.png
│   ├── Utilization.png
│   └── Timing.png
│
├── LICENSE
└── README.md
```

---

# Accelerator Features

- Parameterized Verilog HDL Design
- 2×2 Matrix Multiplication Accelerator
- Parallel Processing using Four Processing Elements
- Multiply-Accumulate (MAC) Architecture
- Parameterized Multiplier
- Finite State Machine (FSM) Controller
- Two Computation Cycles
- Four Clock Cycle Execution
- Modular Hierarchical Design
- Self-checking Testbenches
- Functional Verification using Icarus Verilog
- Waveform Verification using GTKWave
- FPGA Synthesis using Xilinx Vivado

---

# Architecture

The accelerator consists of:

- Controller FSM
- Four Parallel Processing Elements (PE0–PE3)
- Four Multiply-Accumulate (MAC) Units
- Four Parameterized Multipliers

Each Processing Element computes one element of the output matrix in parallel.

                 Matrix A         Matrix B
                     │               │
                     └───────┬───────┘
                             │
                       Control FSM
                             │
      ┌──────────┬───────────┼───────────┐
      │          │           │           │          
     PE0        PE1         PE2         PE3
      │          │           │           │
      └──────────┴───────────┼───────────┘
                             │
                      Output Matrix (C)


---

# Matrix Multiplication

For

```
      |A11 A12|      |B11 B12|
A  =  |       |  B = |       |
      |A21 A22|      |B21 B22|
```

the accelerator computes,

```
C11 = A11×B11 + A12×B21

C12 = A11×B12 + A12×B22

C21 = A21×B11 + A22×B21

C22 = A21×B12 + A22×B22
```

using four Processing Elements operating simultaneously.

---

# Performance Summary

- Total Clock Cycles : **4**
- Computation Cycles : **2**
- Parallel Processing Elements : **4**
- Multiplications per Matrix : **8**
- Additions per Matrix : **4**
- Computational Complexity : **O(N³)**

At a 100 MHz clock frequency:

- Latency : **40 ns**
- Throughput : **25 Million Matrix Multiplications / Second**

---

# FPGA Synthesis Summary

- Slice LUTs : **439**
- Slice Registers : **74**
- Bonded IOBs : **136**
- BUFGCTRL : **1**
- Worst Negative Slack (WNS) : **1.642 ns**
- Worst Hold Slack (WHS) : **0.137 ns**

---

# Verification

The following modules were individually verified:

- Multiplier
- Multiply-Accumulate Unit (MAC)
- Processing Element (PE)
- Controller FSM
- Top-Level Matrix Multiplication Accelerator

All testbenches are self-checking and automatically report PASS/FAIL conditions.

---

# Tools Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- Xilinx Vivado