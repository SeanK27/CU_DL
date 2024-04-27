module synchadder(input wire [3:0] btn, wire [15:0] sw, output [15:0] led);
    
    reg [15:0] A;
    reg [15:0] B;
    
    always @(posedge btn[0]) begin
        A <= sw;
    end
    
    always @(posedge btn[1]) begin
        B <= sw;
    end
    
    assign led = A + B;
    
endmodule