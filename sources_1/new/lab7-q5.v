`timescale 1ns / 1ps

module signedout(input wire [3:0] sw, output wire [7:0] D1_seg, wire [3:0] D1_a, wire [7:0] D0_seg, wire [3:0] D0_a);
    wire [3:0] twos;
    wire isnegative;
    
    assign D0_a = 4'b1110;
    assign D1_a = 4'b1110;
    
    assign isnegative = sw >> 3;    
    
    assign twos = (isnegative) ? (~sw + 1) : (sw);
    
    assign D0_seg = (isnegative) ? (8'b10111111) : (8'b11111111);
    
    tohex out1(twos, D1_seg);
    
endmodule

module tohex(input wire [3:0] sw, output reg [7:0] hexout);
    
    always @(*) begin
    case (sw)
      4'b0000: hexout = 8'b11000000;  // 0 
      4'b0001: hexout = 8'b11111001;  // 1 
      4'b0010: hexout = 8'b10100100;  // 2 
      4'b0011: hexout = 8'b10110000;  // 3 
      4'b0100: hexout = 8'b10011001;  // 4 
      4'b0101: hexout = 8'b10010010;  // 5 
      4'b0110: hexout = 8'b10000010;  // 6 
      4'b0111: hexout = 8'b11111000;  // 7 
      4'b1000: hexout = 8'b10000000;  // 8 
      4'b1001: hexout = 8'b10010000;  // 9 
      4'b1010: hexout = 8'b10001000;  // A 
      4'b1011: hexout = 8'b10000011;  // B 
      4'b1100: hexout = 8'b11000110;  // C 
      4'b1101: hexout = 8'b10100001;  // D 
      4'b1110: hexout = 8'b10000110;  // E 
      4'b1111: hexout = 8'b10001110;  // F 
      default: hexout = 8'b11111111;
    endcase
  end
endmodule