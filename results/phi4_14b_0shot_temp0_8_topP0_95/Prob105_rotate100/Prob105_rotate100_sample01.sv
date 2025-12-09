
module TopModule (
    input wire clk,
    input wire load,
    input wire [1:0] ena,
    input wire [99:0] data,
    output reg [99:0] q
);

    // On every positive edge of the clock, determine the next state.
    always @(posedge clk) begin
        if (load) begin
            // Synchronous load operation
            q <= data;  // Load the data into the register directly
        end else begin
            case (ena)
                2'b01: begin
                    // Rotate right by one bit
                    q[99] <= q[0];       // The leftmost bit becomes the rightmost
                    q[98:0] <= q[99:1];  // Shift all bits to the right
                end

                2'b10: begin
                    // Rotate left by one bit
                    q[0] <= q[99];       // The rightmost bit becomes the leftmost
                    q[99:1] <= q[98:0];  // Shift all bits to the left
                end

                // If ena is 2'b00 or 2'b11, do nothing (no rotation)

                default: begin
                    // Default case does nothing if no valid ena code is received
                end
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
