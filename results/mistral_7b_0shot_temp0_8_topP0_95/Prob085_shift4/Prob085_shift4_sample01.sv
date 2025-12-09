
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

reg [3:0] temp; // Temporary storage for shift operation
always @(posedge clk) begin
  if (!areset) begin
    temp <= 4'b0000; // Resetting the shift register to zero
  end else if (ena && load) begin
    temp <= data; // Loading data into the shift register
  end else begin
    temp[3:1] <= q[2:0]; // Shifting the contents of the register to the right
    temp[0] <= 4'b0; // Setting q[0] to zero
  end
  q <= temp; // Assigning the new values of temp to the shift register output (q)
end

// Verilog code for test bench is not included, but it would be used to simulate this module.

endmodule

// VERILOG-EVAL: errant inclusion of module definition
