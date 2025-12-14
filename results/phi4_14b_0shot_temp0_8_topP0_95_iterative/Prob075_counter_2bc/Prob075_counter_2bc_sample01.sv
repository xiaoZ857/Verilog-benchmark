
module TopModule (
  input wire clk,
  input wire areset,
  input wire train_valid,
  input wire train_taken,
  output reg [1:0] state
);

  // Always block triggered by the positive edge of the clock or asynchronous reset
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      // Asynchronous reset to weakly not-taken, which is 2'b01
      state <= 2'b01;
    end else if (train_valid) begin
      if (state == 2'b11 && train_taken) begin
        // Saturate at maximum value (3)
        state <= 2'b11; 
      end else if (state == 2'b00 && !train_taken) begin
        // Saturate at minimum value (0)
        state <= 2'b00;
      end else if (train_taken) begin
        // Increment the counter
        state <= state + 1;
      end else begin
        // Decrement the counter
        state <= state - 1;
      end
    end
    // When train_valid = 0, do nothing and retain current state.
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
