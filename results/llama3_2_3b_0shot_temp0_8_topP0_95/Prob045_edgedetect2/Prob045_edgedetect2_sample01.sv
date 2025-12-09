
// Detects changes (edges) in an 8-bit vector on each clock cycle.
//
// The output bit is set the next cycle after a transition from 0 to 1 or 1 to 0.

module TopModule (
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

    // Internal registers and signals
    reg [7:0] prev_in;
    wire [7:0] any_edge;

    // Register the previous input value.
    assign prev_in = in;

    // The next edge will be detected on the rising or falling edge of this clock signal.
    always @(posedge clk) begin
        // Check for a transition from 0 to 1 or 1 to 0 between two consecutive values.
        any_edge[0] <= !prev_in[0];
        any_edge[1] <= !prev_in[1];
        any_edge[2] <= !prev_in[2];
        any_edge[3] <= !prev_in[3];
        any_edge[4] <= !prev_in[4];
        any_edge[5] <= !prev_in[5];
        any_edge[6] <= !prev_in[6];
        any_edge[7] <= !prev_in[7];

        // Set the output value on the next clock cycle.
        assign any_edge = {any_edge, prev_in};
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
