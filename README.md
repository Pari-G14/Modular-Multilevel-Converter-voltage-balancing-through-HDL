# MMC Capacitor Voltage Balancing Using FPGA

## Project Overview

This project implements a real-time capacitor voltage balancing and submodule selection algorithm for a Modular Multilevel Converter (MMC) using Verilog HDL and FPGA-based digital control.

The controller processes capacitor voltage information, sorts the submodules according to their capacitor voltages, determines the required number of inserted submodules using the modulation level, and selects appropriate submodules based on the arm current direction.

## Main Modules

- `mmc.v` – Top-level MMC controller
- `compare_swap.v` – Compare-and-swap element used for sorting
- `odd_even_sort5.v` – Odd-even sorting network for capacitor voltage ranking
- `selection_logic.v` – Submodule insertion/bypass selection logic
- `nlm_module.v` – Nearest Level Modulation logic
- `sine_generator.v` – Sine-wave reference generation using LUT

## Simulation Testbenches

- `tb_mmc.v`
- `tb_nlm_module.v`
- `tb_odd_even_sort5.v`
- `tb_selection_logic.v`
- `tb_sin_generator.v`

## Tools

- Xilinx Vivado 2022.2
- Verilog HDL
- Xilinx FPGA

## Project Structure

```text
MMC_Capacitor_voltage_balancing.xpr
│
├── MMC_Capacitor_voltage_balancing.srcs/
│   ├── sources_1/
│   │   └── imports/new/
│   │       ├── mmc.v
│   │       ├── compare_swap.v
│   │       ├── odd_even_sort5.v
│   │       ├── selection_logic.v
│   │       ├── nlm_module.v
│   │       └── sine_generator.v
│   │
│   └── sim_1/
│       └── imports/new/
│           ├── tb_mmc.v
│           ├── tb_nlm_module.v
│           ├── tb_odd_even_sort5.v
│           ├── tb_selection_logic.v
│           └── tb_sin_generator.v

## How to Run

### Requirements

- Xilinx Vivado 2022.2 or compatible Vivado version
- Windows operating system
- Verilog HDL simulation support

### Steps

1. Download the repository using **Code → Download ZIP** and extract the ZIP file.

2. Open the extracted project folder.

3. Locate and open:
   `MMC_Capacitor_voltage_balancing.xpr`

   This will open the project in Xilinx Vivado.

4. In Vivado, wait for the project to load and allow Vivado to update/refresh the project files if prompted.

5. In the **Sources** window:
   - Expand **Design Sources** to view the Verilog design modules.
   - Expand **Simulation Sources → sim_1** to view the testbenches.

6. To run the complete MMC simulation:
   - Select `tb_mmc.v` under **Simulation Sources**.
   - Right-click `tb_mmc.v`.
   - Select **Set as Top** if it is not already selected as the simulation top module.

7. From the **Flow Navigator**, select:
   **Simulation → Run Simulation → Run Behavioral Simulation**

8. Vivado will compile the Verilog files and open the waveform window.

9. In the waveform window, select the required signals and click **Zoom Fit** to observe the simulation results.

### Individual Module Simulations

The repository also contains separate testbenches for individual modules:

- `tb_mmc.v` – Complete MMC controller
- `tb_nlm_module.v` – Nearest Level Modulation
- `tb_odd_even_sort5.v` – Capacitor voltage sorting
- `tb_selection_logic.v` – Submodule selection logic
- `tb_sin_generator.v` – Sine-wave generation

To simulate an individual module, right-click its corresponding testbench in **Simulation Sources**, select **Set as Top**, and run **Behavioral Simulation**.

### Important

The project was developed and tested using **Xilinx Vivado 2022.2**. For the most reliable results, use Vivado 2022.2 when opening the `.xpr` project.
