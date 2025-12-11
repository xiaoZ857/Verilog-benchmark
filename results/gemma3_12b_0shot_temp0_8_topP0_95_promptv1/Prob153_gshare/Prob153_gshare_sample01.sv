
module TopModule (
  input clk,
  input areset,

  input predict_valid,
  input [6:0] predict_pc,
  output predict_taken,
  output [6:0] predict_history,

  input train_valid,
  input train_taken,
  input train_mispredicted,
  input [6:0] train_history,
  input [6:0] train_pc
);
logic [7:0] global_history;
logic [6:0] history_register;
logic [7:0] pht [0:127];
logic [6:0] index;

assign index = train_pc[6:0] ^ global_history[6:0];

always @(posedge clk) begin
  if (areset) begin
    global_history <= 8'b0;
    history_register <= 7'b0;
    for (int i = 0; i < 128; i++) begin
      pht[i] <= 8'b000;
    end
  end else begin
    if (train_valid) begin
      pht[index] <= pht[index] + 2'b1;
      if (train_mispredicted) begin
        pht[index] <= pht[index] - 2'b1;
      end
    end
    if (predict_valid) begin
      history_register <= global_history;
    end
    if (predict_valid) begin
      global_history <= global_history;
    end
  end
end

assign predict_taken = pht[index][1];
assign predict_history = history_register;
endmodule
