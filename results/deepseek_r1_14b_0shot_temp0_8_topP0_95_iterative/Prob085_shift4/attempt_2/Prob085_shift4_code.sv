
`timescale 1ns / 1ps

module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

always @(posedge clk) begin
    if (areset) begin
        q <= 4'b0;
    else begin
        if (load) begin
            q <= data;
        end else if (ena) begin
            q[3] <= 1'b0; 
            q[2:0] <= q[3:1]; // Right shift and fill with zeros on the left
        end
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
