`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// File: MA7ClockTopModule.v
// Author: Andrew Jones (https://github.com/AndrewJones-PSU)
// Creation Date: 6/9/2021
// Target Devices: Mimas A7 Revision V3 Development Board 
//
// Description: This module implements a simple 24-hour clock using the
//     Mimas A7's onboard seven segment display. Made this mostly for fun.
////////////////////////////////////////////////////////////////////////////////


module MA7ClockTopModule(
    // 100 MHz Clock
    input clk,
    // Buttons on Devboard
    input upBtn,
    input downBtn,
    input leftBtn,
    input rightBtn,
    input resetBtn,
    
    output [7:0] leds,
    output [7:0] ssd_out,
    output [3:0] ssd_en
);

    // button debouncing
    wire upPulse, downPulse, leftPulse, rightPulse, resetPulse;
    ButtonDebouncer upDebouncer(.clk(clk), .buttonState(upBtn), .debouncedPosedgePulse(upPulse));
    ButtonDebouncer dnDebouncer(.clk(clk), .buttonState(downBtn), .debouncedPosedgePulse(downPulse));
    ButtonDebouncer ltDebouncer(.clk(clk), .buttonState(leftBtn), .debouncedPosedgePulse(leftPulse));
    ButtonDebouncer rtDebouncer(.clk(clk), .buttonState(rightBtn), .debouncedPosedgePulse(rightPulse));
    ButtonDebouncer rsDebouncer(.clk(clk), .buttonState(resetBtn), .debouncedNegedgePulse(resetPulse));
    
    wire [5:0] second, minute, hour;
    wire blink, cursorPos;
    ClockStateStorage clockStateStorage(clk, upPulse, downPulse, leftPulse, rightPulse, resetPulse, second, minute, hour, blink, cursorPos);
    
    wire [15:0] value;
    TimeDecoder timeDecoder(hour, minute, value);
    
    wire [3:0] decimalPoint = {1'b0, blink, 2'b0};
    SevenSegmentDisplayDecoder ssdd(clk, value, decimalPoint, ssd_out, ssd_en);
    
    assign leds = {cursorPos, 1'b0, second};
    
endmodule
