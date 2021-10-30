////////////////////////////////////////////////////////////////////////////////
// File: ClockStateStorage.v
// Author: Andrew Jones (https://github.com/AndrewJones-PSU)
// Creation Date: 6/9/2021
// Target Devices: Mimas A7 Revision V3 Development Board 
//
// Description: This module holds the current value of the clock as well as
// manages incrementing the clock every second. This module also can accept
// signals from the dev board's buttons to increment the hour and minute
// segments of the clock, as well as reset their values.
////////////////////////////////////////////////////////////////////////////////

module ClockStateStorage(
    // 100 MHz onboard clock
    input clk,
    // up, down, left, right, and reset button pulses for incrementing/
    // decrementing time values, switching between selecting minute/hour
    // values for incrementing/decrementing, and for resetting clock values.
    input up, down, left, right, reset,
    
    // output of the current time formatted based on dip
    output [5:0] second, minute, hour,
    // output that activates on the 2nd half of every second
    output reg blink,
    // output of position of cursor for handling inputs
    output reg cursorPos
);
    // TODO: these could use more comments
    reg [25:0] secondIncrementCounter;
    
    reg [5:0] trueHour; 
    reg [5:0] trueMinute;
    reg [5:0] trueSecond;

    // assign outputs to registers in proper format
    assign hour = trueHour;
    assign minute = trueMinute;
    assign second = trueSecond;

    initial begin
        trueSecond = 0;
        trueMinute = 0;
        trueHour = 0;
        secondIncrementCounter = 0;
        blink = 1;
        cursorPos = 0;
    end

    always @(posedge clk) begin
        // handle input pulses, these do not overflow into each other
        if (reset) begin
            trueSecond <= 0;
            trueMinute <= 0;
            trueHour <= 0;
        end
        if (left)
            trueSecond <= 0;
        if (right)
            cursorPos <= ~cursorPos;
        if (up) begin
            case (cursorPos)
                1'b0 : trueMinute <= trueMinute < 59 ? trueMinute + 1 : 0;
                1'b1 : trueHour <= trueHour < 23 ? trueHour + 1 : 0;
            endcase
        end
        if (down) begin
            case (cursorPos)
                1'b0 : trueMinute <= trueMinute > 0 ? trueMinute - 1 : 59;
                1'b1 : trueHour <= trueHour > 0 ? trueHour - 1 : 23;
            endcase
        end


        // increment counter, if we reach 100M reset to zero, increment clock
        secondIncrementCounter <= secondIncrementCounter + 1;
        if (secondIncrementCounter == 26'd50000000) begin
            secondIncrementCounter <= 1;
            blink <= ~blink;
            if (blink == 0)
            begin
                trueSecond <= trueSecond + 1;
                // if second is 60, "overflow" to minutes
                if (trueSecond == 6'd59) begin
                    trueSecond <= 0;
                    trueMinute <= trueMinute + 1;
                    // if minute is 60, "overflow" to hours
                    if (trueMinute == 6'd59) begin
                        trueMinute <= 0;
                        trueHour <= trueHour + 1;
                        // if hour is 24, "overflow" to zero (midnight)
                        if (trueHour == 6'd23) begin
                            trueHour <= 0;
                        end
                    end
                end
            end
        end
    end


endmodule