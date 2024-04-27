module bitshifter(input wire [3:0] btn, wire [15:0] sw, output reg [15:0] led);
    
    always @(posedge btn[0]) begin
        led[15] <= sw[15];
        led[14] <= led[15];
        led[13] <= led[14];
        led[12] <= led[13];
        led[11] <= led[12];
        led[10] <= led[11];
        led[9] <= led[10];
        led[8] <= led[9];
        led[7] <= led[8];
        led[6] <= led[7];
        led[5] <= led[6];
        led[4] <= led[5];
        led[3] <= led[4];
        led[2] <= led[3];
        led[1] <= led[2];
        led[0] <= led[1];
    end
endmodule