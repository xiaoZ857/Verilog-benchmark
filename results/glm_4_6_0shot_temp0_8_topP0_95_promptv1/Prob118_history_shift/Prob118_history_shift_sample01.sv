
module TopModule (
  input clk,
  input areset,
  input predict_valid,
  input predict_taken,
  output logic [31:0] predict_history,

  input train_mispredicted,
  input train_taken,
  input [31:0] train_history
);

always @(posedge clk or posedge areset) begin
    if (ares

// VERILOG-EVAL: endmodule not found
