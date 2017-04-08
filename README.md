Implementation of capturing image and transmitting to PC from OV7670 with
AL422 FIFO chip.
============================================================================

OV7670 <-> Serial bridge using MSP430 Launchpad.

The code is compiled by mspgcc, programmed to the MSP430, run and then
python script camview.py is run in order to communicate with MCU via UART.

Most of the code has been taken from:
http://www.rpg.fi/desaster/blog/2012/10/20/ov7670-fifo-msp430-launchpad/
