
module TopModule (
    input wire clk,
    input wire areset,
    input [7:0] d,
    output reg [7:0] q
);

// Define DFF with active high asynchronous reset
logic [1:0] d_ff_ctrl; // 1-bit control signal for the D flip-flop
assign d_ff_ctrl[0] = ~areset; // Active high asynchronous reset
assign d_ff_ctrl[1] = clk; // Positive edge triggered clock

always @(posedge clk or negedge areset) begin
    if (!areset) begin
        q <= 8'b0; // Reset all DFFs to 0 when areset is high
    end else begin
        for (int i = 0; i < 8; i++)
            q[i] <= d[i] & ~d_ff_ctrl[1]; // Update DFFs on positive edge of clk
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
