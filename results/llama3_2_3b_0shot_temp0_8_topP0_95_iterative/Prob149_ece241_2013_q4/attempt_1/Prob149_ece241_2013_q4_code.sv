
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg [0:2] fr3, // fr3[0]: highest sensor not asserted; fr3[1]: lowest sensor not asserted
  output reg [0:2] fr2, 
  output reg [0:3] fr1, // fr1[0]: lowest sensor not asserted
  output reg dfr
);

reg [3:0] state; // State machine state

always @(posedge clk) begin
  if (reset) begin
    state <= 4'h0000; // Reset to a state equivalent to if the water level had been low for a long time
  end else begin
    case (state)
      4'h0000: // All sensors not asserted, all outputs asserted
        state <= s[3] ? 0 : 1;
      0:
        state <= s[3] ? 2 : 0; // Highest sensor not asserted if no change, so next state is the same as if no sensors were asserted
      1: // Lowest sensor not asserted
        state <= s[1] ? 0 : 4'h0000; // If a sensor is now asserted that was previously not, reset to low state
      2:
        state <= ~s[3] && s[1] ? 3 : 4'h0000; // If the lowest sensor is now not asserted but previous level was lower than current, next state depends on whether the highest sensor is asserted or not
      3:
        if (~s[3]) begin // Highest sensor not asserted and all sensors before it are asserted
          fr1 <= {fr2, fr3}; // Same flow rates as when lowest sensor is not asserted
          fr2 <= {fr1, fr3};
          dfr <= 0; // No supplemental flow valve needed
        end else if (s[2]) begin // If highest sensor is now asserted, switch to a state that needs no flow rate adjustment
          state <= 4'h0000;
        end else if (~s[3] && s[1]) begin // If lowest sensor is not asserted but previous level was lower than current, adjust flow rates based on highest sensor and supplemental valve needed
          fr2[0] = ~fr1[0]; // Increase flow rate by opening supplemental valve when water level goes from below to between
          dfr <= 1;
        end else begin // If a change in the water level doesn't require adjusting flow rates, just update state
          state <= s[3] ? 2 : 0; // Highest sensor not asserted if no change, so next state is the same as if no sensors were asserted
        end
    endcase
  end
end

always @(posedge clk) begin
  fr3 <= {fr1[0], 1'b0};
  fr2 <= {fr1[1], fr3[0]};
end

// Add signals for flow rates to be asserted when a sensor is not asserted, or use the state variables directly
assign fr3 = ~s[3] ? '1: '0;
assign fr2 = s[2] ? '1: 0;
assign fr1 = s[1] ? '1: 0;

endmodule // TopModule

// VERILOG-EVAL: errant inclusion of module definition
