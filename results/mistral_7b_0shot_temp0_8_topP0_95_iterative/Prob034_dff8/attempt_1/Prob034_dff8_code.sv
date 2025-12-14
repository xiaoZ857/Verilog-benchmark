
module TopModule (
  input wire clk,
  input [7:0] d,
  output reg [7:0] q
);

reg [7:0] dff_regs [7:0]; // Declare array of DFF registers

always @(posedge clk) begin
  dff_regs <= d; // Assign new input data to the DFF registers on every posedge clock
end

assign q = dff_regs; // Assign the value of DFF registers as output q

endmodule

// VERILOG-EVAL: errant inclusion of module definition
