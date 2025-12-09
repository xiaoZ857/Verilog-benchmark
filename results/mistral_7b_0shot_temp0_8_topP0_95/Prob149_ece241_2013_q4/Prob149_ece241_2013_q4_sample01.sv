
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
parameter NOMINAL_FLOW_RATE = 1; // You can adjust this value as needed
parameter STATE_RESET = 4'b0000; // Active-high synchronous reset state
parameter STATE_LOW = 4'b1000;   // State for water level below s[1]
parameter STATE_BETWEEN2_1 = 4'b1010; // State for water level between s[2] and s[1]
parameter STATE_BETWEEN3_2 = 4'b1100; // State for water level between s[3] and s[2]

always @(posedge clk or posedge reset) begin
  if (reset) begin
    fr3 <= 0;
    fr2 <= 0;
    fr1 <= 0;
    dfr <= 0;
  end else if (s == STATE_RESET) begin
    fr3 <= NOMINAL_FLOW_RATE;
    fr2 <= NOMINAL_FLOW_RATE;
    fr1 <= NOMINAL_FLOW_RATE;
    dfr <= 0;
  end else if (s[3]) begin
    fr3 <= 0;
    fr2 <= 0;
    fr1 <= 0;
    dfr <= 0;
  end else if (s[2] && !s[3]) begin
    fr3 <= NOMINAL_FLOW_RATE + (dfr ? NOMINAL_FLOW_RATE : 0);
    fr2 <= NOMINAL_FLOW_RATE;
    fr1 <= NOMINAL_FLOW_RATE;
    dfr <= 0;
  end else if (!s[1] && !s[2]) begin
    fr3 <= NOMINAL_FLOW_RATE + (dfr ? NOMINAL_FLOW_RATE : 0);
    fr2 <= NOMINAL_FLOW_RATE + (dfr ? NOMINAL_FLOW_RATE : 0);
    fr1 <= NOMINAL_FLOW_RATE;
    dfr <= 1;
  end else if (!s[1] && s[2]) begin
    fr3 <= NOMINAL_FLOW_RATE + (dfr ? NOMINAL_FLOW_RATE : 0);
    fr2 <= NOMINAL_FLOW_RATE;
    fr1 <= NOMINAL_FLOW_RATE;
    dfr <= 0;
  end
end

always @(posedge clk) begin
  if (!dfr && s[1]) begin
    case (s)
      4'b1001: fr3 <= NOMINAL_FLOW_RATE + (dfr ? NOMINAL_FLOW_RATE : 0); // Between s[2] and s[1]
      4'b1011: fr3 <= NOMINAL_FLOW_RATE;                              // Above s[3]
      default: fr3 <= NOMINAL_FLOW_RATE + (dfr ? NOMINAL_FLOW_RATE : 0); // Below s[1] or other states
    endcase
  end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
