
module TopModule (
    input wire clk,
    input wire load,
    input wire [1:0] ena,
    input wire [99:0] data,
    output reg [99:0] q
);

    // Always block triggered on positive edge of clock
    always @(posedge clk) begin
        if (load) begin
            // Synchronous load operation
            q <= data;
        end else begin
            case (ena)
                2'b01: begin
                    // Rotate right by one bit
                    q[99] <= q[0];
                    q[98:0] <= q[99:1];
                end
                2'b10: begin
                    // Rotate left by one bit
                    q[0] <= q[99];
                    q[1:99] <= q[98:0];
                end
                default: begin
                    // No rotation for ena = 2'b00 or 2'b11
                    q <= q;
                end
            endcase
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
