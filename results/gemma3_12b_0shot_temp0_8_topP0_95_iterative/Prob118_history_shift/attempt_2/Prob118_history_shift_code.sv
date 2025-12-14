
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
  logic [31:0] history_reg;

  always_ff @(posedge clk, posedge areset) begin
    if (areset) begin
      history_reg <= 0;
    end else begin
      if (predict_valid) begin
        // Shift in the prediction
        history_reg <= {predict_taken, history_reg[31:1]};
      end else if (train_mispredicted) begin
        // Load the mispredicted history
        history_reg <= {train_history, train_taken};
      end
    end
  end

  assign predict_history = history_reg;

// VERILOG-EVAL: endmodule not found
