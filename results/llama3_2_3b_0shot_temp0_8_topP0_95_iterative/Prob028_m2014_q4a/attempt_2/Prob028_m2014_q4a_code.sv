
module TopModule (
  input d,
  input ena,
  output logic q
);

always @(posedge clk) begin
    if (ena == 1'b1) begin
        q <= d;
    else 
        q <= q && d; // Metastable mode
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
