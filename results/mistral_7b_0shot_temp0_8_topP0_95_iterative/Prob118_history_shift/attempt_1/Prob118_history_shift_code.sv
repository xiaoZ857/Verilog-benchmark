
module TopModule (
    input wire clk,
    input wire areset,
    input wire predict_valid,
    input wire predict_taken,
    output logic [31:0] predict_history,

    input wire train_mispredicted,
    input wire train_taken,
    input [31:0] train_history
);

reg [31:0] history [32]; // 32-bit shift register for the history
reg reset_flag; // flag to handle asynchronous reset
reg current_index; // index of current element in the shift register

always @(posedge clk) begin
    if (areset) begin
        reset_flag <= 1'b0;
        current_index <= 0;
        history <= 32{0}; // initialize the shift register to zeros
    end else if (!reset_flag && areset) begin
        // handle asynchronous reset by setting the flag and resetting the counter
        reset_flag <= 1'b1;
        current_index <= 0;
        history <= 32{0};
    end else begin
        if (predict_valid && !reset_flag) begin // make prediction
            history[current_index] <= predict_taken;
            current_index <= (current_index + 1) % 32;
        end
        if (train_mispredicted) begin // handle misprediction
            history[0:(current_index - 1)] <= train_history[(current_index - 1):0];
            history[current_index] <= train_taken;
        end
    end
end

assign predict_history = history[31:0]; // output the current state of the history register

endmodule

// VERILOG-EVAL: errant inclusion of module definition
