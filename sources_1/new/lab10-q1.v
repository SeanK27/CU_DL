`timescale 1ms / 1ps

module ClkDivider (
    input mclk,
    output reg [15:0] led
    );
	
    localparam terminalcount = (50000000 - 1);
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
            if (tc) led[0] = !led[0];
        end
endmodule