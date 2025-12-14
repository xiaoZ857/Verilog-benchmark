
module TopModule (
  input clk,
  input [7:0] d,
  input reset,
  output reg [7:0] q
);
always @(posedge clk) begin
    if (reset == 1'b1) begin // Reset condition met when synchronous reset is high
        q <= {0[0:6]}; // Set output to zero for all bits in case of synchronous reset
    } else begin // Writing data into DFFs
        q <= d; // Assign input data to the output
    end
endmodule
