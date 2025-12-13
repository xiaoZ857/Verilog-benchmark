
module TopModule (
  input clk,
  input resetn,    // Active-low synchronous reset
  input in,
  output out
);

  reg [3:0] shift_reg; // 4-bit register to hold the shifted values

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      // Synchronous active-low reset
      shift_reg <= 4'b0000;
    end else begin
      // Shift operation on positive edge of clock
      shift_reg <= {shift_reg[2:0], in}; // Shift left and insert new input at LSB
    end
  end

  assign out = shift_reg[3]; // Output from the last stage

endmodule

// VERILOG-EVAL: errant inclusion of module definition
