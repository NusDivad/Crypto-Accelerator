# Goonlock
A Cryptographic Acceleration and Protocoled Wireless Communication Module for FPGA

[block diagram]

Le Goonlock attempts to solve the problem of Internet of Things (IoT) devices revealing people's private data. IoT devices pose a serious security risk because they are underpowered to perform intensive, secure encryption. Le Goon Lock will offload this workload onto a Field Programmable Gate Array (FPGA), which will perform Advanced Encryption Standard, 256-bit  Galois Counter Mode (AES-256 GCM) encryption in parallel. The encrypted data is then passed to a MicroBlaze Processor, which will encapsulate this data in Transmission Control Protocol/Internet Protocol (TCP/IP) packets, then sent over Wi-Fi.

## Hardware
The FGPA being used is a Digilent Nexys A7 development board. We chose this board because it contains the latest genration of Xilinx FPGA's, as well as a large amount of space for our implementation of AES-256 and TCP/IP packaging. We also use a Digilent PMOD Wi-Fi module to add Wi-Fi functionality to the Goonlock.

## Gateware
Gateware is the configuration of the FPGA, which in this project is done in Verilog. We have written Verilog code to implement an AES-256 encryption module, as well as a microprocessor that will perform all the other tasks needed to parse inputted data and send the encrypted data to another FPGA board.

## Software
This is the C++ code that implements a state machine to reiceive inputted data, pass it to the encryption module, read the encrypted data and write this stream of data over TCP/IP to the other FGPA board. 

## Results
timing for exchanges, algorithm throughput, and luts/slices used.
