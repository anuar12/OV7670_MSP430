#ifndef __PINS_H
#define __PINS_H

#include <msp430.h>

#define VSYNC   BIT0 // P1.0  Vertical Sync Output, set high at start of frame
#define TXD     BIT1 // P1.1  UART transmitter
#define RXD     BIT2 // P1.2  UART receiver
#define RRST    BIT3 // P1.3  (note: on launchpad P1.3 has a debouncing cap) Read Reset for FIFO
#define RCLK    BIT4 // P1.4  Read Clock
#define WEN     BIT5 // P1.5  Write ENable
#define SCL     BIT6 // P1.6  I2C clock signal
#define SDA     BIT7 // P1.7  I2C data signal

#endif

/* vim: set sw=4 et: */
