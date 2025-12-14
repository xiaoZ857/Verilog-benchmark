
module TopModule (
  input clk, // Positive clock/clk triggered signal
  input a,
  input b,
  output reg [1:0] q, // Observable output state through the q wire
  output [9:0] state // Signal to read simulation waveforms
);

// Combinational logic to determine next state
localparam next_state = {a, b};

// Flip-flop to store current state
reg [1:0] state_reg;

always_ff @(posedge clk) begin
  case(next_state)
    2'b00: state_reg <= 2'b00;
    2'b01: state_reg <= 2'b10;
    2'b11: state_reg <= 2'b11;
    default: state_reg <= 2'b00;
  endcase

  // Update observable output q
  q <= state_reg;

  // Calculate observable output state
  case(state_reg)
    2'b00: state = 0; // State 0
    2'b01: state = 1; // State 1
    2'b11: state = 2; // State 2
    default: state = 3; // State 3 or unknown
  endcase
end

// Return observable output state
assign state = state;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
