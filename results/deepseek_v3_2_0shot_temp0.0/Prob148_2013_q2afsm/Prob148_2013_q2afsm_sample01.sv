
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  reg [3:0] state, next_state;
  
  // State encoding
  localparam S_A = 4'b0001,
             S_B = 4'b0010,
             S_C = 4'b0100,
             S_D = 4'b1000;
  
  // State flip-flops with synchronous active-low reset
  always @(posedge clk) begin
    if (!resetn)
      state <= S_A;
    else
      state <= next_state;
  end
  
  // Next state logic
  always @(*) begin
    case (state)
      S_A: begin
        if (r[1])
          next_state = S_B;
        else if (r[2])
          next_state = S_C;
        else if (r[3])
          next_state = S_D;
        else
          next_state = S_A;
      end
      S_B: begin
        if (r[1])
          next_state = S_B;
        else
          next_state = S_A;
      end
      S_C: begin
        if (r[2])
          next_state = S_C;
        else
          next_state = S_A;
      end
      S_D: begin
        if (r[3])
          next_state = S_D;
        else
          next_state = S_A;
      end
      default: next_state = S_A;
    endcase
  end
  
  // Output logic: g[i] = 1 when in corresponding state
  assign g[1] = (state == S_B);
  assign g[2] = (state == S_C);
  assign g[3] = (state == S_D);

// VERILOG-EVAL: endmodule not found
