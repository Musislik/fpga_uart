# FPGA_UART

## 👥 Team Members

- [Marek Ďurďa]
- [Ondřej Ondříšek]  
- [Pavel Musil]

## 📝 Abstract

This project focuses on the implementation and testing of a UART (Universal Asynchronous Receiver-Transmitter) module on an FPGA. The UART allows communication between the FPGA and a PC via a serial connection. The system supports configurable parameters such as baud rate and word length using hardware switches.

The project demonstrates a functional UART implementation with room for future improvements.

## 🔧 Hardware Description 

- Switches were used for configuration and as data input.
     - Data length:
          -00 => 5 bits
          -00 => 6 bits
          -00 => 7 bits
          -00 => 8 bits
     - Baudrate:
          -00 => 24 000
          -00 => 96 000
          -00 => 57 600
          -00 => 115 200
- Output was displayed on a 7-segment display

![controls](https://github.com/user-attachments/assets/ec4c29c7-b694-44b6-883b-3b7d96db183e)

## 💻 Software Description

The project is written in VHDL. The design includes:

- UART TX and RX state machines
- Edge detector
- Clock divider
- Segment display controller


### 🧪 UART module testing

![Top-level schematic](https://github.com/user-attachments/assets/1d76a09e-101a-47b9-8a97-def205739b2e)

The UART module was tested as following:

1. Using the **switches (SW)** we configured:
   - The **baud rate** (data transmission speed)
   - The **word length** (number of data bits)
   - The **ASCII character** to be transmitted

2. The selected character was then sent from the FPGA to the PC and displayed in the PuTTY serial console.

3. An ASCII character was sent back from the PC to the FPGA.

4. The received character (**its binary value**) was displayed on the **7-segment display**.


### 📥 Receiver

![uart_reciver](https://github.com/user-attachments/assets/53da3adb-b958-42ee-9d8a-480e912d4e56)

Inputs:
1) Clock
2) Configurations bits
3) Reset
4) Data input

Outputs:
1) Data
2) RX done


### 📤 Transmiter

![uart_transmiter](https://github.com/user-attachments/assets/7db83e57-cdfd-4f29-9e84-2af82ebcb78b)

Inputs:
1) Clock
2) TX start
3) Data input
4) Configuration bits
5) Reset

Outputs:
1) TX
2) TX done


### 📦 FIFO Buffer

A FIFO buffer module was successfully designed and verified through simulation.  
*(Refer to the simulation output below.)*

During the hardware testing phase in the lab, we discovered that the buffer could not be synthesized. The issue was probably caused by the use of a `variable` for dynamic signal indexing, which is in our thoughts not supported in synthesis for our FPGA toolchain.

Due to this limitation and lack of time, the FIFO buffer was not integrated into the top-level design.

## 📈 Component Simulations

### UART RX/TX

![reciver_6bit_115200baud_sekvence](https://github.com/user-attachments/assets/80deb0e9-d045-4833-a6e7-ba74560535d6)

### 📦 FIFO Buffer

FIFO buffer behavior was verified through simulation. Correct operation confirmed for enqueue/dequeue and buffer_empty flag.  

![image](https://github.com/user-attachments/assets/dc5e015f-5f2b-4eee-a6b8-7baf0fb47b1c)

## ✅ Project Summary

The goal of this project was to design, simulate, and test a UART module with FIFO buffering on an FPGA.

We successfully implemented and tested the UART core, including configurable baud rate, word length, and communication with a PC. Inputs were provided via switches, outputs were shown on a 7-segment display.

The FIFO buffer, although successfully simulated, could not be synthesized probably due to unsupported indexing. Because of this issue, the buffer was not included in the final top-level design.

The project was **partially completed** — the UART works correctly, but FIFO buffering is missing in the hardware implementation.

## 📚 References

- Nexys A7-50T Reference Manual – [Digilent](https://digilent.com/reference/programmable-logic/nexys-a7/start)
- VHDL syntax references (e.g. [vhdlwhiz.com](https://vhdlwhiz.com/))
- UART protocol documentation – [Wikipedia](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter)
- PuTTY serial terminal – [putty.org](https://www.putty.org/)
- EDA Playground - [edaplayground.com](https://www.edaplayground.com/)
