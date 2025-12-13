
module TopModule (
  input in1,
  input in2,
  output logic out
);
// Combinational logic for a 2‑input NOR gate
always_comb begin
    out = ~(in1 | in2);
end

endmodule
