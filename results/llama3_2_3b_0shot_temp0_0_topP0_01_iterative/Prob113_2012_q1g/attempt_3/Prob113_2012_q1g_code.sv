
module TopModule (
  input [4:1] x,
  output logic f
);
always_comb begin
    if (x[3] == 0 && x[4] == 0) begin
        f <= 1;
    end else if ((x[2] == 0 && x[3] == 0 && x[4] == 1) || (x[1] == 0 && x[2] == 0 && x[3] == 1)) begin
        f <= 1;
    end else 
    f <= 0;
end

// VERILOG-EVAL: endmodule not found
