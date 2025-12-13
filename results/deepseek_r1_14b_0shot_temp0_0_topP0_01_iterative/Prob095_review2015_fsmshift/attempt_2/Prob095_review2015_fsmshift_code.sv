
// Parameters define state machine states
`define S0 0
`define S1 1
`define S2 2
`define S3 3
`define S4 4

module TopModule (
  input clk,
  input reset,
  output shift_ena
);

  // State storage flip-flops
  reg [2:0] current_state;  // 3 bits for states 0-4
  reg [2:0] next_state;

  // State transition logic
  always @(posedge clk) begin
    if (reset) begin
      current_state <= `S1;
    end else begin
      current_state <= next_state;
    end
  end

  // Next state and output logic
  always begin
    case (current_state)
      `S0:
        next_state = reset ? `S1 : `S0;
        shift_ena = 0;
      `S1:
        next_state = `S2;
        shift_ena = 1;
      `S2:
        next_state = `S3;
        shift_ena = 1;
      `S3:
        next_state = `S4;
        shift_ena = 1;
      `S4:
        next_state = `S0;
        shift_ena = 1;
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
