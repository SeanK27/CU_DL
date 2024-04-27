module counter1(input mclk, [3:0] btn, output reg [3:0] D0_a, [7:0] D0_seg);

    wire clkdivstoppable;
    
    reg [3:0] swin;
    
    wire [15:0] outwire;
    
    reg [2:0] trig;
    
    reg variablename;
    
    ClkDiv1011 clockinstance(mclk, variablename, clkdivstoppable);
    ClkDiv101 clockinstance1(mclk, clkdiv);
    tohex2 hexenc1(swin, D0_seg);
    setdigits1 s1(clkdivstoppable, btn, outwire);
    
    always @(posedge btn[1]) begin
        if (btn[1] == 1 && variablename == 1) begin
            variablename <= 0;
        end
        if (btn[1] == 1 && variablename == 0) begin
            variablename <= 1;
        end
    end
    
    always @(posedge clkdiv)
        begin
        
        trig <= trig + 1;
        
        if (trig == 2'b00) begin
            D0_a = 4'b1110;
            swin = outwire[3:0];
        end else if (trig == 2'b01) begin
            D0_a = 4'b1101;
            swin = outwire[7:4];
        end else if (trig == 2'b10) begin
            D0_a = 4'b1011;
            swin = outwire[11:8];
        end else if (trig == 2'b11) begin
            D0_a = 4'b0111;
            swin = outwire[15:12];
        end else
            D0_a = 4'b1111;
    end
endmodule

module setdigits1(input clook, [3:0] button1, output [15:0] hexout1);
    
    reg [3:0] hex1;
    reg [3:0] hex2;
    reg [3:0] hex3;
    reg [3:0] hex4;
    
    always @(posedge clook, posedge button1[0]) begin
        if (button1[0] == 1) begin    
        
            hex1 <= 4'b0000;
            hex2 <= 4'b0000;
            hex3 <= 4'b0000;
            hex4 <= 4'b0000;
        
        end
        else begin
    
            hex1 <= hex1 + 1;
            
            if (hex1 == 4'b1010) begin
                hex2 <= hex2 + 1;
                hex1 <= 4'b0000;
            end
            
            if (hex2 == 4'b1010) begin
                hex3 <= hex3 + 1;
                hex2 <= 4'b0000;
            end
            
            if (hex3 == 4'b1010) begin
                hex4 <= hex4 + 1;
                hex3 <= 4'b0000;
            end
            
            if (hex4 == 4'b1010) begin
                hex4 <= 4'b0000;
                hex3 <= 4'b0000;
                hex2 <= 4'b0000;
                hex1 <= 4'b0000;
            end
        end
    end
    assign hexout1 = {hex4, hex3, hex2, hex1};
    
endmodule

module ClkDiv101 (input cloook, output reg clkdived);
	
    localparam terminalcount = (50000 - 1);
    reg [32:0] count;
    wire tc;
    
    assign tc = (count == terminalcount);
    
    always @ (posedge(cloook))
        begin
                if (tc) count <= 0;
                    else count <= count + 1;
        end
    
    always @ (posedge(cloook))
        begin
            if (tc) clkdived = !clkdived;
        end
endmodule

module ClkDiv1011 (input cloook, varin, output reg clkdived);
	
    localparam terminalcount = (50000 - 1);
    reg [32:0] count;
    wire tc;
    
    assign tc = (count == terminalcount);
    
    always @ (posedge(cloook))
        begin
                if (tc) count <= 0;
                    else count <= count + 1;
        end
    
    always @ (posedge(cloook))
        begin
            if (tc && varin) clkdived = !clkdived;
        end
endmodule


module tohex21(input [3:0] dispin, output reg [7:0] hexout);
    
    always @(*) begin
    case (dispin)
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
