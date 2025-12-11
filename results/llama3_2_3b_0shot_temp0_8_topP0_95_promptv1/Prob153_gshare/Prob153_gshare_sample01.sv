
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
assign predict_taken = (train_valid == 1) ? train_taken : ((predict_valid == 1) && !train_mispredicted ? predict_taken : (predict_valid == 1));

always @(posedge clk) begin
    assign predict_history = {predict_history[6],predict_history[5],predict_history[4],predict_history[3],predict_history[2],predict_history[1],a^b};
end

always @(posedge clk) begin
    if (areset)
        q <= 1'b0;
    else
        q <= d;
end

assign out = c ^ d;

assign in = a & b;

assign train_history[6] = xor(train_history[6],a);
assign train_history[5] = xor(train_history[5],b);
assign train_history[4] = xor(train_history[4],c);
assign train_history[3] = xor(train_history[3],d);

assign train_taken[6] = xor(train_taken[6],train_mispredicted);
assign train_taken[5] = xor(train_taken[5],a);
assign train_taken[4] = xor(train_taken[4],b);
assign train_taken[3] = xor(train_taken[3],c);
assign train_taken[2] = xor(train_taken[2],d);

assign train_pc[6] = predict_history;

endmodule
