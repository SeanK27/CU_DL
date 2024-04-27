`timescale 1ns / 1ps

module hexEncode16(input wire [15:0] sw, wire [3:0] btn, output wire [7:0] D1_seg, wire [3:0] D1_a, [15:0] led);
    
    wire [7:0] output1, output2, output3, output4;
    
    assign led=sw;
    
    assign D1_a = 
    (btn == 4'b0001) ? 4'b1110 :
    (btn == 4'b0010) ? 4'b1101 :
    (btn == 4'b0100) ? 4'b1011 :
    (btn == 4'b1000) ? 4'b0111 : 4'b1111;
    
    tohex out1(sw[3:0], output1);
    tohex out2(sw[7:4], output2);
    tohex out3(sw[11:8], output3);
    tohex out4(sw[15:12], output4);
    
    assign D1_seg = 
    (btn == 4'b0001) ? output1 :
    (btn == 4'b0010) ? output2 :
    (btn == 4'b0100) ? output3 :
    (btn == 4'b1000) ? output4 : 8'b11111111;
    
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
