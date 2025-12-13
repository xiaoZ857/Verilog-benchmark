
module TopModule (
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output logic [1:0] state
);

    // Always block for handling the asynchronous reset and synchronous operations
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to weakly not-taken (2'b01)
            state <= 2'b01;
        end else if (train_valid) begin
            if (state == 2'b11 && train_taken) begin
                // Saturate at maximum value (3 or 2'b11), do nothing on increment
                state <= 2'b11;
            end else if (state == 2'b00 && !train_taken) begin
                // Saturate at minimum value (0 or 2'b00), do nothing on decrement
                state <= 2'b00;
            end else if (train_taken) begin
                // Increment the counter
                state <= state + 1;
            end else begin
                // Decrement the counter
                state <= state - 1;
            end
        end
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
