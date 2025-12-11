
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
 ```verilog
reg [31:0] history_reg [32-1:0];
always @(posedge clk or negedge areset) begin
    if (!areset) begin
        for (int i = 0; i < 32; i++)
            history_reg[i] <= 0;
    end
    else if (predict_valid && !train_mispredicted) begin
        history_reg[0] <= predict_taken;
        for (int i = 1; i < 32; i++)
            history_reg[i] <= history_reg[i-1];
    end
    else if (train_mispredicted) begin
        for (int i = 0; i < 32; i++)
            history_reg[i] <= train_history[i];
    end
end
assign predict_history = history_reg[31:0];
endmodule

// VERILOG-EVAL: abnormal backticks count
