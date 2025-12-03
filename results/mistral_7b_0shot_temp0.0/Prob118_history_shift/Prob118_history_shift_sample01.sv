

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

reg [31:0] history_reg [31:0];
reg counter = 0;
reg flush = 0;

always @(posedge clk) begin
    if (areset) begin
        counter <= 0;
        flush <= 0;
        history_reg <= 0;
    end else if (predict_valid && !flush) begin
        history_reg[counter] <= predict_taken;
        counter <= counter + 1;
    end else if (train_mispredicted) begin
        flush <= 1;
        history_reg <= train_history;
    end
end

assign predict_history = history_reg[31 - counter];

// VERILOG-EVAL: endmodule not found
