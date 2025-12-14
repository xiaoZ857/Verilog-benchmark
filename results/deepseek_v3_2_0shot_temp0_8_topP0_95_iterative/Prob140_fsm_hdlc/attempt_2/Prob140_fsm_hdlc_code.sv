
module TopModule (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err
);
  // State definitions
  localparam S0     = 4'd0,
             S1     = 4'd1,
             S2     = 4'd2,
             S3     = 4'd3,
             S4     = 4'd4,
             S5     = 4'd5,
             S6     = 4'd6,
             S_err  = 4'd7,
             S_disc = 4'd8,
             S_flag = 4'd9;

  reg [3:0] state, next_state;

  // State register
  always @(posedge clk) begin
    if (reset)
      state <= S0;
    else
      state <= next_state;
  end

  // Next state logic
  always @(*) begin
    case (state)
      S0: next_state = in ? S1 : S0;
      S1: next_state = in ? S2 : S0;
      S2: next_state = in ? S3 : S0;
      S3: next_state = in ? S4 : S0;
      S4: next_state = in ? S5 : S0;
      S5: next_state = in ? S6 : S_disc;
      S6: next_state = in ? S_err : S_flag;
      S_err: next_state = in ? S_err : S0;
      S_disc: next_state = S0;
      S_flag: next_state = S0;
      default: next_state = S0;
    endcase
  end

  // Output logic (Moore)
  assign disc = (state == S_disc);
  assign flag = (state == S_flag);
  assign err  = (state == S_err);

endmodule
