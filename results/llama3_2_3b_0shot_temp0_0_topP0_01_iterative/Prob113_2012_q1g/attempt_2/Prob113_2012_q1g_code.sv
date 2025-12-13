
module TopModule (
  input [4:1] x,
  output logic f
);
always_comb begin
    if (x == 2'b00) begin
        f <= 0;
    end else if (x == 2'b01) begin
        f <= 1;
    end else if (x == 2'b11) begin
        f <= 1;
    end else if (x == 2'b10) begin
        f <= 0;
    end 
end

// VERILOG-EVAL: endmodule not found
