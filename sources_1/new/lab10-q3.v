module executer(input mclk, [15:0] sw, output reg [3:0] D0_a, [7:0] D0_seg);

    reg [2:0] trig;
    reg [3:0] swin;
    
    wire clkdiv;
    
    ClkDiv clockinstance(mclk, clkdiv);
    tohex1 hexenc(swin, D0_seg);
    
    always @(posedge(clkdiv))
        begin
        trig = trig + 1;
        
        if (trig == 2'b00) begin
            D0_a = 4'b1110;
            swin = sw[3:0];
        end else if (trig == 2'b01) begin
            D0_a = 4'b1101;
            swin = sw[7:4];
        end else if (trig == 2'b10) begin
            D0_a = 4'b1011;
            swin = sw[11:8];
        end else if (trig == 2'b11) begin
            D0_a = 4'b0111;
            swin = sw[15:12];
        end else
            D0_a = 4'b1111;
    end
endmodule

module ClkDiv (
    input mclk,
    output reg clkdived
    );
	
    localparam terminalcount = (100000 - 1);
    reg [28:0] count;
    wire tc;
    
    assign tc = (count == terminalcount);
    
    always @ (posedge(mclk))
        begin
                if (tc) count <= 0;
                    else count <= count + 1;
        end
    
    always @ (posedge(mclk))
        begin
            if (tc) clkdived = !clkdived;
        end
endmodule

module tohex1(input wire [3:0] sw, output reg [7:0] hexout);
    
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
