
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
  // 32-bit global history shift register
  // predict_history[0] is the direction of the youngest branch
  // When predicting, shift in predict_taken from LSB side
  // When mispredicted, load with train_history[30:0] concatenated with train_taken
  
  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      // Asynchronous reset - clear history to zero
      predict_history <= 32'b0;
    end else if (train_mispredicted) begin
      // Misprediction takes precedence
      // Load history after completion of mispredicted branch:
      // history before mispredicted branch (train_history[30:0]) + actual result (train_taken)
      predict_history <= {train_history[30:0], train_taken};
    end else if (predict_valid) begin
      // Normal prediction - shift in new prediction from LSB
      predict_history <= {predict_history[30:1], predict_taken};
    end
    // If neither predict_valid nor train_mispredicted, maintain current value
  end
endmodule

// VERILOG-EVAL: errant inclusion of module definition
