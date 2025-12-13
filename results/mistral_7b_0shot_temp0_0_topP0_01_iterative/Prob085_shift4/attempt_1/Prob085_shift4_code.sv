
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

always @(posedge clk) begin
  if (!areset) begin
    q <= 4'b0; // Reset the shift register to zero
  end else if (load && ena) begin
    // Both load and ena are asserted, so load the data into the shift register
    q <= data;
  end else if (ena) begin
    // Shift right when only ena is asserted
    q[3:1] <= q[2:0];
    q[0] <= 4'b0; // q[0] is shifted out and disappears
  end
end

// Assign the load and ena signals to active high
assign load_n = !load;
assign ena_n = !ena;

// For convenience, assign a constant zero for the shift register when reset
always @* begin
  if (areset) q <= 4'b0;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
