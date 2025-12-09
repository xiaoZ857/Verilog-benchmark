
module TopModule (
  input wire a,
  input wire b,
  input wire sel,
  output reg out
);

  // Combinational logic using an always block
  always @(*) begin
    if (sel == 1'b0) begin
      out = a;
    end else begin
      out = b;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
