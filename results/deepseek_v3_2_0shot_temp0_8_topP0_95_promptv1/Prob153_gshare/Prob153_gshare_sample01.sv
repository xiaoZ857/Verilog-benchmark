
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
always @(posedge clk or posedge areset) begin
    if (areset) begin
        predict_history <= 7'b0;
    end else if (train_valid && train_mispredicted) begin
        predict_history <= train_history;
    end else if (predict_valid) begin
        predict_history <= {predict_history[5:0], predict_taken};
    end
end

logic [6:0] pht_index;
logic [1:0] pht_entry;
logic [1:0] pht_next_state;

assign pht_index = predict_pc ^ predict_history;

always_comb begin
    if (train_valid) begin
        if (train_taken) begin
            pht_next_state = (pht_entry == 2'b11) ? 2'b11 : pht_entry + 1;
        end else begin
            pht_next_state = (pht_entry == 2'b00) ? 2'b00 : pht_entry - 1;
        end
    end else begin
        pht_next_state = pht_entry;
    end
end

logic [6:0] train_index;
assign train_index = train_pc ^ train_history;

logic [1:0] pht [0:127];
integer i;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        for (i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01;
        end
    end else if (train_valid) begin
        pht[train_index] <= pht_next_state;
    end
end

always_comb begin
    pht_entry = pht[pht_index];
    predict_taken = pht_entry[1];
end

endmodule
