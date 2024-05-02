
module audio(input clk, output reg left_audio_out, right_audio_out);

    localparam MEM_SIZE = 250000;
    reg [7:0] memory[MEM_SIZE-1:0];

    // Load audio samples into memory
    initial begin
        // Generate with `xxd -c1 baby-shark.16khz.wav | awk '{print $2}' | python3 div2.py > baby-shark.16khz.wav.hex`
        $readmemh("C:\Users\seank\Digital_Logic_ECEN2350\Digital_Logic_ECEN2350.srcs\miscfiles\baby-shark.16khz.wav.hex", memory);
    end

    // Need to read samples at ~16kHz
    // Want a ~4MHz clock (pwm clock)
    wire clk4mhz;
    clk_div #(.div(25)) d0(clk, clk4mhz);

    reg [7:0] pwm_count;
    reg [7:0] cur_sample;
    reg [31:0] address;

    always @(posedge clk4mhz) begin
        pwm_count <= pwm_count + 1;

        cur_sample <= memory[address];
        left_audio_out <= (cur_sample > pwm_count);
        right_audio_out <= (cur_sample > pwm_count);

        if (pwm_count == 255) begin
            if (address >= MEM_SIZE) address <= 0;
            else                     address <= address + 1;
        end
    end

endmodule

// Defaults to dividing by 50
module clk_div #(parameter div=50)(input clk, output reg div_clk);

    reg [$clog2(div)-1:0] count;
    
    always @(posedge clk) begin
        if (count >= (div/2-1)) begin
            count <= 0;
            div_clk = ~div_clk;
        end else begin
            count <= count + 1;
        end
    end
endmodule