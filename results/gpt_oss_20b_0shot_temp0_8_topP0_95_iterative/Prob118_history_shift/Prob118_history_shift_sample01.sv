
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
  // Global history shift register with rollback capability
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      // Asynchronous reset: clear history
      predict_history <= 32'b0;
    end
    else if (train_mispredicted) begin
      // Misprediction: load corrected history
      // train_history holds the history *before* the mispredicted branch
      // Shift left and insert the actual taken result as the newest bit
      predict_history <= {train_history[30:0], train_taken};
    end
    else if (predict_valid) begin
      // Prediction: shift in predicted taken bit
      // The newest bit goes into LSB (predict_history[0

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
