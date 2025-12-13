
module TopModule (
  input clk,
  input reset,
  input [3:1] s,
  output reg fr3,
  output reg fr2,
  output reg fr1,
  output reg dfr
);

// Define the nominal flow rates for each water level
parameter NOMINAL_FLOW_RATES = {0, fr1, fr1 + fr2, fr1 + fr2 + fr3};

// Define the state variables and their initial values
reg [2:0] currentState, previousState;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    currentState <= 3'b000; // Reset to no sensors asserted state
    fr1 <= 0;
    fr2 <= 0;
    fr3 <= 0;
    dfr <= 0;
  end else begin
    previousState <= currentState;

    // Determine the current water level based on the asserted sensors
    if (s[3]) begin
      currentState <= 3'b100; // Water level above s[3]
      fr1 <= 0;
      fr2 <= 0;
      fr3 <= 0;
      dfr <= 0;
    end else if (s[2] && !s[3]) begin
      currentState <= 3'b010; // Water level between s[3] and s[2]
      fr1 <= NOMINAL_FLOW_RATES[currentState];
      fr2 <= 0;
      fr3 <= 0;
      dfr <= 0;
    end else if (s[1] && !s[2]) begin
      currentState <= 3'b001; // Water level between s[2] and s[1]
      fr1 <= NOMINAL_FLOW_RATES[currentState];
      fr2 <= NOMINAL_FLOW_RATES[previousState];
      fr3 <= 0;
      if (s[1] != previousState[1]) dfr <= 1'b1; // Open supplemental flow valve if level increased
    end else begin
      currentState <= 3'b000; // Water level below s[1]
      fr1 <= NOMINAL_FLOW_RATES[currentState];
      fr2 <= NOMINAL_FLOW_RATES[previousState];
      fr3 <= NOMINAL_FLOW_RATES[previousState + 1]; // Include supplemental flow rate
      dfr <= 1'b1; // Always open supplemental flow valve when water level is below s[1]
    end
  end
end

// Output the flow rates and dfr based on the current state
assign fr3 = currentState == 3'b000 ? NOMINAL_FLOW_RATES[currentState] : (currentState == 3'b001 ? NOMINAL_FLOW_RATES[currentState] + NOMINAL_FLOW_RATES[currentState - 1] : NOMINAL_FLOW_RATES[currentState] + NOMINAL_FLOW_RATES[currentState - 1] + NOMINAL_FLOW_RATES[currentState - 2]);
assign fr2 = currentState == 3'b000 ? 0 : (currentState == 3'b001 ? NOMINAL_FLOW_RATES[currentState - 1] : NOMINAL_FLOW_RATES[currentState - 1] + NOMINAL_FLOW_RATES[currentState - 2]);
assign fr1 = currentState == 3'b000 ? 0 : NOMINAL_FLOW_RATES[currentState];
assign dfr = currentState != previousState ? 1'b1 : 1'b0;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
