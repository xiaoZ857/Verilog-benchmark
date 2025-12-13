
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
always @(posedge clk or negedge resetn) begin
  if (!resetn) begin
    // Synchronous active-low reset
    shift_reg <= 4'b0000; // Ensure all bits are explicitly set to zero
  end else begin
    // Shift operation on positive edge of clock
    shift_reg <= {shift_reg[2:0], in}; // Shift left and insert new input at LSB
  end
end

assign out = shift_reg[3]; // Output from the last stage

// VERILOG-EVAL: endmodule not found
