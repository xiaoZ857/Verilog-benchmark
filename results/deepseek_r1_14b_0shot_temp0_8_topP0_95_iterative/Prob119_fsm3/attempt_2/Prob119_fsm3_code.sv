
always @(posedge clk or areset) begin
  if (areset) begin
    current_state <= A;
  end else begin
    current_state <= next_state;
  end
end

always @(current_state, in) begin
  case (current_state)
    A: 
      if (in == 0) 
        next_state = A;
      else 
        next_state = B;
    B: 
      if (in == 0) 
        next_state = C;
      else 
        next_state = B;
    C: 
      if (in == 0) 
        next_state = A;
      else 
        next_state = D;
    D: 
      if (in == 0) 
        next_state = C;
      else 
        next_state = B;
    default:
      next_state = A;  // default case
  endcase

  // Moore machine output depends only on current state
  case (current_state)
    A, B, C: out = 0;
    D: out = 1;
  endcase
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
