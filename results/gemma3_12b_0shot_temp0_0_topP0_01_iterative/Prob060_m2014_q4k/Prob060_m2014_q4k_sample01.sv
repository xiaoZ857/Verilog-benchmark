
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
  // Internal signals for the shift register
  reg [3:0] shift_reg;

  // Assign the output to the most significant bit of the shift register
  assign out = shift_reg[3];

  // Shift register logic
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      shift_reg <= 0; // Reset to 0 when resetn is low
    end else begin
      shift_reg <= {shift_reg[2:0], in}; // Shift register logic
    end
  end

// VERILOG-EVAL: endmodule not found
