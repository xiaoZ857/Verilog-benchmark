
module TopModule (
  input clk,
  input resetn,
  input in,
  output out
);
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        // Synchronous active-low reset: Reset all bits in the shift register and output
        shift_reg <= 4'b0000;
        out <= 1'b0; // Ensure 'out' is known post-reset, consistent with a clear state
    end else begin
        // Shift left operation and loading new input to the least significant bit (LSB)
        shift_reg <= {shift_reg[2:0], in}; // Correctly shift left by moving bits [2:0] and adding 'in' at LSB

        // Connect the output of the last flip-flop (MSB) to 'out'
        out <= shift_reg[3];
    end
end

// VERILOG-EVAL: endmodule not found
