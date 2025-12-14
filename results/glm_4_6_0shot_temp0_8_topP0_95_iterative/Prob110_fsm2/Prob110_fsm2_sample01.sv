
module TopModule (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  // Define the states
  parameter OFF = 1'b0;
  parameter ON = 1'b1;
  
  // State register
  reg state;
  
  // State transition logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= OFF;
    end else begin
      case (state)
        OFF: begin
          if (j)
            state <= ON;
          else
            state <= OFF;
        end
        ON: begin
          if (k)
            state <= OFF;
          else
            state <= ON;
        end
        default: state <= OFF;
      endcase
    end
  end
  
  // Output logic (Moore machine - output depends only on current state)
  assign out = state;

endmodule
