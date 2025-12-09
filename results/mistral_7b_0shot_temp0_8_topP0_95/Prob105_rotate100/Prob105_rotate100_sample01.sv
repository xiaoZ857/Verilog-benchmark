
module TopModule (
  input clk,
  input load,
  input [1:0] ena,
  input [99:0] data,
  output reg [99:0] q
);

reg [99:0] shift_register;

always @(posedge clk) begin
    if (load)
        shift_register <= data;
    else if (ena == 2'b01) // Right rotation
        shift_register <= {shift_register[98:0], shift_register[99]};
    else if (ena == 2'b10) // Left rotation
        shift_register <= {shift_register[99], shift_register[0:98]};
    assign q = shift_register;
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
