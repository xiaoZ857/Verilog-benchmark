
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);

  // Define states
  typedef enum reg {S0, S1, S2, S3, S4} state_t;
  state_t current_state, next_state;

  // Output logic
  assign start_shifting = (current_state == S4);

  // State transition logic
  always @(posedge clk) begin
    if (reset)
      current_state <= S0;
    else
      current_state <= next_state;
  end

  // Next state logic
  always @(current_state, data) begin
    case (current_state)
      S0: begin
        if (data)
          next_state = S1;
        else
          next_state = S0;
      end
      S1: begin
        if (data)
          next_state = S2;
        else
          next_state = S0;
      end
      S2: begin
        if (data)
          next_state = S0;
        else
          next_state = S3;
      end
      S3: begin
        if (data)
          next_state = S4;
        else
          next_state = S0;
      end
      S4: next_state = S

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
