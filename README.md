# Le GoonLock

A Cryptographic Acceleration and Protocoled Wireless Communication FPGA Module for IoT

[block diagram]

Le GoonLock attempts to solve the problem of Internet of Things (IoT) devices revealing people's private data. IoT devices pose a serious security risk because they are underpowered to perform intensive, secure encryption. Le GoonLock will offload this workload onto a Field Programmable Gate Array (FPGA). The module will perform Advanced Encryption Standard, 256-bit (AES-256) encryption in parallel, with Galois Counter Mode (GCM) in parallel. The encrypted data is then passed to a MicroBlaze Processor, which will encapsulate this data in Transmission Control Protocol/Internet Protocol (TCP/IP) packets, then sent over Wi-Fi.

## Hardware
The board being used is a Digilent Nexys A7 development board containing a Xilinx XC7A100T FPGA. We chose this board because it contains the latest genration of Xilinx FPGAs, as well as a large amount of space (63,000 look-up tables) for our implementation of AES-256 and TCP/IP packaging. We also use a Digilent PMOD Wi-Fi module to add Wi-Fi functionality to the Goonlock.

![FGPA board and Wi-Fi card](https://cdn10.bigcommerce.com/s-7gavg/products/629/images/5235/NexysA7-obl-600__85101.1541089437.1280.1280.jpg?c=2)

## Gateware
Gateware is the configuration of the FPGA, which in this project is done in Verilog. We have written Verilog code to implement an AES-256 encryption module. This module has a configurable number of AES blocks to be able to prioritize speed or area when performing GCM in parallel. This encryption module is connected to a MicroBlaze microprocessor over the Advanced eXtensible Interface Lite (AXI-Lite) bus that will perform all the other tasks needed to parse inputted data and send the encrypted data to another FPGA board.

[image of vivado block design]

## Software
This is the C++ code that implements a state machine to reiceive inputted data, pass it to the encryption module, read the encrypted data and write this stream of data over TCP/IP to the other FGPA board. 

In more detail. after the processor connects to a Wi-Fi network, it moves into a WAIT state, where it checks for incoming TCP connections, or a signal from the slave device that it is ready to send a message. If a message is ready to be received, the input is read 16 characters at a time, the same size as a AES block. The raw data is then written to the 4 32-bit input registers of the encryption module. Once the valid signal on the encryption module is raised, the encrypted data is read and converted into a hexadecimal string, which is then sent over TCP to the receiving device. The receiving device transisions out of it's WAIT state and passes this encrypted data to a decryption module. Once the decrypted data is valid, it is passed to the recieving FPGA's slave device, completing the transaction.

[image of state machine]

## Results
timing for exchanges, algorithm throughput, and luts/slices used.

## Authors
Jon Recta (jonpaolo02)

David Sun (NusDivad)
## Acknowledgments
Thank you to Mr. Bell of the TJHSST Microelectronics Lab, as well as our labmates for thier feedback and support.
