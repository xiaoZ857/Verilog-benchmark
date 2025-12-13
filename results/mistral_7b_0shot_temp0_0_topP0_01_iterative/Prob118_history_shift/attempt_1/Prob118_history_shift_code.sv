
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

reg [31:0] history_reg [32]; // 32-bit shift register for the branch history
reg counter = 0; // Counter to keep track of the current position in the history register
reg is_mispredicted = 0; // Flag to indicate if a misprediction has occurred

always @(posedge clk) begin
    if (areset) begin
        counter <= 0;
        is_mispredicted <= 0;
        for (int i = 0; i < 32; i++) history_reg[i] <= 0;
    end

    // Shift the history register on every clock cycle
    if (!counter || !is_mispredicted) begin
        for (int i = 31; i > 0; i--)
            history_reg[i] <= history_reg[i-1];
        if (predict_valid && !is_mispredicted)
            history_reg[0] <= predict_taken; // Update the youngest branch with the prediction
    end

    // Load the history register when a misprediction occurs
    if (train_mispredicted) begin
        is_mispredicted <= 1;
        for (int i = 31; i > 0; i--)
            history_reg[i] <= train_history[i]; // Load the history before the mispredicted branch
        history_reg[0] <= train_taken; // Load the actual result of the branch
    end
end

assign predict_history = history_reg[counter]; // Output the current state of the history register

endmodule

// VERILOG-EVAL: errant inclusion of module definition
