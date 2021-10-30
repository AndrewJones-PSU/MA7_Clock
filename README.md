# Mimas A7 Clock
## A 24-hour clock using the Mimas A7's onboard 7 segment display

This Vivado project implements a simple 24-hour clock onto the Mimas A7 Revision
3.0 board. This design utilizes the Mimas A7's onboard 7 segment display to show
the hour and minute, as well as to blink the decimal point every half second. 
The seconds are also displayed using the Mimas A7's onboard LEDs, specifically
the lower 6 LEDs. 

## Basic Usage

Once you've created an implementation and written the bitstream, the clock is
controlled as follows:

- Reset Button: Sets Hour, Minute, and Seconds value to zero
- Left Button: Sets Seconds value to zero
- Right Button: Switches between incrementing hour and minute values* 
- Up/Down Button: Increments/Decrements the hour or minute value, depending on
what is selected

*the topmost onboard LED indicates whether hour or minute is selected. If the
LED is off, minute is selected. If the LED is on, hour is selected.

## Future Stuff
Here's a list of things that I might add on in the future:
- Change so Left Button also resets internal partial-second counter
- use a dip switch to lock/unlock changing time values
- add ability to switch between 12 and 24 hour time