
module TopModule (
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q
);

    always @(posedge clk) begin
        if (load) begin
            // Load the given state into q when `load` is asserted
            q <= data;
        end else begin
            // Update each cell according to Rule 90
            reg [511:0] next_state;

            for (int i = 0; i < 512; i = i + 1) begin
                // Calculate the next state of each cell using XOR
                // Assume q[-1] and q[512] are zero as per the specification
                next_state[i] <= q[i-1] ^ q[i+1];
            end

            // Update q to the new state after computing all cells' next states
            q <= next_state;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
