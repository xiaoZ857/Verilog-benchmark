
module TopModule (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

    // Internal register to hold the previous state of 'in'
    reg [31:0] prev_in;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Synchronous reset: clear the output and previous input state
            out <= 32'b0;
            prev_in <= 32'b0;
        end else begin
            // Capture changes from '1' to '0'
            for (int i = 0; i < 32; i++) begin
                if (prev_in[i] == 1 && in[i] == 0) begin
                    out[i] <= 1'b1;
                end else if (reset) begin
                    // Ensure output is cleared on reset
                    out[i] <= 1'b0;
                end else begin
                    // Retain the current state of 'out' unless changed
                    out[i] <= out[i];
                end
            end

            // Update previous input state for next cycle
            prev_in <= in;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
