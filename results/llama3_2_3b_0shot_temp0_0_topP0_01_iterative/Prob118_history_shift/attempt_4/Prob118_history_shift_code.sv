
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
always @(posedge clk) begin
    if (areset) begin
        history_counter <= 0;
        train_history_register <= 0;
    end else if (predict_valid && !train_mispredicted) begin
        // Shift in predict_taken from the LSB side to update the branch history for the predicted branch.
        history_counter[31] <= predict_taken;
        history_counter[30:0] <= history_counter[31:0];
    end else if (train_mispredicted && !predict_valid) begin
        // Load the branch history register with the history after the completion of the mispredicted branch.
        train_history_register <= train_history;
    end else if (train_taken && !predict_valid) begin
        // Shift in train_taken from the LSB side to update the branch history for the taken branch.
        history_counter[31] <= train_taken;
        history_counter[30:0] <= history_counter[31:0];
    end else if (!predict_valid && !train_mispredicted) begin
        // Roll back state in response to a pipeline flush caused by a branch misprediction.
        history_counter <= 0;
    end else if (train_taken && predict_valid) begin
        // Shift in train_taken from the LSB side to update the branch history for the taken branch.
        history_counter[31] <= train_taken;
        history_counter[30:0] <= history_counter[31:0];
    end else if (!predict_valid && train_mispredicted) begin
        // Load the branch history register with the history after the completion of the mispredicted branch.
        train_history_register <= train_history;
    end
endmodule
