
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
        counter <= 0;
        is_mispredicted <= 0;
        for (int i = 0; i < 32; i++) history_reg[i] <= 0;
    end

    // Shift the history register on every clock cycle
    if (!counter || !is_mispredicted) begin
        for (int i = 29; i >= 0; i--)
            history_reg[i+1] <= history_reg[i];
        if (predict_valid && !is_mispredicted)
            history_reg[0] <= predict_taken; // Update the youngest branch with the prediction
    end

    // Load the history register when a misprediction occurs
    if (train_mispredicted) begin
        is_mispredicted <= 1;
        for (int i = 30; i < 32; i++)
            history_reg[i] <= train_history[i-1]; // First, load the history before the mispredicted branch
        history_reg[0] <= train_taken; // Load the actual result of the branch
    end
end

// VERILOG-EVAL: endmodule not found
