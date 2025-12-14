
module TopModule (
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output reg [1:0] state // Using reg for positive edge-triggered assignments
);

always @(posedge clk) begin
    if (areset) begin
        state <= 2'b01; // Asynchronous reset sets counter to weakly not-taken (2'b01)
    end else if (train_valid && train_taken) begin
        state <= state + 1; // Increment counter up to maximum of 3
        if (state > 3'b11) state <= 3'b11; // Saturating at maximum value
    end else if (train_valid && !train_taken) begin
        state <= state - 1; // Decrement counter down to minimum of 0
        if (state < 2'b00) state <= 2'b00; // Saturating at minimum value
    end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
