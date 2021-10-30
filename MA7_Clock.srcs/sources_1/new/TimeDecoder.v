//////////////////////////////////////////////////////////////////////////////////
// File: TimeDecoder.v
// Author: Andrew Jones (https://github.com/AndrewJones-PSU)
// Creation Date: 6/9/2021
// Target Devices: Mimas A7 Revision V3 Development Board 
// 
// Description: This module takes in the value from ClockStateStorage and turns
//     it into decimal segments for the sevenSegmentDisplayDecoder to
//     interpret. Effectively, this is a specialized binary to decimal
//     representation converter.
//////////////////////////////////////////////////////////////////////////////////


module TimeDecoder(
    input [5:0] hour,
    input [5:0] minute,
    
    output [15:0] value
);
    reg [3:0] hourTopDigit, hourBotDigit, minuteTopDigit, minuteBotDigit;
    assign value = {hourTopDigit, hourBotDigit, minuteTopDigit, minuteBotDigit};
    
    integer i;
    always @(*) begin
        hourTopDigit = 4'b0;
        hourBotDigit = 4'b0;
        minuteTopDigit = 4'b0;
        minuteBotDigit = 4'b0;
        
        for (i = 5; i >= 0; i = i - 1)
        begin
            if (hourTopDigit >= 5)
                hourTopDigit = hourTopDigit + 3;
            if (hourBotDigit >= 5)
                hourBotDigit = hourBotDigit + 3;
            if (minuteTopDigit >= 5)
                minuteTopDigit = minuteTopDigit + 3;
            if (minuteBotDigit >= 5)
                minuteBotDigit = minuteBotDigit + 3;
            
            hourTopDigit = hourTopDigit << 1;
            hourTopDigit[0] = hourBotDigit[3];
            hourBotDigit = hourBotDigit << 1;
            hourBotDigit[0] = hour[i];
            
            minuteTopDigit = minuteTopDigit << 1;
            minuteTopDigit[0] = minuteBotDigit[3];
            minuteBotDigit = minuteBotDigit << 1;
            minuteBotDigit[0] = minute[i];
        end
    end
endmodule
