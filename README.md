# I2C/SPI Slave UVM Verification

## Overview
UVM-based functional verification of an I2C slave IP core with planned SPI extension.
The testbench verifies register read/write operations through pin-level protocol simulation.

## Repository Structure
rtl/        - OpenCores I2C Slave RTL (reference design by Steve Fielding)
uvm_tb/     - UVM Testbench (SystemVerilog)

## Testbench Architecture
test
└── environment
    ├── agent
    │   ├── sequencer
    │   ├── driver    (I2C master - bit-level protocol)
    │   └── monitor   (observes SDA/SCL)
    └── scoreboard    (checks DUT response)

## DUT Details
- Protocol : I2C Slave
- Address  : 0x3C
- Registers: 8 (0x00-0x07)
  - Regs 0-3 : Read/Write
  - Regs 4-7 : Read Only

## Verification Plan
- [x] I2C agent (driver, monitor, sequencer)
- [x] Directed write test (addr=0x3C, reg=0x00, data=0xAB)
- [ ] Scoreboard based self checking
- [ ] SPI agent
- [ ] Cross protocol verification (write I2C read SPI)

## Tools
- Language : SystemVerilog
- Methodology : UVM
- Simulator : QuestaSim

## RTL Credit
OpenCores I2C Slave core by Steve Fielding
License: LGPL

## Author
- Mosali Abhinav Reddy
