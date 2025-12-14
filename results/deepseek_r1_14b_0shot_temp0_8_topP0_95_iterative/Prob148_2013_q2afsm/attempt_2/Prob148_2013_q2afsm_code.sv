
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output reg [3:1] g
);

  // State definitions
  parameter A = 0;
  parameter B = 1;
  parameter C = 2;
  parameter D = 3;

  // State flip-flops
  reg state;
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end

  // State table logic
  reg [3:1] g; // Grants for each device
  wire next_state;

  always @* begin
    g = 0;
    case (state)
      A: 
        if(r[1]) begin
          state_transitions.A_r1 = B;
        end else if(r[2]) begin
          state_transitions.A_r2 = C;
        end else if(r[3]) begin
          state_transitions.A_r3 = D;
        end else begin
          state_transitions.default_state = A;
        end

      B:
        if(r[1]) begin
          state_transitions.B_r1 = B;  // Self-loop on B
        end else begin
          state_transitions.B_else = A;
        end

      C:
        if(r[2]) begin
          state_transitions.C_r2 = C;  // Self-loop on C
        end else begin
          state_transitions.C_else = A;
        end

      D: 
        state_transitions.D = A;    // Always go back to A from D
    endcase

    // Priority-based grant assignment
    case (state)
      B: g[1] = 1;  // Highest priority if in B
      C: g[2] = 1;  // Next priority if in C
      default: g[3] = 1;  // Lowest priority if in D or A
    endcase
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
