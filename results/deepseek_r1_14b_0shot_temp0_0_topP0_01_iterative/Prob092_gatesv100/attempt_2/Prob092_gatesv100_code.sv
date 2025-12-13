
module TopModule (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

// Calculate out_both
for (i = 0; i < 99; i++) begin
  assign out_both[i] = in[i] & in[i+1];
end

// Calculate out_any
for (i = 1; i <= 99; i++) begin
  assign out_any[i] = in[i-1] | in[i];
end

// Calculate out_different with wrapping
for (i = 0; i < 100; i++) begin
  wire left_neighbor;
  if (i == 0) begin
    left_neighbor = in[99];
  end else begin
    left_neighbor = in[i-1];
  end
  assign out_different[i] = (in[i] != left_neighbor);
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
