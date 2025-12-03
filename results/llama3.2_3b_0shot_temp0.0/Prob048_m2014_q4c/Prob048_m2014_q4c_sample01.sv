

module TopModule (
  input clk,
  input d,
  input r,
  output logic q
);

always @(posedge clk) begin
    if(r == 1'b1) 
        q <= 1'b0;
    else if(d == 1'b1)
        q <= d;
end

assign q = ~q & r | q & d;

// VERILOG-EVAL: endmodule not found
