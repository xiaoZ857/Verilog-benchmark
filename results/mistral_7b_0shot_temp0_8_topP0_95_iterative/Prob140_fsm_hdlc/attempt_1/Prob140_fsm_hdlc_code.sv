
module TopModule (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err
);

reg [5:0] current_state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    current_state <= 0; // Reset state to 0
  end else begin
    case(current_state)
      0: begin
        if (in == 1'b1) begin
          current_state <= 1; // First bit of a sequence
        end
      end,
      1: begin
        if (in == 1'b0) begin
          current_state <= 2; // First 0 after sequence start
        end else if(in == 1'b1) begin
          current_state <= [5:0]current_state + 1; // Continue counting
        end
      end,
      6: begin
        if (in == 1'b0) begin
          current_state <= 7; // First 0 after 7 consecutive 1s
        end
      end,
      7: begin
        err <= 1'b1; // Error state
        current_state <= 8; // Reset error state
      end,
      _: current_state <= current_state; // Ignore invalid states
    endcase
  end

  assign disc = (current_state == 5); // Discard bit when in sequence 5
  assign flag = ((current_state == 6) || (current_state == 11)); // Flag beginning or end of frame
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
