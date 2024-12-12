# SRAM Controller Project

This project provides a simple Verilog implementation of an SRAM (Static Random Access Memory) controller along with a corresponding testbench to verify its functionality. The controller handles basic read and write operations with an SRAM device using a bi-directional data bus.

## Features

- **SRAM Controller:**
  - Supports read and write operations.
  - Bi-directional data bus for efficient data transfer.
  - Implements control signals like chip enable, output enable, and write enable.
  - State machine to manage idle, read, write, and wait states.

- **Testbench:**
  - Simulates the SRAM controller to test its functionality.
  - Includes a write operation to store data into memory.
  - Performs a read operation to verify the written data.
  - Generates a waveform file (`dump.vcd`) for analysis.

## File Structure

- **`sram_controller.v`:** Contains the SRAM controller's design code.
- **`tb_sram_controller.v`:** Testbench code for simulating the SRAM controller.

## How to Use

1. **Simulate the Design:**
   - Use any Verilog simulation tool (like `Icarus Verilog`, `ModelSim`, or `Vivado`) to compile and simulate the design.
   - Run the simulation to generate the waveform file (`dump.vcd`).

2. **Analyze the Waveform:**
   - Open the `dump.vcd` file in any waveform viewer (e.g., `GTKWave`) to visualize the SRAM controller's operations.

3. **Expected Output:**
   - The write operation writes a value (e.g., `0xAA`) to a specific address.
   - The read operation retrieves the same value from the same address, confirming the controller's functionality.

## Simulation Steps

1. **Reset the Controller:**
   - The system starts in a reset state to initialize all signals.

2. **Perform Write Operation:**
   - Provide an address and data.
   - Enable the write signal momentarily.

3. **Perform Read Operation:**
   - Specify the address to read.
   - Enable the read signal momentarily.
   - The expected data will be observed on the data bus.

4. **Monitor the Output:**
   - The testbench includes a monitor that logs the address, data bus value, and control signal states during simulation.


