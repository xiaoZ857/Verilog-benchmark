
module TopModule (
  input in1,
  input in2,
  input in3,
  output logic out
);
 ```verilog
always @(posedge clk) begin
    logic [1:0] xnor_output;
    assign xnor_output = {in1 ^ in2, ~(in1 ^ in2)}; // XNOR gate
    out = xnor_output[0] ^ in3; // XOR gate
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
