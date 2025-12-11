
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
    end else begin
        if (train_valid && train_mispredicted) begin
            predict_history <= train_history;
        end else if (predict_valid) begin
            predict_history <= {predict_history[5:0], predict_taken};
        end
    end
end

wire [6:0] predict_index = predict_pc ^ predict_history;
wire [6:0] train_index = train_pc ^ train_history;

reg [1:0] pht [0:127];
integer i;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        for (i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01;
        end
    end else if (train_valid) begin
        case (pht[train_index])
            2'b00: pht[train_index] <= train_taken ? 2'b01 : 2'b00;
            2'b01: pht[train_index] <= train_taken ? 2'b10 : 2'b00;
            2'b10: pht[train_index] <= train_taken ? 2'b11 : 2'b01;
            2'b11: pht[train_index] <= train_taken ? 2'b11 : 2'b10;
        endcase
    end
end

assign predict_taken = pht[predict_index][1];

endmodule
