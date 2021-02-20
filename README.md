# FPGA-Bluetooth-Application---VHDL
Sending commands from a mobile device to a development board - Nexys 4 / Basys 3

The aim of the project is to make a connection between the Nexys 4 DDR FPGA card and a Java / Android application. This connection will be made with a Bluetooth PMOD BT2 module. Through the application will be given commands to the board representing fundamental mathematical operations that are implemented in VHDL through an arithmetic and logic unit.
The main objectives of the project are to see how the Nexys 4 DDR FPGA board behaves if it is connected to a Bluetooth PMOD BT2 module through which it will communicate with a Java application and to learn more about FPGAs and the structure of computing systems . Through this project we will perform some arithmetic operations using an ALU that will be implemented in VHDL, data will be transmitted to the board through a Bluetooth module and a Java application. As a utility we will work in Vivado and Intellij IDEA.
The plate will display the results of the following operations: addition, subtraction, multiplication, division, right-left movement and finally a few LEDs will light up.


The proposed solution for solving the project is to implement a logical arithmetic unit to perform the following operations: addition, subtraction, multiplication, division and 
left-right movement. The addition operation is done by an adder in anticipation of the transport, the subtraction is done in the same way, ie we use the adder at the meeting but 
instead of the second term we will put the complement to two of the the second issue of the operation. The multiplication will be done by a multiplication circuit by the Booth 
method, and the division by a division circuit with the restoration of the partial rest. For left-right movements we will use the travel circuits learned in the past semesters in
similar subjects. The Java application will be made in the Intellij IDEA and the connection between the board and the Java application will be made through a Bluetooth PMOD BT2
module. More details on all this in the sections of the following chapters.

The realization of the project consists in designing and implementing a system consisting of a Java application that will send commands to a development board. This connection between the Java application and the FPGA card will be made using a Pmod BT2 Bluetooth module.
The implementation of this project is done with the help of an FPGA development board (Nexys 4 / Basys 3) using the VHDL hardware description language, using the Vivado software program.
To increase the complexity of the system we chose to implement a Logical Arithmetic Unit (ALU) that will receive user data in the Java application.
In the continuation of this documentation will be presented some theoretical notions about the FPGA boards we will use, the utilities we will work on, the methods used to carry out the project, some experimental results and the bibliography.
