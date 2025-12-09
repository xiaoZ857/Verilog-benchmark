
module TopModule (
    input clk, // Positive edge triggered clock
    input areset, // Asynchronous reset
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,

    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
) {
    // Global History Shift Register (32-bit)
    reg [1:0][31:0] history_counter;
    reg [31:0] train_history_copy;

    // Asynchronous Reset Logic
    always_ff @(*) begin
        if (areset) begin
            history_counter <= 2'd0; // Reset to zero
            train_history_copy <= 32'd0; // Reset to zero
        end else begin
            // No action for areset
        end
    end

    // Pipeline Flush Logic
    always_ff @(*) begin
        if (train_mispredicted) begin
            train_history_copy <= train_history;
        end else if (predict_valid && !train_taken && history_counter[1] == 2'd0) begin
            // Predicted branch did not take, shift in train_history and update predict_history
            train_history_copy <= {31: 0, train_history};
            predict_history <= {32'h0, predict_history[31:1]};
        end else if (predict_valid && history_counter[1] != 2'd0) begin
            // Predicted branch took, shift in and update predict_history
            predict_history <= {32'h0, predict_history[31:1], train_taken};
        end else if (!train_taken && history_counter[1] == 2'd0) begin
            // Taken branch did not take, no action
        end
    end

    always_ff @(*) begin
        if (clk) begin
            // Update history counter
            if (predict_valid) begin
                history_counter <= {history_counter[1:0], 32'h0}; // Shift right, fill with zero on the left
            end else if (train_mispredicted && train_taken) begin
                history_counter <= {31'd0, history_counter[1:2]}; // Left shift and fill with zero on the right
            end else if (!train_taken && !predict_taken) begin
                history_counter <= {history_counter[1], history_counter[0]}; // Swap positions
            end
        end else begin
            // No action for the falling edge
        end
    end

    assign predict_history = train_history_copy;
}

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
