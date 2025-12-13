
module TopModule (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  reg [2:0] state, next_state;
  localparam S_A = 3'b001,
             S_B = 3'b010,
             S_C = 3'b100;
  
  // State flip-flops with synchronous reset
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
      default: next_state = S_A;
    endcase
  end
  
  // Output logic
  assign g[1] = (state == S_B);
  assign g[2] = (state == S_C);
  assign g[3] = (state == S_A) && (r[3]==1) && (r[1]==0) && (r[2]==0);
endmodule
