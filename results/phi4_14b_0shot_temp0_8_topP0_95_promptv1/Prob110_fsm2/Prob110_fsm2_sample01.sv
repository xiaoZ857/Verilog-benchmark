
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);
  reg [1:0] state, next_state;
  wire j, k;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00; // OFF state
    else
      state <= next_state;
  end

  always @(*) begin
    case (state)
      2'b00: begin // OFF state
        out = 1'b0;
        if (j)
          next_state = 2'b01; // Transition to ON state
        else
          next_state = 2'b00; // Remain in OFF state
      end
      2'b01: begin // ON state
        out = 1'b1;
        if (k)
          next_state = 2'b00; // Transition to OFF state
        else
          next_state = 2'b01; // Remain in ON state
      end
      default: begin
        out = 1'b0;
        next_state = 2'b00; // Default to OFF state
      end
    endcase
  end

endmodule
