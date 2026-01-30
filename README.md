# -Implementation-of-the-Pan-Tompkins-Algorithm-in-Hardware-using-High-Level-Synthesis-Tools

ECG Peak Detection – MATLAB & HDL Coder

This repository contains MATLAB code for ECG peak detection algorithms intended for HDL code generation (VHDL) using MATLAB HDL Coder.

--------------------------------------------------

Repository Structure

The code is organized around two main functions:

- pt
- pt_V2

Each main function has its own set of subfunctions.

pt related files:
- All helper functions whose names start with pt
- These files correspond to the original floating-point / baseline implementation

pt_V2 related files:
- Helper functions whose names start with fimath
- The hardware-oriented peak detection module pt_peak_hw
- These files are designed for fixed-point arithmetic and HDL compatibility

--------------------------------------------------

Testbenches and Databases

This repository also includes:

- Testbenches for each main function (pt and pt_V2)
- Testbenches for the following ECG databases:
  - MIT-BIH record mit200
  - MILI database
- The ECG databases used for validation are included in the repository

--------------------------------------------------

How to Use the Code (HDL Generation)

To generate HDL (VHDL) code using this repository:

1. Download all files from the repository.
2. Ensure MATLAB with HDL Coder is installed.
3. Create a new HDL Coder project in MATLAB.
4. Configure the project as follows:
   - Select the desired main function (pt or pt_V2) as the Design Function.
   - Select the corresponding testbench as the Testbench Function.
5. Run fixed-point simulation and HDL code generation.

--------------------------------------------------

Performance Tip

To reduce simulation and code generation time, the input types can be configured as double scalar in the HDL Coder settings.

--------------------------------------------------

Notes

- The code is written in a sample-by-sample (streaming) style suitable for hardware implementation.
- Fixed-point versions use explicit numerictype and fimath definitions to ensure deterministic HDL behavior.
