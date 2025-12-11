
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
assign predict_history = predict_history_reg;

always @(posedge clk or posedge areset) begin
    if (areset)
        predict_history_reg <= 32'b0;
    else if (train_mispredicted)
        predict_history_reg <= { train_history, train_taken };
    else if (predict_valid)
        predict_history_reg <= { predict_history_reg[30:0], predict_taken };
end

logic [31:0] predict_history_reg;

endmodule
