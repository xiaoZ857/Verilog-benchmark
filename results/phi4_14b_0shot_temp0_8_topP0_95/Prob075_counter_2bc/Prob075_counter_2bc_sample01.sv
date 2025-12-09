
module TopModule (
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output reg [1:0] state
);

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset to weakly not-taken (2'b01)
        state <= 2'b01;
    end else if (train_valid) begin
        if (state == 2'b11 && train_taken) begin
            // Saturate at maximum value 3 (2'b11)
            state <= 2'b11;
        end else if (state == 2'b00 && !train_taken) begin
            // Saturate at minimum value 0 (2'b00)
            state <= 2'b00;
        end else if (train_taken) begin
            // Increment counter
            state <= state + 1;
        end else begin
            // Decrement counter
            state <= state - 1;
        end
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
