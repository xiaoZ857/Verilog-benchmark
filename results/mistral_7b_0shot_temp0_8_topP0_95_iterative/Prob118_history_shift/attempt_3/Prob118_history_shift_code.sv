
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
always @(posedge clk) begin
    if (areset) begin
        reset_flag <= 1'b0;
        current_index <= 0;
        history <= 32'b0; // initialize the shift register to zeros
    end else if (!reset_flag && areset) begin
        // handle asynchronous reset by setting the flag and resetting the counter
        reset_flag = 1'b1;
        current_index <= 0;
        history <= 32'b0;
    end else begin
        if (predict_valid && !reset_flag) begin // make prediction
            history[current_index] <= predict_taken;
            current_index <= (current_index + 1) % 32;
        end
        if (train_mispredicted) begin // handle misprediction
            for (integer i = 0; i < 32; i++)
                if (i < current_index)
                    history[i] <= train_history[i];
            history[current_index] <= train_taken;
        end
    end
end

assign predict_history = history[31:0]; // output the current state of the history register

reg [31:0] history [31:0]; // Declare history as memory to resolve binding issue
reg reset_flag;
reg current_index;

endmodule
