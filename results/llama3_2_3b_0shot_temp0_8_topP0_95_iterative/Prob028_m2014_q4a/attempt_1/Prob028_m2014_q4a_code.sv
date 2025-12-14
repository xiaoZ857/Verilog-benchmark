
module TopModule (
  input d,
  input ena,
  output logic q
);

always @(posedge clk) begin
    if (ena == 1'b1) begin
        q <= d;
    else if (q != d) begin // Metastable mode
        q <= q;
    end
end

endmodule

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
