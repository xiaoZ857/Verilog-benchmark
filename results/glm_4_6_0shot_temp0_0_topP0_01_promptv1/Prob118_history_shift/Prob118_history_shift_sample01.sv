
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
    if (areset) begin
        predict_history <= 32'b0;
    end else begin
        if (train_mispredicted) begin
            // Misprediction takes precedence
            predict_history <= {train_history[31:1], train_taken};
        end else if (predict_valid) begin
            // Normal prediction - shift in new prediction
            predict_history <= {predict_history[31:1], predict_taken};
        end
    end
end
endmodule
