
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
 ```verilog
always @(posedge clk or negedge areset) begin
    if (!areset) begin
        predict_taken <= 1'b0;
        predict_history <= 7'b0;
    end else begin
        always @* begin
            logic [6:0] index, pht[0:127][0:1];
            reg [6:0] history [0:6];

            assign predict_taken = history[predict_pc];
            assign predict_history = history[predict_pc + 7];

            always @(posedge clk) begin
                if (predict_valid && !train_valid) begin
                    index = predict_pc ^ history[(predict_pc - 1) % 8];
                    pht[index][0] <= pht[index][1] + train_taken;
                    pht[index][1] <= (pht[index][0] > pht[index][1]) ? pht[index][0] : pht[index][1];
                    history[(predict_pc + 7) % 8] <= predict_taken;
                end
            end
        end

        always @(posedge clk if (train_valid)) begin
            index = train_pc ^ history[(train_pc - 1) % 8];
            pht[index][0] <= pht[index][1] + train_taken;
            pht[index][1] <= (pht[index][0] > pht[index][1]) ? pht[index][0] : pht[index][1];
            if (train_mispredicted) begin
                history[(train_pc + 7) % 8] = train_taken ^ train_mispredicted;
            end
        end
    end
end
endmodule

// VERILOG-EVAL: abnormal backticks count
