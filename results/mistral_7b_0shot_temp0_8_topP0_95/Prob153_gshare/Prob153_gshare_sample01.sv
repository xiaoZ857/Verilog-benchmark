
module TopModule (
  input clk,
  input areset,

  input predict_valid,
  input [6:0] predict_pc,
  output reg predict_taken,
  output reg [6:0] predict_history,

  input train_valid,
  input train_taken,
  input train_mispredicted,
  input [6:0] train_history,
  input [6:0] train_pc,

  output reg train_enable
);

reg [127:0] PHT; // Pattern History Table (128-entry)
reg history_reg [6:0]; // Global branch history register

always @(posedge clk or negedge areset) begin
  if (!areset) begin
    PHT <= 32'b0;
    history_reg <= 7'b0;
  end
end

always @(posedge clk) begin
  if (train_valid && train_enable) begin // Train the branch predictor
    PHT[train_pc] <= {train_taken, train_history} + (train_mispredicted ? 1'b1 : 1'b0);
    history_reg <= train_history;
  end
end

always @(posedge clk) begin // Predict branch direction and update history register
  if (predict_valid) begin
    predict_taken <= PHT[predict_pc][0];
    predict_history <= history_reg + {predict_taken, 1'b0};
    history_reg <= predict_taken ? history_reg + 1 : history_reg - 1;
  end
end

assign train_enable = (predict_valid && !train_valid); // Training only when prediction is requested but not training

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
