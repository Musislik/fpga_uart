# FPGA_UART


## UART Module Testing

![rtl_schema](https://github.com/user-attachments/assets/1d76a09e-101a-47b9-8a97-def205739b2e)

The UART module was tested as following:

1. Using the **switches (SW)**, we configured:
   - The **baud rate** (data transmission speed),
   - The **word length** (number of data bits),
   - The **ASCII character** to be transmitted.

2. The selected character was then sent from the FPGA to the PC and displayed in the PuTTY serial console.

3. An ASCII character was sent back from the PC to the FPGA.

4. The received character (**its binary value**) was displayed on the **7-segment display**.


## Receiver
Inputs:
1) Clock
2) Baud enable
3) Data length
4) Reset?
5) RX start
6) RX
7) Next msg

Outputs:
1) Data
2) Msg
buffer is not empty

![thumbnail_image](https://github.com/user-attachments/assets/afb98a04-9d87-4f61-b18e-1056e1194ba0)


## Transmiter
Inputs:
1) Clock
2) TX start
3) Data input
4) Data length
5) Baud enable

Outputs:
1) TX
2) TX done

![thumbnail_image](https://github.com/user-attachments/assets/048f75a0-91db-4b56-8333-fce31b304478)

## 📦 FIFO Buffer

A FIFO buffer module was successfully designed and verified through simulation.  
*(Refer to the simulation output below.)*

During the hardware testing phase in the lab, we discovered that the buffer could not be synthesized. The issue was probably caused by the use of a `variable` for dynamic signal indexing, which is in our thoughts not supported in synthesis for our FPGA toolchain.

Due to this limitation and lack of time, the FIFO buffer was not integrated into the top-level design.

## ✅ Project Summary

The goal of this project was to design, simulate, and test a UART module with FIFO buffering on an FPGA.

We successfully implemented and tested the UART core, including configurable baud rate, word length, and communication with a PC. Inputs were provided via switches; outputs were shown on a 7-segment display.

The FIFO buffer, although successfully simulated, could not be synthesized probably due to unsupported indexing. Because of this issue, the buffer was not included in the final top-level design.

The project was **partially completed** — the UART works correctly, but FIFO buffering is missing in the hardware implementation.

---

### 👥 Team Members

- [Marek Ďurďa]
- [Ondřej Ondříšek]  
- [Pavel Musil]
