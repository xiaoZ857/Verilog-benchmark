
module TopModule (
  input [1:0] A,
  input [1:0] B,
  output z
);
always @(posedge clk) begin
  if ((A[1] == B[1]) && (A[0] == B[0])) begin
    z <= 1'b1;
  end else begin
    z <= 1'b0;
  end
end

// Add clock input and synchronization if needed (Assumed positive-edge triggered for this example)
input clk;
always @(posedge clk) $finish;

// timescale directive should be outside of the module definition
`timescale 1ns / 1ps

endmodule
