
// Moved timescale directive outside of module definition
`timescale 1ns / 1ps

module TopModule (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

generate
    for (genvar i = 0; i < 32; i++) begin : bit_gen
        // Detect falling edge (1 to 0) on each bit
        wire prev_in_i;
        DFFE prev_in(
            .clk(clk),
            .rst(reset),
            .d(in[i]),
            .q(prev_in_i)
        );

        reg edge_detect;
        always @(posedge clk) begin
            if (reset) begin
                edge_detect <= 0;
            end else begin
                if (prev_in_i && ~in[i]) begin
                    edge_detect <= 1;
                end else if (out[i]) begin
                    // Keep the output high until reset
                    edge_detect <= 1;
                end else begin
                    edge_detect <= 0;
                end
            end
        end

        always @(posedge clk) begin
            if (reset) begin
                out[i] <= 0;
            end else if (edge_detect) begin
                out[i] <= 1;
            end
        end
    end
endgenerate

endmodule

// VERILOG-EVAL: errant inclusion of module definition
