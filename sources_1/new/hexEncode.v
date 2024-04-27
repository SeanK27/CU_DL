`timescale 1ns / 1ps

module hexEncode(input wire [3:0] sw, output reg [7:0] D0_seg, wire [3:0] D0_a, wire [3:0] D1_a);

    assign D0_a = 4'b0111;
    assign D1_a = 4'b0111;
    
    always @(*) begin
    case (sw)
      4'b0000: D0_seg = 8'b11000000;  // 0 
      4'b0001: D0_seg = 8'b11111001;  // 1 
      4'b0010: D0_seg = 8'b10100100;  // 2 
      4'b0011: D0_seg = 8'b10110000;  // 3 
      4'b0100: D0_seg = 8'b10011001;  // 4 
      4'b0101: D0_seg = 8'b10010010;  // 5 
      4'b0110: D0_seg = 8'b10000010;  // 6 
      4'b0111: D0_seg = 8'b11111000;  // 7 
      4'b1000: D0_seg = 8'b10000000;  // 8 
      4'b1001: D0_seg = 8'b10010000;  // 9 
      4'b1010: D0_seg = 8'b10001000;  // A 
      4'b1011: D0_seg = 8'b10000011;  // B 
      4'b1100: D0_seg = 8'b11000110;  // C 
      4'b1101: D0_seg = 8'b10100001;  // D 
      4'b1110: D0_seg = 8'b10000110;  // E 
      4'b1111: D0_seg = 8'b10001110;  // F 
      default: D0_seg = 8'b00000000;
    endcase
  end

endmodule
