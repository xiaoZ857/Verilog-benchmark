
module TopModule (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output logic [1:0] state
);

always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= 2'b01;
  end else if (train_valid) begin
    if (train_taken) begin
      // Increment, but saturate at 3
      if (state != 2'b11) begin
        state <= state + 1;
      end
    end else begin
      // Decrement, but saturate at 0
      if (state != 2'b00) begin
        state <= state - 1;
      end
    end
  end
  // When train_valid = 0, state remains unchanged
end
endmodule
