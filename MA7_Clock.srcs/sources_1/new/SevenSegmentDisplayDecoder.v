//////////////////////////////////////////////////////////////////////////////////
// File: SevenSegmentDisplayDecoder.v
// Author: Andrew Jones (https://github.com/AndrewJones-PSU)
// Creation Date: 6/9/2021
// Target Devices: Mimas A7 Revision V3 Development Board 
// 
// Description: This module takes in a 16-bit value and generates the
//     appropriate signals to output said value in hexadecimal to the
//     Mimas A7's seven-segment display. This module uses the 100MHz
//     clock signal from the Mimas A7 to swap between outputting to
//     each of the four digits.
//////////////////////////////////////////////////////////////////////////////////

module SevenSegmentDisplayDecoder(
    input clk, // 100 MHz Onboard Clock
    input [15:0] value, // integer value to be displayed
    input [3:0] decimalPoint, // optional decimal point writing, high indicates decimal point should be on

    output [7:0] displayOut, // should be connected to pins P5, M6, L6, L5, M5, M3, N4, and P4 on the Mimas A7 respectively
    output reg [3:0] enableOut // should be connected to pins N3, R1, P1, and L4 respectively
);
    reg [6:0] displayOutNoDecimal;
    reg [1:0] enableCounter;
    reg [3:0] activeValue;
    reg [17:0] accessCounter;
    reg activeDecimalValue;
    
    // add decimal point to the output
    assign displayOut = {displayOutNoDecimal[6:4], activeDecimalValue, displayOutNoDecimal[3:0]};

    // initialize default states to not output anything
    initial begin
        displayOutNoDecimal = 7'b1111111;
        enableOut = 4'b1111;
        accessCounter = 0;
    end

    always @(posedge clk) begin
        accessCounter <= accessCounter + 1;
        if(accessCounter == 0) // only true after accessCounter overflows
        begin
            enableCounter <= enableCounter + 1;
            case(enableCounter) // this could be simplified a lot
                2'b00: begin
                    enableOut <= 4'b0111;
                    activeValue <= value[3:0];
                    activeDecimalValue <= ~decimalPoint[3];
                end
                2'b01: begin
                    enableOut <= 4'b1110;
                    activeValue <= value[7:4];
                    activeDecimalValue <= ~decimalPoint[0];
                end
                2'b10: begin
                    enableOut <= 4'b1101;
                    activeValue <= value[11:8];
                    activeDecimalValue <= ~decimalPoint[1];
                end
                2'b11: begin
                    enableOut <= 4'b1011;
                    activeValue <= value[15:12];
                    activeDecimalValue <= ~decimalPoint[2];
                end
            endcase

            case(activeValue) // get the correct hexadecimal value to display
                4'b0000: displayOutNoDecimal <= 7'b0000001; // 0
                4'b0001: displayOutNoDecimal <= 7'b1100111; // 1
                4'b0010: displayOutNoDecimal <= 7'b0010010; // 2
                4'b0011: displayOutNoDecimal <= 7'b1000010; // 3
                4'b0100: displayOutNoDecimal <= 7'b1100100; // 4
                4'b0101: displayOutNoDecimal <= 7'b1001000; // 5
                4'b0110: displayOutNoDecimal <= 7'b0001000; // 6
                4'b0111: displayOutNoDecimal <= 7'b1100011; // 7
                4'b1000: displayOutNoDecimal <= 7'b0000000; // 8
                4'b1001: displayOutNoDecimal <= 7'b1000000; // 9
                4'b1010: displayOutNoDecimal <= 7'b0100000; // A
                4'b1011: displayOutNoDecimal <= 7'b0001100; // b
                4'b1100: displayOutNoDecimal <= 7'b0011001; // C
                4'b1101: displayOutNoDecimal <= 7'b0000110; // d
                4'b1110: displayOutNoDecimal <= 7'b0011000; // E
                4'b1111: displayOutNoDecimal <= 7'b0111000; // F
            endcase
        end
    end
endmodule