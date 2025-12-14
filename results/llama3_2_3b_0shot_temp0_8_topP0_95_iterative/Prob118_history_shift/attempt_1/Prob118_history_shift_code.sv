
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

    // State of the history counter (i.e., how many instructions we've tracked)
    reg [7:0] history_counter;

    // Current value of the branch history register
    reg [31:0] train_history_register;
    assign predict_history = train_history_register[31:0];

    // Initialize the history register to a valid state (no history yet)
    always_ff @(posedge clk or negedge areset) begin
        if (!areset) begin
            train_history_register <= 0;
            history_counter <= 7;
        end else if (predict_valid && !train_mispredicted) begin
            // Shift in the branch prediction from the LSB side
            train_history_register[31] = predict_taken;
            history_counter <= history_counter + 1;
            if (history_counter == 32) begin
                // Clear the history register when we've tracked 32 instructions
                train_history_register <= '0;
                history_counter <= 7;
            end
        end else if (train_mispredicted) begin
            // Load the branch history register with the history after a misprediction
            train_history_register <= train_history[31:0];
            history_counter <= 7;
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
