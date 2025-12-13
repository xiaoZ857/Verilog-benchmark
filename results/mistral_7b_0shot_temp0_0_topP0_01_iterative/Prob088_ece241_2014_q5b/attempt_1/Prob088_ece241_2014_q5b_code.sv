
module TopModule (
  input wire clk,
  input wire areset,
  input wire x,
  output reg z
);

// One-hot encoding for states A and B
reg [1:0] state;
always @(posedge clk or negedge areset) begin
  if (areset) begin
    state <= 2'b00; // Reset to state A
  end else if (state == 2'b01) begin // State B
    if (x == 1'b1) begin
      state <= 2'b00; // Transition back to state A
      z <= 1'b0; // Output z = 0
    end
  end

  assign z = state == 2'b01 ? 1'b1 : 1'b0; // Assign output z based on current state
end

// Initialization block for synthesis tools
initial begin
  state <= 2'b00; // Initialize state to A at time 0
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
