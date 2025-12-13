
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);
always @(posedge clk) begin
    if (areset) begin
        state <= 2'b01; // Reset to weakly not-taken when areset is high
    end else if (train_valid && train_taken) begin
        state <= state + 1; // Increment when both train_valid and train_taken are high
        if (state > 3'b11) state <= 3'b01; // Saturate at 3
    end else if (train_valid && !train_taken) begin
        if (state > 0) state <= state - 1; // Decrement when only train_valid is high and train_taken is low
        if (state < 2'b00) state <= 2'b00; // Saturate at 0
    end
end

// VERILOG-EVAL: endmodule not found
