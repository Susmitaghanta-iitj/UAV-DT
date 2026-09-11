# UAV-DT
# Design and Implementation of Swish Activation Function

## Overview

This project focuses on the **hardware-efficient design and implementation of the Swish activation function** for FPGA-based deep learning acceleration. Swish is defined as `f(x) = x · σ(x)`, where σ(x) is the sigmoid function. Although Swish provides smoother gradients and can offer advantages over traditional ReLU activation, its exponential and division operations make direct hardware implementation computationally expensive. This project investigates hardware-friendly approximations of Swish with the objective of reducing computational complexity, hardware resource utilization, and power consumption while maintaining a close approximation to the desired activation behavior. :contentReference[oaicite:2]{index=2}

Three hardware architectures are investigated: **(1) Swish using a standard Taylor-series expansion**, **(2) h-Swish**, and **(3) a proposed piecewise Swish approximation**. The proposed architecture replaces the exponential-based computation with simplified arithmetic operations and a piecewise function, making it more suitable for FPGA implementation. The designs are evaluated at **8-bit, 12-bit, and 16-bit precision**, with RTL architectures, simulation waveforms, LUT utilization, and on-chip power analyzed for each implementation.

## Proposed Approach

The proposed Swish approximation is implemented as a piecewise function:

\[
f_3(x)=
\begin{cases}
0, & x \leq -4 \\
x(x+12), & -4 < x < 0 \\
x(x+4), & 0 \leq x < 4 \\
x, & x \geq 4
\end{cases}
\]

This formulation avoids the exponential and division operations required by the original Swish function and instead uses basic arithmetic operations such as addition and multiplication. :contentReference[oaicite:5]{index=5}

## Results

The proposed architecture demonstrates reduced LUT utilization compared with the Taylor-series-based Swish implementation:

| Precision | Taylor Swish LUTs | Proposed LUTs |
|-----------|------------------:|--------------:|
| 8-bit     | 186               | **60** |
| 12-bit    | 251               | **106** |
| 16-bit    | 336               | **226** |

The reported on-chip power for the proposed implementation is **20.515 W, 30.33 W, and 35.49 W** for 8-bit, 12-bit, and 16-bit implementations respectively. The corresponding Taylor-based Swish implementations report **25.1 W, 31.9 W, and 42.1 W**. :contentReference[oaicite:6]{index=6}

## Key Highlights

- Hardware-oriented implementation of the **Swish activation function**
- Comparison of **Taylor-series Swish, h-Swish, and proposed Swish**
- Proposed **piecewise approximation** to eliminate exponential computation
- FPGA-oriented RTL architecture development
- Evaluation at **8-bit, 12-bit, and 16-bit precision**
- Analysis of **LUT utilization and on-chip power**
- Functional verification using simulation waveforms
- Focus on low-complexity and hardware-efficient AI acceleration

## Reference

The project is based on the work:

K. Choi, S. Kim, J. Kim and I.-C. Park, *"Hardware-Friendly Approximation for Swish Activation and Its Implementation,"* IEEE Transactions on Circuits and Systems II: Express Briefs, vol. 71, no. 10, pp. 4516–4520, Oct. 2024. DOI: 10.1109/TCSII.2024.3394806. :contentReference[oaicite:7]{index=7}

## Project Authors

Susmita Ghanta
Department of Electrical Engineering  
IIT Jammu
