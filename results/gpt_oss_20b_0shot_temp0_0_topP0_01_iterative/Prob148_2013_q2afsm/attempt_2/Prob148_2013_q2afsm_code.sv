
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  // State encoding
  localparam [1:0] STATE_A = 2'b00,
                   STATE_B = 2'b01,
                   STATE_C = 2'b10,
                   STATE_D = 2'b11;

  // State register
  reg [1:0] state, next_state;

  // State transition logic (combinational)
  always_comb begin
    // Default next state is current state
    next_state = state;

    case (state)
      STATE_A: begin
        if (r[1])          next_state = STATE_B;   // priority 1
        else if (r[2])     next_state = STATE_C;   // priority 2
        else if (r[3])     next_state = STATE_D;   // priority 3
        else               next_state = STATE_A;   // no request
      end

      STATE_B: begin
        // In state B, device 1 is granted (g1=1)
        if (r[1])          next_state = STATE_B;   // keep grant while request active
        else               next_state = STATE_A;   // release grant when request ends
      end

      STATE_C: begin
        // In state C, device 2 is granted (g2=1)
        if (r[2])          next_state = STATE_C;   // keep grant while request active
        else               next_state = STATE_A;   // release grant when request ends
      end

      STATE_D: begin
        // In state D, device 3 is granted (g3=1)
        if (r[3])          next_state = STATE_D;   // keep grant while request active
        else               next_state = STATE_A;   // release grant when request ends
      end

      default: next_state = STATE_A;
    endcase
  end

  // State register update (synchronous reset)
  always_ff @(posedge clk) begin
    if (!resetn)          state <= STATE_A;   // active‑low synchronous reset
    else                  state <= next_state;
  end

  // Output logic

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
