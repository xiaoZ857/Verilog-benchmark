
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);
always @(posedge clk or posedge reset) begin
  if (reset) begin
    fr1 <= 0;
    fr2 <= 0;
    fr3 <= 0;
    dfr <= 0;
    currentState <= 3'b000; // Reset to no sensors asserted state
  end else begin
    previousState <= currentState;

    // Determine the current water level based on the asserted sensors
    if (s[3]) begin
      currentState <= 3'b100; // Water level above s[3]
    end else if (s[2] && !s[3]) begin
      currentState <= 3'b010; // Water level between s[3] and s[2]
    end else if (s[1] && !s[2]) begin
      currentState <= 3'b001; // Water level between s[2] and s[1]
    end else begin
      currentState <= 3'b000; // Water level below s[1]
    end

    fr1 = NOMINAL_FLOW_RATES[currentState];
    fr2 = currentState == 3'b001 ? NOMINAL_FLOW_RATES[currentState - 1] : 0;
    fr3 = currentState == 3'b000 ? (currentState == 3'b001 ? NOMINAL_FLOW_RATES[currentState] + NOMINAL_FLOW_RATES[currentState - 1] : NOMINAL_FLOW_RATES[currentState] + NOMINAL_FLOW_RATES[currentState - 2]) : (currentState == 3'b001 ? NOMINAL_FLOW_RATES[currentState] + NOMINAL_FLOW_RATES[currentState - 1] : NOMINAL_FLOW_RATES[currentState]);
    dfr = currentState != previousState ? 1'b1 : 1'b0;
  end
end

// Output the flow rates and dfr based on the current state
assign fr3 = reg fr3; // Make fr3 a register to match the declaration
assign fr2 = reg fr2; // Make fr2 a register to match the declaration
assign fr1 = reg fr1; // Make fr1 a register to match the declaration
assign dfr = reg dfr; // Make dfr a register to match the declaration

// VERILOG-EVAL: endmodule not found
